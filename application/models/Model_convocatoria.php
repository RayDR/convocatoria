<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Model_convocatoria extends CI_Model {

	function registrar_curp($curp){
		$exito = FALSE;
		if ( is_null($curp) )
			return $exito;

		$qMaestro = $this->db->get_where('datos_maestros', array('curp'	=>	$curp));

		if ( $qMaestro->num_rows() > 0 ) // El usuario existe
			$exito = TRUE;
		else {
			// Se registra 
			if ( $this->db->insert('datos_maestros', array( 'curp' => $curp ) ) )
				$exito = TRUE;
		}
		return $exito;
	}

	function get_maestro_id($curp){
		$exito = -1;
		if ( is_null($curp) )
			return $exito;
		$qMaestro = $this->db->get_where('datos_maestros', array('curp'	=>	$curp));
		if ( $qMaestro->num_rows() > 0 )
			$exito = $qMaestro->row('dato_maestro_id');

		return $exito;
	}

	public function get_datos(){
		$this->db->where('dato_maestro_id', $this->session->userdata('uid') );
		$datos = $this->db->get('datos_maestros');
		if ( $datos->num_rows() > 0 )
			return $datos->row();
		return NULL;
	}

	public function actualiza_datos( $datos ){
		$datos = array(
			'nombres'		=>	$datos['nombres'],
			'ap_paterno'	=>	$datos['paterno'],
			'ap_materno'	=>	$datos['materno']
		);
		$this->db->where( 'dato_maestro_id', $this->session->userdata('uid') );
		$this->db->update( 'datos_maestros', $datos );
	}

	public function registrar_documento($datos){
		$condicion = array(
			'curp'				=>	$this->session->userdata('curp'),
			'documento_id'		=>	$datos["documento_id"]
		);
		// Actualiza si existe
		if ( $this->db->get_where('documentos_adjuntos', $condicion)->num_rows() > 0 ){

			$this->db->where('curp', $this->session->userdata('curp'));
			$this->db->where('documento_id', $datos["documento_id"]);

			$datos = array(
				'curp'			=>	$this->session->userdata('curp'),
				'archivo'		=>	$datos["archivo"]
			);

			$this->db->update('documentos_adjuntos', $datos);
		}
		else {
			$this->db->where('curp', $this->session->userdata('curp'));

			$datos = array(
				'curp'			=>	$this->session->userdata('curp'),
				'documento_id'	=>	$datos["documento_id"],
				'archivo'		=>	$datos["archivo"]
			);

			$this->db->insert('documentos_adjuntos', $datos);
		}
	}

	public function get_documentos(){
		$curp = $this->session->userdata('curp');
		$query = $this->db->get_where('vw_documentos_subidos', array('curp' => $curp));
		return $query->result_array();
	}

	public function comprueba_documento($documento_id){
		$condicion = array(
			'documento_id'	=>	$documento_id,
			'curp'			=>	$this->session->userdata('curp')
		);
		$documento = $this->db->get_where('vw_documentos_subidos', $condicion);
		if ( $documento->num_rows() > 0 )
			return TRUE;
		return FALSE;
	}

	public function contar_documentos( $curp ){
		$documentosTotales = $this->db->get_where('vw_documentos_subidos', array('curp' => $curp));
		return $documentosTotales->num_rows();
	}

	public function datatable_maestros(){
		$query = $this->db->get('datos_maestros');
		return $query->result_array();
	}

}

/* End of file Model_convocatoria.php */
/* Location: ./application/models/Model_convocatoria.php */