var dt;

$(document).ready(function($) {
	cargar_datatable();

	$("#salir_admin").click(fn_salir_admin);
});

$(document).off('click', "#descargar_zip").on('click', "#descargar_zip", fn_respuesta_descarga);

function cargar_datatable(){
	dt = $('#tabla-maestros').DataTable({
		scrollX: true,
		ajax: {
			url: url('Administrador/datatable_maestros'),
			dataSrc: ''
		},
		columns: [
			{ 
         	data: 'dato_maestro_id',
         	visible: false
         },
			{ data: 'curp' },
			{ 
				data: null,
				render: function(data){
					let nombreCompleto = [];
					if ( data.nombres != "" && data.nombres != null )
						nombreCompleto.push(data.nombres);
					if ( data.ap_paterno != "" && data.ap_paterno != null )
						nombreCompleto.push(data.ap_paterno);
					if ( data.ap_materno != "" && data.ap_materno != null )
						nombreCompleto.push(data.ap_materno);
					return nombreCompleto.join(' ');
				}
			},
			{ data: "fecha_modificacion" },
			{ 
				data: null,
				orderable: false,
				render: function(data){
					//let html = '<a href="'+ url('Administrador/descargar_zip') +'/'+ data.curp +'" target="_blank" class="mdi mdi-download lead"></a>';
					let html = `<span id="descargar_zip" class="mdi mdi-download lead text-primary" data-curp="` + data.curp + `"></span>`;
					return html;
				}
			},
		],
		language: {
			url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
		}
	});
}

function fn_salir_admin(){
	
}


function fn_respuesta_descarga(){
	var dataCurp = $(this).data('curp');
	console.log(dataCurp);
	$.ajax({
		url: url('Administrador/preprarar_descarga_zip'),
		type: 'POST',
		data: { 'curp': dataCurp },
		success: function(data, textStatus, xhr) {
			data = JSON.parse(data);
			if( data.exito ){
				window.open( url('Administrador/descargar_zip/' + dataCurp ),'_blank')
			} else {
				modal("SIN DOCUMENTOS", 'Este docente no ha cargado ningún documento.' );
			}
		}
	});
	
}
