<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Administrador extends CI_Controller {

	private $template	= 'template/';
	private $contenido	= 'template/body';

	public function __construct(){
		parent::__construct();

		$this->load->model('Model_convocatoria');
		$this->load->model('Model_catalogos');
	}

	/** *******************  VISTAS  ****************** **/

	public function index(){
		$this->session->sess_destroy();
		$this->session->set_userdata( array('mAdmin' => TRUE) );
		$data=array(
			'tituloPagina'		=>	'ADMINISTRACIÓN',
			'template'			=>	$this->template,
			'view'				=>	'admin/acceso'
		);
		$this->load->view( $this->contenido, $data );
	}

	public function panel_administrador(){
		if ( $this->session->userdata('utipo') != 'Admin' ){
			header("Location: ". base_url() . 'index.php/Convocatoria');
			return;
		}

		$data=array(
			'tituloPagina'		=>	'ADMINISTRACIÓN',
			'template'			=>	$this->template,
			'view'				=>	'admin/panel_admin'
		);
		$this->load->view( $this->contenido, $data );
	}

	/** ********************  AJAX  ******************* **/

	public function ingresar(){
		$respuesta["exito"] = TRUE;
		$password = $this->input->post('clave');
		if ( $password == 'Convoca_MS20.')
			$this->_crear_session();
		else
			$respuesta["exito"] = FALSE;
		echo( json_encode($respuesta));
		return;
	}

	public function salir(){
		$this->session->sess_destroy();
		header("Location: ". base_url() . 'index.php/Administrador');
	}

	public function datatable_maestros(){
		if ( $this->session->userdata('utipo') != 'Admin' ){
			header("Location: ". base_url() . 'index.php/Convocatoria');
			return;
		}
		$resultado = $this->Model_convocatoria->datatable_maestros();
		print( json_encode($resultado) );
		return;
	}

	public function preprarar_descarga_zip(){
		if ( $this->session->userdata('utipo') != 'Admin' ){
			header("Location: ". base_url() . 'index.php/Convocatoria');
			return;
		}

		$curp = $this->input->post('curp');		
		$respuesta["exito"] = FALSE;

		// Validar que tenga documentos
		if ( $this->Model_convocatoria->contar_documentos($curp) > 0 ){
			$respuesta["exito"] = TRUE;
		}
		print( json_encode($respuesta) );
		return;
	}

	public function descargar_zip($curp){
		if ( $this->session->userdata('utipo') != 'Admin' ){
			header("Location: ". base_url() . 'index.php/Convocatoria');
			return;
		}
		
		$this->_generar_zip($curp);
	}

	/** ************** FUNCIONES PRIVADAS ************* **/
	private function _generar_zip($curp){
		if ( $this->session->userdata('utipo') != 'Admin' ){
			header("Location: ". base_url() . 'index.php/Convocatoria');
			return;
		}
		
		$exito = array('exito' => FALSE);
		$rutaZip = "sources/doctos/";
		$directorio = $rutaZip . $curp . '/';
		$nombreZip = $curp . ".zip";

		if ( ! file_exists( $rutaZip ) ){
			return $exito;
		}
		else {
			$zip = new ZipArchive;
			if($zip -> open($rutaZip . $nombreZip, (ZipArchive::CREATE | ZipArchive::OVERWRITE)  ) === TRUE) {
				// Agrega el directorio completo al zip
				// $dir = opendir($directorio); 
				// while($file = readdir($dir)) { 
				// 	if(is_file($directorio.$file)) { 
				// 		$zip -> addFile($directorio.$file, $file); 
				// 	} 
				// }
				$documentos_curp = $this->Model_catalogos->get_documentos_curp($curp);
				if ( $documentos_curp != null ){
					// Crear Directorios
					foreach ($documentos_curp as $docto) {
						$zip->addEmptyDir( $docto["descripcion_clasif"] );
					}
					// Asignar archivos a directorios
					$curr_dir = "";
					foreach ($documentos_curp as $docto) {
						$curr_dir = $docto["descripcion_clasif"];
						$rutaArchivo = $directorio . $docto["archivo"];
						if( file_exists( $rutaArchivo ) ){
							$rutaArchivoZip =  $curr_dir . "/" . $docto["archivo"];
							$zip -> addFile( $rutaArchivo, $rutaArchivoZip ); 
						} 
					}
				}else{
					$zip ->close();
					return FALSE; 
				}
				$zip ->close(); 
			}
		}
		header("Content-type: application/zip"); 
		header("Content-Disposition: attachment; filename=$nombreZip"); 
		header("Pragma: no-cache"); 
		header("Expires: 0"); 
		readfile($rutaZip . "$nombreZip");

		return;
	}

	// Acceder como administrador
	private function _crear_session(){
		$array = array(
			'utipo' 	=> 'Admin',
			'uLogin'	=>	TRUE
		);
		
		$this->session->set_userdata( $array );
	}

}

/* End of file Administrador.php */
/* Location: ./application/controllers/Administrador.php */