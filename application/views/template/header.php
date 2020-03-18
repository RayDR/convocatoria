<?php
	$this->output->set_header('Last-Modified:'.gmdate('D, d M Y H:i:s').'GMT');
	$this->output->set_header('Cache-Control: no-store, no-cache, must-revalidate');
	$this->output->set_header('Cache-Control: post-check=0, pre-check=0',false);
	$this->output->set_header('Pragma: no-cache');
?>
<!DOCTYPE html>
<html lang="es">
	<head>
		<!-------------------- Declaración de METAS -------------------->
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<link rel="icon" type="image/vnd.microsoft.icon" href="<?=base_url()?>sources/img/favicon.ico" sizes="128x128">
		<!---------------------- Título Dinámico ----------------------->
		<title><?=$tituloPagina?> | SETAB 2020</title>
		<!----------------------- Hojas de Estilo ----------------------->
		<!-- Bootstrap Core CSS -->
		<link rel="stylesheet" type="text/css" href="<?=base_url();?>sources/lib/Bootstrap-4.4.1/css/bootstrap.css"/>
		<!-- Iconos MDiW CSS-->
		<link rel="stylesheet" type="text/css" href="<?=base_url();?>sources/lib/MaterialDesign/css/materialdesignicons.css" media="all"/>
		<!-- Datepicker CSS -->
		<link rel="stylesheet" type="text/css" href="<?=base_url();?>sources/lib/Datepicker/css/datepicker.css"/>
		<!-- DataTables CSS -->
		<link rel="stylesheet" type="text/css" href="<?=base_url();?>sources/lib/DataTables/datatables.min.css"/>
		<!------------------------- Scripts JS ------------------------->
		<!-- jQuery Js -->
		<script type="text/javascript" src="<?=base_url();?>sources/lib/JQuery/jquery-3.4.1.js"></script>	
		<!-- Popper Js -->
		<script type="text/javascript" src="<?=base_url();?>sources/lib/Popper/popper.js"></script>
		<!-- Bootstrap Core JS -->
		<script type="text/javascript" src="<?=base_url();?>sources/lib/Bootstrap-4.4.1/js/bootstrap.min.js"></script>
		<!-- Datepicker Js -->
		<script type="text/javascript" src="<?=base_url();?>sources/lib/Datepicker/js/bootstrap-datepicker.js"></script>
		<!-- DataTables Js -->
		<script type="text/javascript" src="<?=base_url();?>sources/lib/DataTables/datatables.js"></script>


		<!--------------- Estilos Globales Personalizados --------------->
		<link rel="stylesheet" type="text/css" href="<?=base_url();?>sources/css/global.css"/>
	</head>