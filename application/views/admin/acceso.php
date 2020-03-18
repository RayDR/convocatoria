<div class="container">

	<div id="modal_login" class="modal fade text-primary" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header text-center">
					<h4 class="modal-title w-100">Control de Acceso</h4>
					</button>
				</div>
				<div class="modal-body my-3">
					<div id="mensaje" class="mb-4 text-info text-center lead">
					</div>
					<div class="mb-4">
						<div class="input-group">
							<div class="input-group-prepend">
								<i class="input-group-text mdi mdi-lock text-secondary"></i>
							</div>
							<input type="password" id="clave" name="clave" class="form-control text-secondary">
						</div>
						<label for="clave">Contraseña de acceso</label>
					</div>
				</div>
				<div class="modal-footer d-flex justify-content-center">
					<button id="btn-ingresar" class="btn btn-outline-primary">Ingresar</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="<?=base_url()?>sources/js/admin/acceso_admin.js"></script>