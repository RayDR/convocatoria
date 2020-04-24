<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Convocatoria extends CI_Controller {

	private $template	= 'template/';
	private $contenido	= 'template/body';

	public function __construct(){
		parent::__construct();

		$this->load->model('Model_convocatoria');
		$this->load->model('Model_catalogos');
	}

	public function index(){
		$this->session->sess_destroy();
		$data=array(
			'tituloPagina'		=>	'CONVOCATORIA DOCENTE',
			'template'			=>	$this->template,
			'view'				=>	'index'
		);
		$this->load->view( $this->contenido, $data );
	}

	public function registro(){
		$data=array(
			'tituloPagina'		=>	'CARGA DE DOCUMENTOS',
			'template'			=>	$this->template,
			'view'				=>	'convocatoria/registro',
			'tipos_documentos'	=>	$this->Model_catalogos->get_tipos_documentos(),
			'datos'				=>	$this->Model_convocatoria->get_datos(),
			'documentos'		=>	$this->Model_convocatoria->get_documentos(),
			'sedes'				=>	$this->get_sedes(),
			'sedes_escogidas'	=>	$this->get_sedes_escogidas()
		);
		$this->load->view( $this->contenido, $data );
	}

	public function salir(){
		$this->session->sess_destroy();
	}

	/** ************************* FUNCIONES AJAX ************************* **/

	public function ingresar(){
		$curp = $this->input->post('curp');
		$resultado = array(
			'exito'		=>	FALSE,
			'mensaje'	=>	''
		); 

		$g_response = $this->input->post('response');

		if ( ! is_null( $g_response ) || $g_response != "" ){

			$captcha = file_get_contents( "https://www.google.com/recaptcha/api/siteverify?secret=6Ld5vd4UAAAAANMWmo23sijbp2-weErV9Xw6KZp7&response=".$g_response."&remoteip=".$_SERVER['REMOTE_ADDR'] );
			$captcha =  json_decode($captcha);

			if ( $captcha->success ){
				if ( ! is_null($curp) ){
					if ( $this->_validar_curp( $curp ) ){

						$this->_crear_session( $curp );
						$resultado["exito"] = TRUE;
					} else
						$resultado["mensaje"] = "La CURP ingresada no cumple con la estructura requerida.";
				} else
					$resultado["mensaje"] = "CURP inválida";
			} else 
				$resultado["mensaje"] = "Por favor, marque correctamente la casilla de verificación.";
				
		} else 
			$resultado["mensaje"] = "Por favor, marque correctamente la casilla de verificación.";
		

		header('Content-Type', 'application/json');
		print( json_encode($resultado) );
		return;
	}

	public function actualiza_datos(){
		$this->_guardar_datos_maestro();
	}

	public function cargar_documento(){
		$curp = $this->session->userdata('curp');
		$path = './sources/doctos/' . $curp . '/';

		$resultado = array(
			'exito'		=>	TRUE,
			'mensaje'	=>	'',
			'tipo'		=>	''
		); 

		if ( !file_exists( $path ) ) 
		    mkdir( $path, 0777, true );

		$cve_doc = $this->Model_catalogos->get_tipo_documento( $this->input->post('documentos') );

		$config['upload_path']   = $path;
		$config['allowed_types'] = 'pdf';
		$config['max_size']      = ($cve_doc == 'DCPT')? 8192 : 2048;
		$config['overwrite']     = TRUE;
		
		if ( ! is_null($cve_doc) ){

			$nombreArchivo = $curp."_".$cve_doc.'.pdf';

			$config['file_name'] = $nombreArchivo;

			$datos_documentos = array(
				'documento_id'			=>		$this->input->post('documentos'),
				'archivo'				=>		$nombreArchivo
			);
			$this->load->library( 'upload', $config );

			if ( ! $this->upload->do_upload( 'archivo' ) ) {
				$error = $this->upload->display_errors();
				$resultado["mensaje"] = $error;
				$resultado["exito"] = FALSE;
			} else {
				$data = $this->upload->data();
				$this->Model_convocatoria->registrar_documento($datos_documentos);
				$resultado["mensaje"] = "El documento se cargó correctamente";
			}
		} else {
			$resultado["mensaje"] = 'Por favor, verifique el documento seleccionado.';
			$resultado["exito"] = FALSE;
		}

		header('Content-Type', 'application/json');
		print( json_encode($resultado) );
		return;
	}

	public function comprobar_documento_cargado(){
		$json['existe'] = $this->_comprueba_documento();
		header('Content-Type', 'application/json');
		print( json_encode($json) );
		return;
	}

	public function get_documentos(){
		$json = $this->Model_convocatoria->get_documentos();
		header('Content-Type', 'application/json');
		print( json_encode($json) );
		return;

	}

	public function guardar_maestro_sede(){
		$json["exito"] = FALSE;

		$datos_maestro_sede = $this->input->post('sedes');

		if ( $this->_registra_maestro_sede( $datos_maestro_sede ) ) 
			$json["exito"] = TRUE;

		header('Content-Type', 'application/json');
		print( json_encode($json) );
		return;
	}

	/** ************************* FUNCIONES PRIVADAS ************************* **/

	// Registra al usuario y/o obtiene su ID
	private function _crear_session($curp){
		$exito = FALSE;

		// Registrar si no existe
		if ( $this->Model_convocatoria->registrar_curp( $curp ) ){
			// Obtener ID
			$maestro_id = $this->Model_convocatoria->get_maestro_id( $curp );

			if ( $maestro_id != -1 ){
				$array = array(
					'uid' 	=> 	$maestro_id,
					'utipo' 	=> 	'Estudiante',
					'curp'	=>		$curp,
					'uLogin'	=> 	TRUE,
				);
				
				$this->session->set_userdata( $array );		
				$exito = TRUE;
			}
		}
		return $exito;
	}

	private function _validar_curp($curp){
		$exito = FALSE;
		if( preg_match("/^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$/", $curp ) )
			$exito = TRUE;

		return $exito;
	}

	private function _guardar_datos_maestro(){
		$datos = array(
			'nombres'	=>	$this->input->post('nombres'),
			'paterno'	=>	$this->input->post('paterno'),
			'materno'	=>	$this->input->post('materno')
		);

		$this->Model_convocatoria->actualiza_datos( $datos );
	}

	private function _registra_maestro_sede($datos){
		return $this->Model_convocatoria->registra_maestro_sede($datos);
	}

	private function _comprueba_documento(){
		$documento = $this->input->post('documento');
		return $this->Model_convocatoria->comprueba_documento($documento);
	}

	private function get_sedes(){
		return $this->Model_convocatoria->get_sedes();
	}

	private function get_sedes_escogidas(){
		return $this->Model_convocatoria->get_sedes_maestro();
	}
}	

/* End of file Convocatoria.php */
/* Location: ./application/controllers/Convocatoria.php */