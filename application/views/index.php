
<div class="container py-3">	
	<div class="card border-light">
		<div class="card-header">	
			<div class="row">
				<div class="col-12 text-center">
					<p class="text-secondary m-0 p-0" style="font-size: 3vmax;"><strong>BIENVENIDO AL REGISTRO Y VERIFICACIÓN</strong></p>
					<p class="text-primary m-0 p-0" style="font-size: 3vmax;"><strong>DOCUMENTAL DE ASPIRANTES A DOCENTE</strong></p>
				</div>
			</div>
		</div>
		<div class="card-body bg-light">

			<div class="row mt-1">
				<div class="col col-md-6 mx-auto">
					<div class="form-group">
						<label for="curp">Ingrese su CURP:</label>
						<input type="text" maxlength="18" class="form-control text-uppercase" id="curp" name="curp" placeholder="CURP"  autofocus autocomplete autosave>						
						<small><strong>
							<a class="card-link" href="https://www.gob.mx/curp/" target="_blank"  role="button">Obtener mi CURP</a>
						</strong></small>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-12 d-flex justify-content-center my-2">
					<script src="https://www.google.com/recaptcha/api.js" async defer></script>
					<div class="g-recaptcha" data-sitekey="6Ld5vd4UAAAAAIxsHZ1IzasRP2tdIfje7a0-i0Bx"></div>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col col-md-6 mx-auto">
					<div class="form-group">
						<button type="button" id="btnEntrar" name="btnEntrar" class="btn btn-primary btn-md">
							Ingresar
						</button>
					</div>
				</div>
			 </div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$("#btnEntrar").click(function() {
		jQuery.ajax({
			url: url('Convocatoria/ingresar'),
			type: 'POST',
			data: {
				curp: $("#curp").val(),
				response: grecaptcha.getResponse()
			},
			beforeSend: function(){
				fn_loader();
			},
			success: function(data, textStatus, xhr) {
				fn_loader(false);
				data = JSON.parse(data);
				if ( data.exito ){
					window.location.href = url('Convocatoria/registro');
				} else {
					modal( "Lo sentimos", data.mensaje );
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				fn_loader(false);
				modal("ERR");
			}
		});
		
	});
</script>
