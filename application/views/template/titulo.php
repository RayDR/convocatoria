<?php if ( isset($tituloPagina) ){ ?>
<?php $subtituloPagina = isset($subtituloPagina)? " - " . $subtituloPagina : ""; ?>
		<div class="container">

			<div class="jumbotron pt-2 pb-1 texto-rojo bg-transparent">
				<div class="row">
					<div class="col col-xs-12 mt-xs-3">
						
						<h1 id="titulo_pagina" class="text-center mx-auto text-truncate">
							<?=$tituloPagina?><small><?=$subtituloPagina?></small>
						</h1>
					</div>
				</div>
			</div>
		</div>
<?php } ?>