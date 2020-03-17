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

	public function index(){
		return;
	}

}

/* End of file Administrador.php */
/* Location: ./application/controllers/Administrador.php */