var alerta = `
<div id="mensaje-alerta" class="alert alert-warning alert-dismissible fade show" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>`;

var info = `
<div id="mensaje-alerta" class="alert alert-info alert-dismissible fade show" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>`;

var exito = `
<div id="mensaje-alerta" class="alert alert-success alert-dismissible fade show" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>`;

$(document).ready(function($) {
	$("#modal_login").modal('show');

	$("#modal_login").keypress(function(event) {
		if ( event.which == 13 )
			fn_login();
	});

	$("#btn-ingresar").click(fn_login);
	$("#mensaje").html('Bienvenido');
});

function fn_login(){
	if ( fn_validacion() ){
		$.ajax({
			url: url('Administrador/ingresar'),
			type: 'POST',
			data: { clave: $("#clave").val() },
			beforeSend: function(){
				$("#btn-ingresar").attr('disabled', true);
			},
			success: function(data){
				data = JSON.parse(data);
				if ( data.exito ){
					$("#mensaje").html(exito);
					$("#mensaje-alerta").append('<small><strong>Ingresando</strong> ;)</small>');
					window.location.href = url('Administrador/panel_administrador');
				} else {
					$("#mensaje").html(alerta);
					$("#mensaje-alerta").append('<small>La <strong>contraseña de acceso</strong> ingresada es incorrecta.</small>');
				}
			},
			complete: function(){
				$("#btn-ingresar").attr('disabled', false);
			}
		});
		
	}
}

function fn_validacion(){
	if ( $("#clave").val().length < 4 ){
		$("#mensaje").html(info);
		$("#mensaje-alerta").append('<small>Por favor, ingrese una <strong>contraseña de acceso</strong> válida.</small>');
		return false;
	}
	return true;
}