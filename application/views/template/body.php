<!-- Encabezados/Menú -->
<?php $this->load->view($template.'header'); ?>

<body>
<?php $this->load->view($template.'navbar'); ?>
	<!-- Fin Encabezados/Menú -->
	<h1 style="display: none">Proceso de Selección para la Admisión en Educación Media Superior Ciclo Escolar 2020-2021</h1>
	<!-- Vista dinámica -->
	<div id="ajax_html">
		<?php $this->load->view($view);?>
	</div>
	<!-- Fin vista dinámica -->

	<!-- Modal-mensajes -->
<?php $this->load->view($template.'modal');?>
	<!-- Fin Modal-mensajes -->

	<!-- Loader -->
	<div id="loader" class="loader-background">
		<div class="loader">
			<div class="loader--dot"></div>
			<div class="loader--dot"></div>
			<div class="loader--dot"></div>
			<div class="loader--dot"></div>
			<div class="loader--dot"></div>
			<div class="loader--dot"></div>
			<div class="loader--text"></div>
		</div>
	</div>
	<div id="notificaciones" style="position: fixed; top: 10px; right: 10px; z-index: 100;">
</div>
	<!-- Fin Loader -->
	
	<!-- URL Web -->
	<input type="hidden" id="base_url" value="<?=base_url()?>">
	
	<!-- Separador -->
	<div id="separador" style="padding-bottom: 100px;">

	<!-- Back To Top -->
	<span class="back-to-top fa fa-arrow-circle-up" data-title="Volver arriba" data-toggle="tooltip" data-placement="left"></span>
	<!-- Fin Back To Top -->
	
	<!-- Fin Separador -->
<?php $this->load->view($template.'footer');?>
	<script type="text/javascript" src="<?=base_url()?>sources/js/utilerias.js"></script>
	<script type="text/javascript" src="<?=base_url()?>sources/js/index.js"></script>
</body>

</html>

