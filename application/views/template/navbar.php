	<nav class="navbar navbar-expand-lg navbar-dark fondo-rojo">
		
		<a class="navbar-brand" href="<?=base_url()?>index.php"><img src="<?=base_url()?>sources/img/logo_blanco.png" alt="SETAB" style="max-width: 170px; height: auto;"></a>

		<a class="lead text-white nav-link" href="<?=base_url()?>index.php"><small>Proceso de Selección para la Admisión en Educación Media Superior Ciclo Escolar 2020-2021</small></a>
		
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Ocultar navegación">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse align-middle" id="menu">
			<ul class="navbar-nav ml-auto mt-2 mt-md-0">
				<?php if($this->session->userdata('utipo') == 'Admin'): ?>
					<li class="nav-item">
						<a id="salir" class="nav-link"><span class="mdi mdi-home-outline" data-toggle="tooltip" data-placement="right" title="Volver al Inicio"> Volver</span></a>
					</li>
					<?php if( $this->session->userdata('uLogin') ): ?>
						<li class="nav-item active">
							<a href="<?=base_url('index.php/Administrador/salir')?>" class="nav-link"><span class="mdi mdi-logout" data-toggle="tooltip" data-placement="right" title="Regresar al Login"> Cerrar Sesión</span></a>
						</li>
					<?php endif ?>
				<?php elseif( $this->session->userdata('uLogin') ): ?>
				<li class="nav-item active">
					<a id="salir" class="nav-link"><span class="mdi mdi-home-outline" data-toggle="tooltip" data-placement="right" title="Guardar y Salir a la pantalla de Inicio"> Salir</span></a>
				</li>
				<?php else: ?>
					<?php if( $this->session->userdata("mAdmin") ): ?>
					<li class="nav-item">
						<a id="salir" class="nav-link"><span class="mdi mdi-home-outline" data-toggle="tooltip" data-placement="right" title="Volver al Inicio"> Volver</span></a>
					</li>
					<?php else: ?>
					<li class="nav-item active">
						<a href="<?=base_url('index.php/Administrador')?>" class="nav-link"><span class="mdi mdi-account-circle lead" data-toggle="tooltip" data-placement="right" title="Administrador"></span></a>
					</li>
					<?php endif; ?>
				<?php endif ?>
			</ul>
		</div>
	</nav>