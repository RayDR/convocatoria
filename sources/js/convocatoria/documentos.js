$(document).ready(function() {
	window.scrollTo(0, 0);

	if ( datos != null ){
		$("#curp").val( datos.curp );
		$("#nombres").val( datos.nombres );
		$("#paterno").val( datos.ap_paterno );
		$("#materno").val( datos.ap_materno );
	} else {
		$("#curp").val( "CURP NO INGRESADA" );
		$("#cargar").attr('disabled', false);
	}

	var file = "";

	$('#documentos').change(fn_documento_cargado);

	$('.custom-file-input').on('change', function() {
		file = document.getElementById("archivo").files[0].name;
		$(this).next('.custom-file-label').addClass("selected").html(file);
		$(this).addClass('is-valid');
	})

	$("#cargar").click(function() {
		$("#documentos").removeClass('is-invalid');
		$("#archivo").removeClass('is-invalid');
		if ($("#documentos").val() == null || $("#documentos").val() == undefined ) {
			modal('LO SENTIMOS',`Seleccione un <strong>Tipo de documento</strong> válido`, '',true);
			$("#documentos").addClass('is-invalid');
			return;
		}
		if ( $("#archivo").val() == null || $("#archivo").val() == "" ){
			modal('LO SENTIMOS',`Primero <strong>seleccione un archivo</strong>.`, '',true);
			$("#archivo").addClass('is-invalid');
			return;
		}
		fn_carga_documento();
	});

	$(".datos").blur(fn_actualiza_datos);
});

function fn_carga_documento() {
	$.ajax({
		url: url('Convocatoria/cargar_documento'),
		type: 'POST',
		dataType: 'html',
		mimeType: "multipart/form-data",
		data: new FormData(document.getElementById("upload_form")),
		async: false,
		processData: false,
		contentType: false,
		beforeSend: function(data) {
			$("#cargar_docto").attr({disabled: true});
			fn_loader();
		},
		success: function(data, textStatus, xhr) {
			$("#cargar_docto").attr({disabled: false});
			data = JSON.parse(data);
			if ( data.exito ){
				modal("CARGA EXITOSA", "Documento cargado exitosamente", '',true);
				$("#documentos").prop("selectedIndex", 0);
				$("#documentos").parent().find('.valid-feedback').remove();
				$("#documentos").removeClass('is-valid');
				$("#archivo").removeClass('is-valid');
				$("#archivo").val('');
				$("#archivo").next('.custom-file-label')
					.html('No se ha seleccionado ningún archivo');
				fn_recargar_documentos();
			} else{
				$("#documentos").parent().find('.valid-feedback').remove();
				$("#documentos").addClass('is-invalid');
				$("#archivo").addClass('is-invalid');
				modal("FALLÓ LA CARGA DEL DOCUMENTO", data.mensaje, '',true );
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			modal("ERR");
			$("#cargar_docto").attr({disabled: false});
		},
		complete: function(){
			fn_loader(false);
		}
	});
}


function fn_actualiza_datos(){
	var input = $(this);
	if ( input.length < 1 )
		return;
	if ( 
		$("#nombres").val() == datos.nombres &&
		$("#paterno").val() == datos.ap_paterno &&
		$("#materno").val() == datos.ap_materno 
	)
		return;
	else {
		datos.nombres = $("#nombres").val();
		datos.ap_paterno = $("#paterno").val();
		datos.ap_materno = $("#materno").val();
	}

	$.ajax({
		url: url('Convocatoria/actualiza_datos'),
		type: 'POST',
		data: { 
			nombres: $("#nombres").val(),
			paterno: $("#paterno").val(),
			materno: $("#materno").val()
		},
		success: function(data, textStatus, xhr) {
			input.addClass('is-valid');
		},
		fail: function(){
			input.addClass('is-invalid');
		}, 
		error: function(){
			input.addClass('is-invalid');
		}
	});
	
}

function fn_documento_cargado(){
	$(this).removeClass('is-invalid');
	$.ajax({
		url: url('Convocatoria/comprobar_documento_cargado'),
		type: 'POST',
		data: { documento: $(this).val() },
		success: function(data, textStatus, xhr) {
			data = JSON.parse(data);
			if ( data.existe ){
				$("#documentos").addClass('is-valid');
				$("#documentos").parent().find('.valid-feedback').remove();
				$("#documentos").parent().append(
					`<div class="valid-feedback">
						Este archivo ya ha sido cargado.
					</div>`
				);
			}
			else{
				$("#documentos").removeClass('is-valid');
				$("#documentos").parent().find('.valid-feedback').remove();
			}
		}
	});
	
}

function fn_recargar_documentos(){
	$.ajax({
		url: url('Convocatoria/get_documentos'),
		beforeSend: function(){
			fn_loader();
		},
		complete: function() {
			fn_loader(false);
		},
		success: function(data, textStatus, xhr) {
			data = JSON.parse(data);
			var html = "";
			$("#documentos_adjuntos").html(html);
			data.forEach( function(documento, index) {
				let time = new Date().getTime();
				let _url = 'sources/doctos/' + documento.curp + '/' + documento.archivo + '?' + time;
				html += `
				<div class="card">
					<div class="card-header bg-primary text-white">`+ documento.documento +`</div>
					<div class="card-body">
						<p class="card-title">
							<a class="card-link" target="_blank" href="`+ url(_url, false) +`">
								<strong>`+ documento.archivo +`</strong>
							</a>
						</p>
						<p class="card-text">
							<a class="card-link text-secondary" target="_blank" href="`+ url(_url, false) +`">
								Ver el documento
							</a>
						</p>
					</div>
				</div>
				`;
			});
			$("#documentos_adjuntos").html(html);
		}
	});
	
}