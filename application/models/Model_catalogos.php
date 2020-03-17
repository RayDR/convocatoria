<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Model_catalogos extends CI_Model {

	public function get_tipos_documentos(){
		return $this->db->get('vw_doctos_digitales')->result_array();
	}

	public function get_tipo_documento( $documento ){
		$this->db->where( 'documento_id', $documento );
		$this->db->select( 'cve_documento' );

		$documentos = $this->db->get('vw_doctos_digitales');

		if ( $documentos->num_rows() > 0 )
			return $documentos->row('cve_documento');

		return NULL;
	}

}

/* End of file model_catalogos.php */
/* Location: ./application/models/model_catalogos.php */