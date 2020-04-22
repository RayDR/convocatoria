	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		
		<a class="navbar-brand" href="<?=base_url()?>index.php"><img src="<?=base_url()?>sources/img/logo_blanco.png" alt="SETAB" style="max-width: 170px; height: auto;"></a>
		
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Ocultar navegación">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse align-middle" id="menu">
			<ul class="navbar-nav ml-auto mt-2 mt-md-0">
				<?php if($this->session->userdata('utipo') == 'Admin'): ?>
					<li class="nav-item">
						<a id="salir" class="nav-link"><span class="mdi mdi-home-outline"> VOLVER A INICIO</span></a>
					</li>
					<?php if( $this->session->userdata('uLogin') ): ?>
						<li class="nav-item active">
							<a href="<?=base_url('index.php/Administrador/salir')?>" class="nav-link"><span class="mdi mdi-logout"> SALIR</span></a>
						</li>
					<?php endif ?>
				<?php else: ?>
				<li class="nav-item active">
					<a id="salir" class="nav-link"><span class="mdi mdi-home-outline"> INICIO</span></a>
				</li>
				<?php endif ?>
			</ul>
		</div>
	</nav>