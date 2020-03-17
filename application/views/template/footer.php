	<footer class="footer fixed-bottom mt-auto py-3 bg-light" style="z-index: 1">
		<div class="container row" style="font-size: 13px;">
			<?php
			if (ENVIRONMENT == 'development'){			
			?>
				<p class="text-secondary text-center col-6 my-auto">Secretaría de Educación del Estado de Tabasco <small class="text-muted"><?=date("Y");?> &copy; - Todos los derechos reservados</small></p>
			<?php
			} else {
			?>
				<p class="text-secondary text-center col-9 my-auto">Secretaría de Educación del Estado de Tabasco <small class="text-muted"><?=date("Y");?> &copy; - Todos los derechos reservados</small></p>
			<?php
			}
			?>

			<?php
				if (ENVIRONMENT == 'development'){			
			?>
				<p class="text-primary text-center col-4 my-auto"><small class="text-secondary"> Ambiente: </small>DEV <small class="text-secondary"> BD: </small><?=$this->db->database?></p>
			<?php
				}
			?>

			<p class="text-primary text-center col-2 my-auto">
				<a href="https://tabasco.gob.mx/aviso-de-privacidad-dtit" target="_blank">Aviso de Privacidad</a>
			</p>
		</div>
	</footer>