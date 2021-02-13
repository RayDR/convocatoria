<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Model_convocatoria extends CI_Model {

	function registrar_curp($curp, $datos_renapo = NULL){
		$exito = FALSE;
		if ( is_null($curp) )
			return $exito;

		$datos_maestro = array('curp'	=>	$curp);
		if ( $datos_renapo != NULL ){
			if ( is_array($datos_renapo) ){
				$datos_maestro['ap_paterno'] 	= $datos_renapo['primer_apellido'];
				$datos_maestro['ap_materno'] 	= $datos_renapo['segundo_apellido'];
				$datos_maestro['nombres'] 		= $datos_renapo['nombre'];
			}
		}

		$qMaestro = $this->db->get_where('datos_maestros', array('curp'	=>	$curp));
		try {
			if ( $qMaestro->num_rows() > 0 ) // El usuario existe
				$exito = TRUE;
			else {
				// Se registra 
				if ( $this->db->insert('datos_maestros', $datos_maestro ) )
					$exito = TRUE;
			}
		} catch (Exception $e) {
			$exito = FALSE;
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

	public function actualiza_datos( $_datos ){
		$datos = array(
			'nombres'		=>	$_datos['nombres'],
			'ap_paterno'	=>	$_datos['paterno'],
			'ap_materno'	=>	$_datos['materno']
		);
		$this->db->where( 'dato_maestro_id', $this->session->userdata('uid') );
		$this->db->update( 'datos_maestros', $datos );
	}

	public function registra_maestro_sede($datos){
		$exito = true;
		// Borrar si existen datos en maestros sedes		
		$this->db->where('dato_maestro_id', $this->session->userdata('uid'));
		$this->db->delete('maestros_sedes');
		// Insertar datos sedes
		foreach ($datos as $sede) {
			$datos_maestro_sede = array(
				'dato_maestro_id'	=>	$this->session->userdata('uid'),
				'curp'				=>	$this->session->userdata('curp'),
				'sede_id'			=>	$sede
			);
			if ( ! $this->db->insert('maestros_sedes', $datos_maestro_sede) )
				$exito = false;
		}
		return $exito;
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

	public function get_sedes(){
		return $this->db->get('sedes')->result_array();		
	}

	public function get_documentos(){
		$query = $this->db->get('documentos');
		return $query->result_array();
	}

	public function get_documentos_clasificados($clasificacion){
		$this->db->where('clasificacion_id', $clasificacion);
		$query = $this->db->get('documentos');
		return $query->result_array();
	}

	public function get_documentos_subidos($curp){
		$query = $this->db->get_where('vw_documentos_subidos', array('curp' => $curp));
		return $query->result_array();
	}

	public function get_sedes_maestro(){
		$condicion = array(
			'dato_maestro_id'	=> $this->session->userdata('uid')
		);

		$datos =  $this->db->get_where('vw_datos_maestros_sede', $condicion);
		if ( $datos->num_rows() > 0 )
			return $datos->row("sede_id");

		return null;
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
		$query = $this->db->get('vw_datos_maestros_sede');
		return $query->result_array();
	}

}

/* End of file Model_convocatoria.php */
/* Location: ./application/models/Model_convocatoria.php */