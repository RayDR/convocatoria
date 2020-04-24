$(document).ready(fn_iniciar_sistema);

function fn_iniciar_sistema(){
	fn_loader(false);

	$("#salir").click(fn_salir);

	$('[data-toggle="popover"]').popover();
	$('[data-toggle="tooltip"]').tooltip();
}

/* ******************************************************************* 
							MENÚ AJAX								
******************************************************************* */


function fn_salir(){
	$.ajax({
	  url: url('Convocatoria/salir'),
	  beforeSend: function(){
	  	fn_loader();
	  },
	  success: function() {
	  	fn_loader(false);
	  	window.location.href = url('Convocatoria/index');
	  }
	});
	
}