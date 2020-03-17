var dt;

$(document).ready(function($) {
	dt = $('#tabla-maestros').DataTable({
		"ajax": {
			"url":url('Administrador/datatable_maestros'),
			"dataSrc": ""
		},
		"columns": [
			{ 
            	"data": 'dato_maestro_id',
            	"visible": false
            },
			{ "data": "curp" },
			{ 
				"data": null,
				"render": function(data){
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
			{ "data": "fecha_modificacion" },
			{ 
				"data": null,
				"render": function(data){
					let html = '<a href="'+ url('Administrador/descargar_zip') +'/'+ data.curp +'" target="_blank" class="mdi mdi-download lead "></a>';
					return html;
				}
			},
		],
		"oLanguage": {
			"sProcessing": "Procesando...",
			"sLengthMenu": 'Mostrar <select>' +
				'<option value="10">10</option>' +
				'<option value="20">20</option>' +
				'<option value="30">30</option>' +
				'<option value="40">40</option>' +
				'<option value="50">50</option>' +
				'<option value="-1">Todos</option>' +
				'</select> registros',
			"sZeroRecords": "No se encontraron resultados",
			"sEmptyTable": "Ningún dato disponible en esta tabla",
			"sInfo": "Mostrando del (_START_ al _END_) de un total de _TOTAL_ registros",
			"sInfoEmpty": "Mostrando del 0 al 0 de un total de 0 registros",
			"sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix": "",
			"sSearch": "Filtrar:",
			"sUrl": "",
			"sInfoThousands": ",",
			"sLoadingRecords": "Por favor espere - cargando...",
			"oPaginate": {
				"sFirst": "Primero",
				"sLast": "Último",
				"sNext": "Siguiente",
				"sPrevious": "Anterior"
			},
			"oAria": {
				"sSortAscending": ": Activar para ordenar la columna de manera ascendente",
				"sSortDescending": ": Activar para ordenar la columna de manera descendente"
			}
		}
	});
});