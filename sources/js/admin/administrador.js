var dt;

$(document).ready(function($) {
	cargar_datatable();

	$("#salir_admin").click(fn_salir_admin);
	$('[data-toggle="popover"]').popover();
	$('[data-toggle="tooltip"]').tooltip();
});

$(document).off('click', "#descargar_zip").on('click', "#descargar_zip", fn_respuesta_descarga);

function cargar_datatable(){
	dt = $('#tabla-maestros').DataTable({
		bStateSave:         true,
      sPaginationType:    "full_numbers",
      scrollX:            true,
      scrollY:            '70vh',
      scrollCollapse:     true,
      dom:                '<"row text-center mb-3"<"col-12"B>><"row d-flex justify-content-between"<"col-6"l><"col-6"f>>t<"mb-3"i>p',
      buttons: [
         {   
            text        : 'Actualizar',
            action      : function ( e, dt, node, config ) {
            $(this).prop({disabled: true});
            if( $.fn.dataTable.isDataTable( '#tabla-maestros' ) ){
               dt.ajax.reload( null, false );
               futil_toast('Tabla actualizada.');
            } else 
               $(this).prop({disabled: true});
            }
         },
         { extend : 'excel' }
      ],
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
					let sedes = "";
					if ( data.sede_id.length != null){
						let datos_sedes = data.sede.split(',');
						datos_sedes.forEach( function(_sede, index) {
							sede = _sede.split('-');
							sedes += `<span 
												class="badge badge-info mx-1"
												data-toggle="tooltip" 
												data-placement="left" 
												title="`+ sede[1] +`"
										>`+ sede[0] +`</span>`;
						});
					}
					return sedes;
				}
			},
			{ 
				data: null,
				orderable: false,
				render: function(data){
					//let html = '<a href="'+ url('Administrador/descargar_zip') +'/'+ data.curp +'" target="_blank" class="mdi mdi-download lead"></a>';
					let html = `<span id="descargar_zip" class="mdi mdi-download lead text-secondary texto-rojo" data-curp="` + data.curp + `"></span>`;
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
	$.ajax({
		url: url('Administrador/preprarar_descarga_zip'),
		type: 'POST',
		data: { 'curp': dataCurp },
		success: function(data, textStatus, xhr) {
			data = JSON.parse(data);
			if( data.exito ){
				window.open( url('Administrador/descargar_zip/' + dataCurp ),'_blank')
			} else {
				futil_modal("SIN DOCUMENTOS", 'Este docente no ha cargado ningún documento.' );
			}
		}
	});
	
}
