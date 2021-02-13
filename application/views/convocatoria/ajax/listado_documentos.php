<option disabled selected>Seleccione un documento</option>
<?php foreach ( $documentos as $documento ): ?>
	<option value="<?= $documento['documento_id']; ?>" data-clave_docto="<?= $documento['cve_documento']; ?>"><?= $documento['documento']; ?></option>
<?php endforeach; ?>