<!-- Encabezados/Menú -->
<?php $this->load->view($template.'header'); ?>

<body>
<?php $this->load->view($template.'navbar'); ?>
	<!-- Fin Encabezados/Menú -->

	<!-- Vista dinámica -->
	<div id="ajax_html">
		<?php $this->load->view($view);?>
	</div>
	<!-- Fin vista dinámica -->

	<!-- Modal-mensajes -->
<?php $this->load->view($template.'modal');?>
	<!-- Fin Modal-mensajes -->

	<!-- Loader -->
	<div id="loader-background"></div>
	<div id="loader"></div>
	<!-- Fin Loader -->
	
	<!-- URL Web -->
	<input type="hidden" id="base_url" value="<?=base_url()?>">
	
	<!-- Separador -->
	<div id="separador" style="padding-bottom: 100px;">
	<!-- Fin Separador -->
<?php $this->load->view($template.'footer');?>
	<script type="text/javascript" src="<?=base_url()?>sources/js/utilerias.js"></script>
	<script type="text/javascript" src="<?=base_url()?>sources/js/index.js"></script>
</body>

</html>

