<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Renapo
{
    protected $ci;
    protected $ws;

    public function __construct(){
      $this->ci =& get_instance();
        $this->ws = new SoapClient("http://192.168.52.15:8084/wsCurpRenapoSE/services/ConsultaCurpMain?wsdl");
    }

    public function getCurp( $strCurp ){
        $json_result = array('exito' => TRUE);
        if ( ! is_null($strCurp) ) {
            $parametros     = array('strCurp' => $strCurp);
            $ws_result      = $this->ws->getCurp( $parametros );
            if ( $ws_result->return != 'ACCESO DENEGADO' ){
                try {
                    $ws_xml         = simplexml_load_string( $ws_result->return );
                    $xml_str        = json_encode( $ws_xml );
                    $ws_array       = json_decode( $xml_str, TRUE );

                    if ( is_array($ws_array) ){
                        $json_result['exito']   = TRUE;
                        $json_result['ws_exito']= $ws_array["@attributes"]['statusOper'];
                        $json_result['mensaje'] = $ws_array["@attributes"]['message'];
                        $json_result['error']   = $ws_array["@attributes"]['CodigoError'];
                        $json_result['curp']    = $ws_array['CURP'];
                        $json_result['primer_apellido']     = $ws_array['apellido1'];
                        $json_result['segundo_apellido']    = $ws_array['apellido2'];
                        $json_result['nombre']              = $ws_array['nombres']; 
                        $json_result['sexo']                = $ws_array['nombres']; 
                        $json_result['fecha_nacimiento']    = $ws_array['fechNac'];
                        $json_result['nacionalidad']        = $ws_array['nacionalidad'];
                        $json_result['entidad_federativa']  = $ws_array['numEntidadReg'];
                    }
                    else{
                        $json_result['mensaje'] = 'Falló la conversión del XML.';
                        $json_result['exito'] = FALSE;
                    }
                } catch (Exception $e) {
                    $json_result['exito']   = FALSE;
                    $json_result['mensaje'] = 'No se obtuvo la estructura correcta.';
                }
            } else {
                $json_result['exito']   = FALSE;
                $json_result['mensaje'] = 'Acceso restringido.';
            }
        } else
            $json_result['exito'] = FALSE;

        return $json_result;
    }

    public function getDetalleCurp( $datos_ws ){
        $json_result = array('exito' => TRUE);
        if ( ! is_null($datos_ws) ){
            if ( is_array($datos_ws) ){
                $req_param = ['ap1','ap2','nom','ent','sx','fechnac'];
                foreach ($datos_ws as $key => $value){
                    if ( ! array_key_exists($key, $req_param) )
                        $json_result['exito'] = FALSE;              
                }
                if ( $json_result['exito'] ){
                    $ws_result      = json_decode( $this->ws->getDetalleCurp($datos_ws) );
                    if ( $ws_result->return != 'ACCESO DENEGADO' ){
                        try {
                            $ws_xml         = simplexml_load_string( $ws_result->return );
                            $xml_str        = json_encode( $ws_xml );
                            $ws_array       = json_decode( $xml_str, TRUE );
        
                            if ( is_array($ws_array) ){
                                $json_result['exito']   = $ws_array["@attributes"]['statusOper'];
                                $json_result['mensaje'] = $ws_array["@attributes"]['message'];
                                $json_result['error']   = $ws_array["@attributes"]['CodigoError'];
                                $json_result['curp']    = $ws_array['CURP'];
                                $json_result['primer_apellido']     = $ws_array['apellido1'];
                                $json_result['segundo_apellido']    = $ws_array['apellido2'];
                                $json_result['nombre']              = $ws_array['nombres']; 
                                $json_result['sexo']                = $ws_array['nombres']; 
                                $json_result['fecha_nacimiento']    = $ws_array['fechNac'];
                                $json_result['nacionalidad']        = $ws_array['nacionalidad'];
                                $json_result['entidad_federativa']  = $ws_array['numEntidadReg'];
                            }
                            else{
                                $json_result['mensaje'] = 'Falló la conversión del XML.';
                                $json_result['exito'] = FALSE;
                            }
                        } catch (Exception $e) {
                            $json_result['exito']   = FALSE;
                            $json_result['mensaje'] = 'No se obtuvo la estructura correcta.';
                        }
                    } else {
                        $json_result['exito']   = FALSE;
                        $json_result['mensaje'] = 'Acceso restringido.';
                    }
                }
            }
            
        }
        return json_encode($json_result);
    }

}

/* End of file Renapo.php */
/* Location: ./application/libraries/Renapo.php */
