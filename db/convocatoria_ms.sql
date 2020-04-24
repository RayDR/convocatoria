-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: convocatoria_docente
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clasificaciones`
--

DROP TABLE IF EXISTS `clasificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clasificaciones` (
  `clasificacion_id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clasificacion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clasificaciones`
--

LOCK TABLES `clasificaciones` WRITE;
/*!40000 ALTER TABLE `clasificaciones` DISABLE KEYS */;
INSERT INTO `clasificaciones` VALUES (1,'Requisitos para la Admisión'),(2,'Elementos Multifactoriales'),(3,'Documentos de Registro'),(4,'Sedes de Apliacación');
/*!40000 ALTER TABLE `clasificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datos_maestros`
--

DROP TABLE IF EXISTS `datos_maestros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datos_maestros` (
  `dato_maestro_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) DEFAULT NULL,
  `ap_paterno` varchar(80) DEFAULT NULL,
  `ap_materno` varchar(80) DEFAULT NULL,
  `curp` varchar(18) NOT NULL,
  `tipo_titulo_id` int(11) DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dato_maestro_id`),
  KEY `idx_curp` (`curp`),
  KEY `unq_curp` (`curp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datos_maestros`
--

LOCK TABLES `datos_maestros` WRITE;
/*!40000 ALTER TABLE `datos_maestros` DISABLE KEYS */;
/*!40000 ALTER TABLE `datos_maestros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos` (
  `documento_id` int(11) NOT NULL AUTO_INCREMENT,
  `cve_documento` varchar(5) DEFAULT NULL,
  `documento` varchar(160) DEFAULT NULL,
  `descripcion` text,
  `orden` int(11) DEFAULT NULL,
  `clasificacion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`documento_id`) USING BTREE,
  KEY `fk_clasificacion` (`clasificacion_id`),
  CONSTRAINT `fk_clasificacion` FOREIGN KEY (`clasificacion_id`) REFERENCES `clasificaciones` (`clasificacion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos`
--

LOCK TABLES `documentos` WRITE;
/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
INSERT INTO `documentos` VALUES (1,'INE','INE','INE, Cédula Profesional o Pasaporte',1,1),(2,'CURP','CURP','CURP',2,1),(3,'AN','Acta de nacimiento','Acta de nacimiento, Carta de naturalización o permiso de trabajo para los extranjeros con residencia legal',3,1),(4,'CD','Comprobante de domicilio','Comprobante de domicilio con fecha de emisión no mayor a tres meses',4,1),(5,'TPCP','Título Profesional o Cédula Profesional','Título Profesional o Cédula Profesional',5,1),(6,'CPT','Constancia Prueba T','Constancia de participación de la evaluación del manejo y dominio del lenguaje y la cultura digitales, que se obtendrá a través de la plataforma PruebaT, a la que se accederá mediante la página electrónica de la Coordinación Sectorial de Desarrollo Académico (COSDAC) de la Subsecretaría de Educación Media Superior: http://cosdac.sems.gob.mx/web/',6,1),(7,'CANU','Constancia  ANUIES','Constancia de acreditación del Curso de exploración de habilidades para la docencia en media superior impartido por la Asociación Nacional de Universidades e Instituciones de Educación Superior (ANUIES). Para mayor información ingresar a la página electrónica: www.anuies.mx',7,1),(8,'CI','Constancia Ingles','Constancia de acreditación de comprensión lectora del inglés, emitida por una institución educativa pública o privada, con reconocimiento de validez oficial.',8,1),(9,'CENNI','Certificado CENNI 12','Para los aspirantes a impartir la asignatura de Lengua adicional al Español (inglés), certificado CENNI nivel 12 o superior, dicho comprobante deberá estar vigente y ser emitido por la Dirección General de Acreditación, Incorporación y Revalidación (DGAIR), de la Secretaría de Educación Pública (www.cenni.sep.gob.mx). Estos participantes estarán exentos de presentar la constancia de compresión lectora de inglés.',9,1),(10,'CA','Carta de Aceptación','Carta de aceptación de las Bases de la presente Convocatoria; ésta le será proporcionada al momento de su registro y verificación documental.',10,1),(11,'FRCF','Ficha de Registro con Fotografía','Ficha para el Registro con fotografía que se obtiene a través de la plataforma electrónica de la Unidad del Sistema para la Carrera de las Maestras y los Maestros al concluir el preregistro.',11,1),(12,'DCPT','Documentación Componente Profesional Técnico','Documentación probatoria para acreditar su conocimiento y dominio de la disciplina del componente profesional técnico, en su caso y Manifestar al momento de su pre-registro su aceptación o no, para hacer públicos sus datos personales; ello con independencia del resultado y dictamen individual que se derive del proceso de selección. NOTA: Todas las constancias, certificados o Diplomas en un archivo PDF.',12,1),(13,'MDLCD','Manejo y dominio del lenguaje y la cultura digitales','Constancia del curso',13,2),(14,'ACDMS','Acreditación del Curso exploración de habilidades para la docencia en media superior.','Constancia del curso',14,2),(15,'CERVC','Cursos extracurriculares con reconocimiento con valor curricular','Constancia, Certificado o Diploma',15,2),(16,'CDYP','Capacitación didáctica y pedagógica','Constancia, Diploma',16,2),(17,'EXDOC','Experiencia docente','Constancia, Hoja de Servicios',17,2),(18,'FRCFF','Ficha para el Registro (con fotografía y firmada)','Ficha para el Registro (con fotografía y firmada)',18,3),(19,'SCITA','Selección de cita','Escaneo de su Cita',19,3);
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_adjuntos`
--

DROP TABLE IF EXISTS `documentos_adjuntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos_adjuntos` (
  `documento_adjunto_id` int(11) NOT NULL AUTO_INCREMENT,
  `curp` varchar(18) DEFAULT NULL,
  `tipo_titulo_id` int(11) DEFAULT '1',
  `documento_id` int(11) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`documento_adjunto_id`) USING BTREE,
  KEY `fk_titulo_docto` (`curp`) USING BTREE,
  KEY `fk_documento_id` (`documento_id`) USING BTREE,
  KEY `fk_tipo_docto` (`tipo_titulo_id`) USING BTREE,
  CONSTRAINT `documentos_adjuntos_ibfk_1` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`documento_id`),
  CONSTRAINT `documentos_adjuntos_ibfk_3` FOREIGN KEY (`tipo_titulo_id`) REFERENCES `tipo_titulos` (`tipo_titulo_id`),
  CONSTRAINT `fk_curp` FOREIGN KEY (`curp`) REFERENCES `datos_maestros` (`curp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_adjuntos`
--

LOCK TABLES `documentos_adjuntos` WRITE;
/*!40000 ALTER TABLE `documentos_adjuntos` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentos_adjuntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_digitales`
--

DROP TABLE IF EXISTS `documentos_digitales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos_digitales` (
  `documento_digital_id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_titulo_id` int(11) DEFAULT NULL,
  `documento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`documento_digital_id`) USING BTREE,
  KEY `fk_tt_tdocto` (`tipo_titulo_id`) USING BTREE,
  KEY `fk_docto_tdocto` (`documento_id`) USING BTREE,
  CONSTRAINT `documentos_digitales_ibfk_1` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`documento_id`),
  CONSTRAINT `documentos_digitales_ibfk_2` FOREIGN KEY (`tipo_titulo_id`) REFERENCES `tipo_titulos` (`tipo_titulo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_digitales`
--

LOCK TABLES `documentos_digitales` WRITE;
/*!40000 ALTER TABLE `documentos_digitales` DISABLE KEYS */;
INSERT INTO `documentos_digitales` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19);
/*!40000 ALTER TABLE `documentos_digitales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus_doctos`
--

DROP TABLE IF EXISTS `estatus_doctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estatus_doctos` (
  `estatus_docto_id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`estatus_docto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_doctos`
--

LOCK TABLES `estatus_doctos` WRITE;
/*!40000 ALTER TABLE `estatus_doctos` DISABLE KEYS */;
INSERT INTO `estatus_doctos` VALUES (1,'VALIDA'),(2,'NO VALIDO'),(3,'OBSERVACIONES');
/*!40000 ALTER TABLE `estatus_doctos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_documentos_adjuntos`
--

DROP TABLE IF EXISTS `logs_documentos_adjuntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_documentos_adjuntos` (
  `log_documento_adjunto_id` int(11) NOT NULL AUTO_INCREMENT,
  `dato_maestro_id` int(11) NOT NULL,
  `documento_adjunto_id` int(11) NOT NULL,
  `estatus_docto_id` int(11) NOT NULL DEFAULT '2' COMMENT 'Se utiliza la Tabla de status_titulos',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_documento_adjunto_id`),
  KEY `fk_titulo_log` (`dato_maestro_id`),
  KEY `fk_docto_id` (`documento_adjunto_id`) USING BTREE,
  CONSTRAINT `fk_estatus` FOREIGN KEY (`documento_adjunto_id`) REFERENCES `estatus_doctos` (`estatus_docto_id`),
  CONSTRAINT `logs_documentos_adjuntos_ibfk_1` FOREIGN KEY (`documento_adjunto_id`) REFERENCES `documentos_adjuntos` (`documento_adjunto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_documentos_adjuntos`
--

LOCK TABLES `logs_documentos_adjuntos` WRITE;
/*!40000 ALTER TABLE `logs_documentos_adjuntos` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_documentos_adjuntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maestros_sedes`
--

DROP TABLE IF EXISTS `maestros_sedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maestros_sedes` (
  `maestro_sede_id` int(11) NOT NULL AUTO_INCREMENT,
  `dato_maestro_id` int(11) DEFAULT NULL,
  `curp` varchar(18) DEFAULT NULL,
  `sede_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`maestro_sede_id`),
  KEY `fk_sede_01` (`sede_id`),
  CONSTRAINT `fk_sede_01` FOREIGN KEY (`sede_id`) REFERENCES `sedes` (`sede_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maestros_sedes`
--

LOCK TABLES `maestros_sedes` WRITE;
/*!40000 ALTER TABLE `maestros_sedes` DISABLE KEYS */;
/*!40000 ALTER TABLE `maestros_sedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sedes`
--

DROP TABLE IF EXISTS `sedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sedes` (
  `sede_id` int(11) NOT NULL AUTO_INCREMENT,
  `num_sede` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sede_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sedes`
--

LOCK TABLES `sedes` WRITE;
/*!40000 ALTER TABLE `sedes` DISABLE KEYS */;
INSERT INTO `sedes` VALUES (1,27004,'Centro de Cómputo de la Universidad Juárez Autónoma de Tabasco ','Av. Universidad S/N, Zona de la Cultura, C.P. 86040, Villahermosa, Tabasco. '),(2,27005,'División Académica de Ciencias de la Salud de la Universidad Juárez Autónoma de Tabasco ','Av. Gregorio Méndez no. 2838-A, Col. Tamulté, C.P. 86100, Villahermosa, Tabasco. '),(3,27006,'División Académica de Ciencias Sociales y Humanidades de la Universidad Juárez Autónoma de Tabasco ','Prolongación de Av. Paseo Usumacinta s/n, C.P. 86280, Ranchería González Primera Sección, Tabasco. '),(4,27009,'Instituto Tecnológico de Villahermosa ','Carr. Villahermosa-Frontera km. 3.5, Ciudad Industrial, C.P. 86010, Villahermosa, Tabasco. '),(5,27010,'Universidad Autónoma de Guadalajara ','Prol. Paseo Usumacinta, km 3.5, Fracc. El Country, C.P. 86280, Villahermosa, Tabasco. '),(6,27014,'Universidad Tecnológica de Tabasco (UTTAB) ','Carr. Villahermosa-Teapa km. 14.6 s/n, Fracc. Parrilla II, C.P. 86280, Tabasco. '),(7,27015,'Universidad Tecmilenio ','José Mariscal s/n Esq. Periférico, Col. José María Pino Suárez, C.P. 86029, Villahermosa, Tabasco. '),(8,27017,'Universidad del Valle de México ','Av. México no. 703, Fracc. Guadalupe, C.P. 86190, Villahermosa, Tabasco. ');
/*!40000 ALTER TABLE `sedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_titulos`
--

DROP TABLE IF EXISTS `tipo_titulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_titulos` (
  `tipo_titulo_id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`tipo_titulo_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_titulos`
--

LOCK TABLES `tipo_titulos` WRITE;
/*!40000 ALTER TABLE `tipo_titulos` DISABLE KEYS */;
INSERT INTO `tipo_titulos` VALUES (1,'DOCUMENTOS GENERALES'),(2,'LICENCIATURA'),(3,'MAESTRÍA'),(4,'DOCTORADO'),(5,'ESPECIALIDAD');
/*!40000 ALTER TABLE `tipo_titulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_datos_maestros_sede`
--

DROP TABLE IF EXISTS `vw_datos_maestros_sede`;
/*!50001 DROP VIEW IF EXISTS `vw_datos_maestros_sede`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_datos_maestros_sede` AS SELECT 
 1 AS `dato_maestro_id`,
 1 AS `nombres`,
 1 AS `ap_paterno`,
 1 AS `curp`,
 1 AS `fecha_creacion`,
 1 AS `fecha_modificacion`,
 1 AS `sede_id`,
 1 AS `sede`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_doctos_digitales`
--

DROP TABLE IF EXISTS `vw_doctos_digitales`;
/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_doctos_digitales` AS SELECT 
 1 AS `tipo_titulo_id`,
 1 AS `descripcion`,
 1 AS `documento_id`,
 1 AS `cve_documento`,
 1 AS `documento`,
 1 AS `descripcion_docto`,
 1 AS `orden`,
 1 AS `clasificacion_id`,
 1 AS `descripcion_clasif`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_doctos_digitales_agrup`
--

DROP TABLE IF EXISTS `vw_doctos_digitales_agrup`;
/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales_agrup`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_doctos_digitales_agrup` AS SELECT 
 1 AS `tipo_titulo_id`,
 1 AS `descripcion`,
 1 AS `documentos`,
 1 AS `documento_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_documentos_subidos`
--

DROP TABLE IF EXISTS `vw_documentos_subidos`;
/*!50001 DROP VIEW IF EXISTS `vw_documentos_subidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_documentos_subidos` AS SELECT 
 1 AS `archivo`,
 1 AS `fecha_creacion`,
 1 AS `fecha_modificacion`,
 1 AS `curp`,
 1 AS `tipo_titulo_id`,
 1 AS `descripcion`,
 1 AS `documento_id`,
 1 AS `cve_documento`,
 1 AS `documento`,
 1 AS `clasificacion_id`,
 1 AS `descripcion_clasif`,
 1 AS `orden`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_datos_maestros_sede`
--

/*!50001 DROP VIEW IF EXISTS `vw_datos_maestros_sede`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_datos_maestros_sede` AS select `dm`.`dato_maestro_id` AS `dato_maestro_id`,max(`dm`.`nombres`) AS `nombres`,max(`dm`.`ap_paterno`) AS `ap_paterno`,max(`dm`.`curp`) AS `curp`,max(`dm`.`fecha_creacion`) AS `fecha_creacion`,max(`dm`.`fecha_modificacion`) AS `fecha_modificacion`,group_concat(`ms`.`sede_id` separator ',') AS `sede_id`,group_concat(`s`.`num_sede`,'-',`s`.`nombre` separator ',') AS `sede` from ((`datos_maestros` `dm` join `maestros_sedes` `ms` on((`ms`.`dato_maestro_id` = `dm`.`dato_maestro_id`))) join `sedes` `s` on((`s`.`sede_id` = `ms`.`sede_id`))) group by `dm`.`dato_maestro_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_doctos_digitales`
--

/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_doctos_digitales` AS select `dd`.`tipo_titulo_id` AS `tipo_titulo_id`,`tt`.`descripcion` AS `descripcion`,`dd`.`documento_id` AS `documento_id`,`d`.`cve_documento` AS `cve_documento`,`d`.`documento` AS `documento`,`d`.`descripcion` AS `descripcion_docto`,`d`.`orden` AS `orden`,`d`.`clasificacion_id` AS `clasificacion_id`,`c`.`descripcion` AS `descripcion_clasif` from (((`documentos_digitales` `dd` join `documentos` `d` on((`dd`.`documento_id` = `d`.`documento_id`))) join `tipo_titulos` `tt` on((`dd`.`tipo_titulo_id` = `tt`.`tipo_titulo_id`))) join `clasificaciones` `c` on((`c`.`clasificacion_id` = `d`.`clasificacion_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_doctos_digitales_agrup`
--

/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales_agrup`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_doctos_digitales_agrup` AS select `vddt`.`tipo_titulo_id` AS `tipo_titulo_id`,`vddt`.`descripcion` AS `descripcion`,group_concat(concat(`vddt`.`cve_documento`,'-',`vddt`.`documento`) order by `vddt`.`documento_id` ASC separator ',') AS `documentos`,group_concat(`vddt`.`documento_id` order by `vddt`.`documento_id` ASC separator ',') AS `documento_id` from `vw_doctos_digitales` `vddt` group by `vddt`.`tipo_titulo_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_documentos_subidos`
--

/*!50001 DROP VIEW IF EXISTS `vw_documentos_subidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_documentos_subidos` AS select `da`.`archivo` AS `archivo`,`da`.`fecha_creacion` AS `fecha_creacion`,`da`.`fecha_modificacion` AS `fecha_modificacion`,`da`.`curp` AS `curp`,`ddt`.`tipo_titulo_id` AS `tipo_titulo_id`,`ddt`.`descripcion` AS `descripcion`,`ddt`.`documento_id` AS `documento_id`,`ddt`.`cve_documento` AS `cve_documento`,`ddt`.`documento` AS `documento`,`ddt`.`clasificacion_id` AS `clasificacion_id`,`ddt`.`descripcion_clasif` AS `descripcion_clasif`,`ddt`.`orden` AS `orden` from (`documentos_adjuntos` `da` join `vw_doctos_digitales` `ddt` on(((`ddt`.`documento_id` = `da`.`documento_id`) and (`ddt`.`tipo_titulo_id` = `da`.`tipo_titulo_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-24 18:15:34
