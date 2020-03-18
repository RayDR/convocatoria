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
		$data=array(
			'tituloPagina'		=>	'ADMINISTRACIÓN',
			'template'			=>	$this->template,
			'view'				=>	'admin/acceso'
		);
		$this->load->view( $this->contenido, $data );
	}

	public function panel_administrador(){
		if ( $this->session->userdata('utipo') != 'Admin' )
			header("Location: ". base_url() . 'index.php/Convocatoria');
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
		if ( $password == 'SeConvoca2020.')
			$this->_crear_session();
		else
			$respuesta["exito"] = FALSE;
		echo( json_encode($respuesta));
		return;
	}

	public function datatable_maestros(){		
		$resultado = $this->Model_convocatoria->datatable_maestros();
		print( json_encode($resultado) );
		return;
	}

	public function descargar_zip($curp){
		$this->_generar_zip($curp);
	}

	/** ************** FUNCIONES PRIVADAS ************* **/
	private function _generar_zip($curp){
		$exito = array('exito' => FALSE);
		$rutaZip = "sources/doctos/";
		$directorio = $rutaZip . $curp . '/';
		$nombreZip = $curp . ".zip";

		if ( ! file_exists( $rutaZip ) ){
			return $exito;
		}
		else {
			$zip = new ZipArchive;
			if($zip -> open($rutaZip . $nombreZip, ZipArchive::CREATE ) === TRUE) {
				$dir = opendir($directorio); 
				while($file = readdir($dir)) { 
					if(is_file($directorio.$file)) { 
						$zip -> addFile($directorio.$file, $file); 
					} 
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
			'utipo' => 	'Admin'
		);
		
		$this->session->set_userdata( $array );
	}

}

/* End of file Administrador.php */
/* Location: ./application/controllers/Administrador.php */