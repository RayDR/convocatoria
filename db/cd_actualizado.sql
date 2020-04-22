-- MySQL dump 10.13  Distrib 5.7.15, for Win32 (AMD64)
--
-- Host: 192.168.73.81    Database: convocatoria_docente
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `datos_maestros`
--

DROP TABLE IF EXISTS `datos_maestros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datos_maestros`
--

LOCK TABLES `datos_maestros` WRITE;
/*!40000 ALTER TABLE `datos_maestros` DISABLE KEYS */;
INSERT INTO `datos_maestros` VALUES (1,'Raymundo','Dominguez','Ruiz','DORR950325HTCMZY07',1,'2020-03-18 21:59:49','2020-03-26 15:22:29');
/*!40000 ALTER TABLE `datos_maestros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos` (
  `documento_id` int(11) NOT NULL AUTO_INCREMENT,
  `cve_documento` varchar(5) DEFAULT NULL,
  `documento` varchar(160) DEFAULT NULL,
  `descripcion` text,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`documento_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos`
--

LOCK TABLES `documentos` WRITE;
/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
INSERT INTO `documentos` VALUES (1,'INE','INE','INE, Cédula Profesional o Pasaporte',1),(2,'CURP','CURP','CURP',2),(3,'AN','Acta de nacimiento','Acta de nacimiento, Carta de naturalización o permiso de trabajo para los extranjeros con residencia legal',3),(4,'CD','Comprobante de domicilio','Comprobante de domicilio con fecha de emisión no mayor a tres meses',4),(5,'TP/CP','Título Profesional o Cédula Profesional','Título Profesional o Cédula Profesional',5),(6,'CPT','Constancia Prueba T','Constancia de participación de la evaluación del manejo y dominio del lenguaje y la cultura digitales, que se obtendrá a través de la plataforma PruebaT, a la que se accederá mediante la página electrónica de la Coordinación Sectorial de Desarrollo Académico (COSDAC) de la Subsecretaría de Educación Media Superior: http://cosdac.sems.gob.mx/web/',6),(7,'CANU','Constancia  ANUIES','Constancia de acreditación del Curso de exploración de habilidades para la docencia en media superior impartido por la Asociación Nacional de Universidades e Instituciones de Educación Superior (ANUIES). Para mayor información ingresar a la página electrónica: www.anuies.mx',7),(8,'CI','Constancia Ingles','Constancia de acreditación de comprensión lectora del inglés, emitida por una institución educativa pública o privada, con reconocimiento de validez oficial.',8),(9,'CENNI','Certificado CENNI 12','Para los aspirantes a impartir la asignatura de Lengua adicional al Español (inglés), certificado CENNI nivel 12 o superior, dicho comprobante deberá estar vigente y ser emitido por la Dirección General de Acreditación, Incorporación y Revalidación (DGAIR), de la Secretaría de Educación Pública (www.cenni.sep.gob.mx). Estos participantes estarán exentos de presentar la constancia de compresión lectora de inglés.',9),(10,'CA','Carta de Aceptación','Carta de aceptación de las Bases de la presente Convocatoria; ésta le será proporcionada al momento de su registro y verificación documental.',10),(11,'FR','Ficha de Registro','Ficha para el Registro que se obtiene a través de la plataforma electrónica de la Unidad del Sistema para la Carrera de las Maestras y los Maestros al concluir el preregistro.',11),(12,'FTIBN','Dos fotografías recientes tamaño infantil, de frente, en blanco y negro.','Dos fotografías recientes tamaño infantil, de frente, en blanco y negro. (Pegar las fotos en una hoja en blanco en la parte superior alineadas)',12),(13,'DCPT','Documentación Componente Profesional Técnico','Documentación probatoria para acreditar su conocimiento y dominio de la disciplina del componente profesional técnico, en su caso y Manifestar al momento de su pre-registro su aceptación o no, para hacer públicos sus datos personales; ello con independencia del resultado y dictamen individual que se derive del proceso de selección. NOTA: Todas las constancias, certificados o Diplomas en un archivo PDF.',13);
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_adjuntos`
--

DROP TABLE IF EXISTS `documentos_adjuntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_adjuntos`
--

LOCK TABLES `documentos_adjuntos` WRITE;
/*!40000 ALTER TABLE `documentos_adjuntos` DISABLE KEYS */;
INSERT INTO `documentos_adjuntos` VALUES (1,'DORR950325HTCMZY07',1,13,'DORR950325HTCMZY07_INE.pdf','2020-03-18 22:00:03','2020-03-18 22:00:03'),(2,'DORR950325HTCMZY07',1,2,'DORR950325HTCMZY07_CURP.pdf','2020-03-18 22:00:16','2020-03-18 22:00:16'),(3,'DORR950325HTCMZY07',1,1,'DORR950325HTCMZY07_AN.pdf','2020-03-18 22:02:31','2020-03-18 22:02:31'),(4,'DORR950325HTCMZY07',1,12,'DORR950325HTCMZY07_CD.pdf','2020-03-18 22:02:38','2020-04-20 19:15:14'),(5,'DORR950325HTCMZY07',1,3,'DORR950325HTCMZY07_AEP.pdf','2020-03-18 22:02:48','2020-03-18 22:02:48'),(6,'DORR950325HTCMZY07',1,6,'DORR950325HTCMZY07_CPL.pdf','2020-03-18 22:02:55','2020-03-18 22:02:55'),(7,'DORR950325HTCMZY07',1,4,'DORR950325HTCMZY07_CENNI.pdf','2020-03-18 22:02:59','2020-03-18 22:02:59');
/*!40000 ALTER TABLE `documentos_adjuntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_digitales`
--

DROP TABLE IF EXISTS `documentos_digitales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos_digitales` (
  `documento_digital_id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_titulo_id` int(11) DEFAULT NULL,
  `documento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`documento_digital_id`) USING BTREE,
  KEY `fk_tt_tdocto` (`tipo_titulo_id`) USING BTREE,
  KEY `fk_docto_tdocto` (`documento_id`) USING BTREE,
  CONSTRAINT `documentos_digitales_ibfk_1` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`documento_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `documentos_digitales_ibfk_2` FOREIGN KEY (`tipo_titulo_id`) REFERENCES `tipo_titulos` (`tipo_titulo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_digitales`
--

LOCK TABLES `documentos_digitales` WRITE;
/*!40000 ALTER TABLE `documentos_digitales` DISABLE KEYS */;
INSERT INTO `documentos_digitales` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13);
/*!40000 ALTER TABLE `documentos_digitales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus_doctos`
--

DROP TABLE IF EXISTS `estatus_doctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `tipo_titulos`
--

DROP TABLE IF EXISTS `tipo_titulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Temporary view structure for view `vw_doctos_digitales`
--

DROP TABLE IF EXISTS `vw_doctos_digitales`;
/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_doctos_digitales` AS SELECT 
 1 AS `tipo_titulo_id`,
 1 AS `descripcion`,
 1 AS `documento_id`,
 1 AS `cve_documento`,
 1 AS `documento`,
 1 AS `descripcion_docto`,
 1 AS `orden`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_doctos_digitales_agrup`
--

DROP TABLE IF EXISTS `vw_doctos_digitales_agrup`;
/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales_agrup`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
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
SET character_set_client = utf8;
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
 1 AS `orden`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_doctos_digitales`
--

/*!50001 DROP VIEW IF EXISTS `vw_doctos_digitales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_doctos_digitales` AS select `dd`.`tipo_titulo_id` AS `tipo_titulo_id`,`tt`.`descripcion` AS `descripcion`,`dd`.`documento_id` AS `documento_id`,`d`.`cve_documento` AS `cve_documento`,`d`.`documento` AS `documento`,`d`.`descripcion` AS `descripcion_docto`,`d`.`orden` AS `orden` from ((`documentos_digitales` `dd` join `documentos` `d` on((`dd`.`documento_id` = `d`.`documento_id`))) join `tipo_titulos` `tt` on((`dd`.`tipo_titulo_id` = `tt`.`tipo_titulo_id`))) */;
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
/*!50001 VIEW `vw_documentos_subidos` AS select `da`.`archivo` AS `archivo`,`da`.`fecha_creacion` AS `fecha_creacion`,`da`.`fecha_modificacion` AS `fecha_modificacion`,`da`.`curp` AS `curp`,`ddt`.`tipo_titulo_id` AS `tipo_titulo_id`,`ddt`.`descripcion` AS `descripcion`,`ddt`.`documento_id` AS `documento_id`,`ddt`.`cve_documento` AS `cve_documento`,`ddt`.`documento` AS `documento`,`ddt`.`orden` AS `orden` from (`documentos_adjuntos` `da` join `vw_doctos_digitales` `ddt` on(((`ddt`.`documento_id` = `da`.`documento_id`) and (`ddt`.`tipo_titulo_id` = `da`.`tipo_titulo_id`)))) */;
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

-- Dump completed on 2020-04-20 14:24:33
