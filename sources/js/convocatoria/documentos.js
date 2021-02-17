var ultima_seleccion = null;
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
	$('#clasificacion').change(fn_listado_doctos);

	$("#documentos").select2();
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
			futil_modal('LO SENTIMOS',`Seleccione un <strong>Tipo de documento</strong> válido`, '',true);
			$("#documentos").addClass('is-invalid');
			return;
		}
		if ( $("#archivo").val() == null || $("#archivo").val() == "" ){
			futil_modal('LO SENTIMOS',`Primero <strong>seleccione un archivo</strong>.`, '',true);
			$("#archivo").addClass('is-invalid');
			return;
		}
		fn_carga_documento();
	});

	$(".datos").blur(fn_actualiza_datos);

	$("#sede").multiSelect({buttonWidth: '400px'});

	if ( datosSedes != null )
		datosSedes = datosSedes.split(',');

	sedesSelect = datosSedes;
	ultima_seleccion = sedesSelect;
	$("#sede").multiSelect('select', sedesSelect);
	$("#sede").change(fn_seleccion_sede);
	$(".datos").trigger('blur');
});

function fn_listado_doctos(){
	var categoria = $(this).val();
	var resultado = futil_muestra_vista( 
						url(`Convocatoria/listado_documentos_clasificados/${categoria}`) );
	if ( resultado )
		$("#documentos").html(resultado);
}

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
				futil_modal("CARGA EXITOSA", "Documento cargado exitosamente", '',true);
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
				futil_modal("FALLÓ LA CARGA DEL DOCUMENTO", data.mensaje, '',true );
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			futil_modal("ERR");
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
			nombres: datos.nombres,
			paterno: datos.ap_paterno,
			materno: datos.ap_materno
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
	let clave = $(this).data('cve_documento');
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
						Este documento ya ha sido cargado, si lo sube nuevamente se <b>sobreescribirá</b> el documento anterior.
					</div>`
				);
			}
			else{
				$("#documentos").removeClass('is-valid');
				$("#documentos").parent().find('.valid-feedback').remove();
			}
		}
	});
	
	let labelHtml = `
		<label class="text-muted" for="archivo">El documento no puede ser mayor de <strong>2 MBs (2048 KBs)</strong></label>
	`;
	if ( $(this).val() == 12 )
		labelHtml = `
			<label class="text-muted" for="archivo">El documento no puede ser mayor de <strong>8 MBs (8192 KBs)</strong></label>
		`;

	$("label[for*='archivo']").html( labelHtml );
	
}

function fn_recargar_documentos(){
	$.ajax({
		url: url('Convocatoria/get_documentos_subidos'),
		beforeSend: function(){
			fn_loader();
		},
		complete: function() {
			fn_loader(false);
		},
		success: function(data, textStatus, xhr) {
			data = JSON.parse(data);
			var html = `
				<div class="card-columns container" id="documentos_adjuntos"></div>
			`;
			$("#mostrar-documentos").html(html);
			data.forEach( function(documento, index) {
				let time = new Date().getTime();
				let _url = 'sources/doctos/' + documento.curp + '/' + documento.archivo + '?' + time;
				html += `
				<div class="card">
					<div class="card-header fondo-rojo text-white">`+ documento.documento +`</div>
					<div class="card-body">
						<p class="card-title">
							<a class="card-link" target="_blank" href="`+ url(_url, false) +`">
								<strong>`+ documento.archivo +`</strong>
							</a>
						</p>

						<iframe
							title="`+ documento.archivo +`" 
							src="`+ url(_url, false) +`" 
							frameborder="0"
						></iframe>
					</div>
				</div>
				`;
			});
			$("#documentos_adjuntos").html(html);
		}
	});
	
}

function fn_seleccion_sede(){
	let domicilio = $(this).children("option:selected").data("domicilio");
	$("#domicilio").html( "<small><strong>Domicilio: </strong>" + domicilio + "</small>" );

	if ( $(this).val().length > 4 ){
		let temp = ultima_seleccion;
		$(this).multiSelect('deselect_all');
		$(this).multiSelect('refresh');
		$(this).multiSelect('select', temp);

		$("#sede").addClass('is-invalid');
		$("#sede").parent().find('.invalid-feedback').remove();
		$("#sede").parent().append(
			`<div class="invalid-feedback">
				No es posible aplicar a más de cuatro sedes.
			</div>`
		);
		return false;
	}
	else {
		ultima_seleccion = $(this).val();
		$("#sede").removeClass('is-invalid');
		$("#sede").parent().find('.invalid-feedback').remove();
	}
	

	if ( $(this).val() != null ){
		if ( $(this).val().length > 0 ){
			sedesSelect = $(this).val();
			$.ajax({
				url: url('Convocatoria/guardar_maestro_sede', true),
				type: 'POST',
				data: {
					sedes: sedesSelect
				},
				beforeSend: function(){
					fn_loader();
				},
				complete: function(xhr, textStatus) {
					fn_loader(false);
				},
				success: function(data, textStatus, xhr) {
					
					$("#sede").removeClass('is-invalid');
					$("#sede").parent().find('.invalid-feedback').remove();
				},
				error: function(xhr, textStatus, errorThrown) {
					futil_modal('ERR');
				}
			});
		}
	}
}