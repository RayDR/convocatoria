<?php $this->load->view('template/titulo'); ?>

<script type="text/javascript">
	var datos = <?php echo json_encode($datos, JSON_HEX_TAG); ?>;
</script>
<!-- SUBIR DOCUMENTOS -->
<div class="container">
	<div class="card border-light mb-3">
		<div class="card-header">
			<fieldset>
				<legend>
					<strong>Datos personales</strong>
				</legend>
				<div class="form-row">
					<div class="form-group col-12">
						<label for="curp">CURP</label>
						<input id="curp" type="text" class="form-control" readonly>
					</div>
					<div class="form-group col-lg-4">
						<label for="nombres">Nombre(s)</label>
						<input id="nombres" name="nombres" type="text" class="form-control datos" placeholder="Ingrese su(s) nombre(s)">
					</div>
					<div class="form-group col-lg-4">
						<label for="paterno">Apellido Paterno</label>
						<input id="paterno" name="paterno" type="text" class="form-control datos" placeholder="Ingrese su primer apellido">
					</div>
					<div class="form-group col-lg-4">
						<label for="materno">Apellido Materno</label>
						<input id="materno" name="materno" type="text" class="form-control datos" placeholder="Ingrese su segundo apellido">
					</div>
				</div>
			</fieldset>
		</div>
		<div class="card-body">
			<fieldset>
				<form id="upload_form">
					<legend>
						<strong>Adjuntar documentos digitales</strong>
					</legend>

					<div class="form-row">                        
						<div class="form-group col-md-8">

							<label for="documentos">Tipo documento</label>
							<select class="form-control" id="documentos" name="documentos">
								<option disabled selected>Seleccione una opción</option>
								<?php foreach ( $tipos_documentos as $documento ): ?>
									<option value=" <?= $documento['documento_id'] ?> ">
										<?= $documento['documento'] ?>
									</option>
								<?php endforeach; ?>
							</select>
						</div>
						
					</div>

					<div class="form-row mt-4">
						<div class="input-group col-md-8">
							<label><a href="https://pdf.io/es/compress/" target="_blank">¿Cómo comprimir mis PDF si pesan demasiado?</a></label>
							<div class="form-group">
								<div class="custom-file">
									<input type="file" class="custom-file-input" id="archivo" name="archivo" accept="application/pdf">

									<label class="custom-file-label" for="archivo" data-browse="Selecionar archivo">No se ha seleccionado nigún archivo</label>
								</div>
								<label class="text-muted" for="archivo" >El documento no puede ser mayor de <strong>2 MBs (2048 KBs)</strong></label>
							</div>
						</div>
					</div>

					<div class="form-row">
						<div class="mt-4 py-2">
							<button type="button" class="btn btn-block btn-primary" id="cargar" name="cargar">Cargar documento</button>
						</div>
					</div>
				</form>
			</fieldset>
		</div>
		<div class="card-footer">
			<fieldset id="mostrar-documentos">
				<?php if( sizeof( $documentos ) > 0 ): ?>
					<legend>
						Documentos Adjuntos
					</legend>
					<hr class="mx-1 my-2">
					<div class="card-columns container" id="documentos_adjuntos">
						<?php foreach ($documentos as $documento): ?>
							<?php 
								$this->load->helper('date');
								$nombre	= $documento['archivo'];
								$curp 	= $this->session->userdata("curp");
								$path 	= base_url() . 'sources/doctos/'. $curp .'/'. $nombre;

								$formato	= '%d/%m/%Y - %H:%i';
								$_fecha 	= strtotime ($documento['fecha_modificacion']);
								$fecha 		= mdate($formato, $_fecha);
							?>
							<div class="card">
								<div class="card-header bg-primary text-white">
									<?=$documento['documento']?>
								</div>
								<div class="card-body">
									<p class="card-title">
										<a class="card-link" target="_blank" href="<?=$path?>">
											<strong><?=$nombre?></strong>
										</a>
									</p>
									<iframe
										title="<?=$nombre?>" 
										src="<?=$path?>"
										height="100%" 
										width="100%"
									></iframe>
								</div>
								<div class="card-footer">
									<small class="text-muted">
										Fecha y hora de carga: <strong><?=$fecha?></strong>
									</small>
								</div>
							</div>							
						<?php endforeach; ?>
					</div>

				<?php else: ?>
					<legend>
						No se ha cargado ningún documento.
					</legend>
				<?php endif;?>
			</fieldset>
		</div>
</div>

<script src="<?php echo base_url() ?>sources/js/convocatoria/documentos.js"></script>