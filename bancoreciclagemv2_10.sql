-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: testereciclagem2
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cestabasica`
--

DROP TABLE IF EXISTS `cestabasica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cestabasica` (
  `IdCestaBasica` smallint(6) NOT NULL AUTO_INCREMENT,
  `DescricaoCesta` varchar(50) NOT NULL,
  `ValorPorUnidade` smallint(6) NOT NULL,
  `QtdEstoque` int(11) NOT NULL,
  PRIMARY KEY (`IdCestaBasica`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cestabasica`
--

LOCK TABLES `cestabasica` WRITE;
/*!40000 ALTER TABLE `cestabasica` DISABLE KEYS */;
INSERT INTO `cestabasica` VALUES (1001,'PEQUENA',75,7),(1002,'MEDIA',150,84),(1003,'GRANDE',200,20);
/*!40000 ALTER TABLE `cestabasica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entregamaterial`
--

DROP TABLE IF EXISTS `entregamaterial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entregamaterial` (
  `IdEntrega` smallint(6) NOT NULL AUTO_INCREMENT,
  `IdMaterial` smallint(6) NOT NULL,
  `QtdEntregaKG` int(11) NOT NULL,
  `ValorGeradoEntrega` int(11) NOT NULL,
  `DataEntrega` date NOT NULL,
  `IdUsuario` bigint(20) NOT NULL,
  PRIMARY KEY (`IdEntrega`),
  KEY `fk_id_material` (`IdMaterial`),
  KEY `fk_id_usuario_material` (`IdUsuario`),
  CONSTRAINT `fk_id_material` FOREIGN KEY (`IdMaterial`) REFERENCES `materialreciclavel` (`IdMaterial`),
  CONSTRAINT `fk_id_usuario_material` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregamaterial`
--

LOCK TABLES `entregamaterial` WRITE;
/*!40000 ALTER TABLE `entregamaterial` DISABLE KEYS */;
INSERT INTO `entregamaterial` VALUES (3,507,5,10,'2025-05-11',1),(5,507,5,10,'2025-05-11',1),(6,507,5,10,'2025-05-12',1),(8,507,10,20,'2025-05-13',1),(9,507,20,40,'2025-05-14',1),(10,507,10,20,'2025-05-15',1);
/*!40000 ALTER TABLE `entregamaterial` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_entregamaterial_before_insert
BEFORE INSERT ON entregamaterial
FOR EACH ROW
BEGIN
    DECLARE v_valorPorPeso SMALLINT;

    -- Busca o ValorPorUnidade da cesta correspondente
    SELECT ValorPorPeso INTO v_valorPorPeso
    FROM materialreciclavel
    WHERE IdMaterial = NEW.IdMaterial;

    -- Calcula o ValorGeradoTroca
    SET NEW.ValorGeradoEntrega = NEW.QtdEntregaKG * v_valorPorPeso;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_entregamaterial_insert_movimentacao
AFTER INSERT ON entregamaterial
FOR EACH ROW
BEGIN
    INSERT INTO movimentacao (IdUsuario, IdTroca, IdEntrega, IdTipoMovimentacao)
    VALUES (NEW.IdUsuario, NULL, NEW.IdEntrega, 1);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_update_saldo_usuario_after_entrega
AFTER INSERT ON entregamaterial
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET SaldoCreditos = SaldoCreditos + NEW.ValorGeradoEntrega
    WHERE IdUsuario = NEW.IdUsuario;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_update_estoque_material_after_entrega
AFTER INSERT ON entregamaterial
FOR EACH ROW
BEGIN
    UPDATE materialreciclavel
    SET QtdEstoqueKG = QtdEstoqueKG + NEW.QtdEntregaKG
    WHERE IdMaterial = NEW.IdMaterial;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_entregamaterial_before_update
BEFORE UPDATE ON entregamaterial
FOR EACH ROW
BEGIN
    DECLARE v_valorPorPeso SMALLINT;

    -- Busca o ValorPorUnidade da cesta correspondente
    SELECT ValorPorPeso INTO v_valorPorPeso
    FROM materialreciclavel
    WHERE IdMaterial = NEW.IdMaterial;

    -- Calcula o ValorGeradoTroca
    SET NEW.ValorGeradoEntrega = NEW.QtdEntregaKG * v_valorPorPeso;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_subtrai_estoque_material_before_delete
BEFORE DELETE ON entregamaterial
FOR EACH ROW
BEGIN
    DECLARE estoqueAtual INT;

    -- Buscar o estoque atual do material
    SELECT QtdEstoqueKG INTO estoqueAtual
    FROM materialreciclavel
    WHERE IdMaterial = OLD.IdMaterial;

    -- Verificar se haverá estoque suficiente após a subtração
    IF estoqueAtual < OLD.QtdEntregaKG THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Estoque insuficiente para excluir esta entrega. A exclusão causaria estoque negativo.';
    ELSE
        -- Atualizar o estoque normalmente
        UPDATE materialreciclavel
        SET QtdEstoqueKG = QtdEstoqueKG - OLD.QtdEntregaKG
        WHERE IdMaterial = OLD.IdMaterial;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_deduz_creditos_usuario_before_delete
BEFORE DELETE ON entregamaterial
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET SaldoCreditos = SaldoCreditos - OLD.ValorGeradoEntrega
    WHERE IdUsuario = OLD.IdUsuario;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `materialreciclavel`
--

DROP TABLE IF EXISTS `materialreciclavel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materialreciclavel` (
  `IdMaterial` smallint(6) NOT NULL AUTO_INCREMENT,
  `TipoMaterial` varchar(50) NOT NULL,
  `ValorPorPeso` int(11) NOT NULL,
  `QtdEstoqueKG` int(11) NOT NULL,
  PRIMARY KEY (`IdMaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=519 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materialreciclavel`
--

LOCK TABLES `materialreciclavel` WRITE;
/*!40000 ALTER TABLE `materialreciclavel` DISABLE KEYS */;
INSERT INTO `materialreciclavel` VALUES (506,'ALUMINIO',13,10),(507,'FERRO',2,315),(508,'VIDRO',1,1000),(510,'PET',2,350),(511,'PP',3,580),(512,'PAPELÃO',2,370),(513,'COBRE',50,120),(514,'teste',7,0),(515,'as',1,0),(516,'ab',2,0),(517,'ac',2,0),(518,'asasda',-2,0);
/*!40000 ALTER TABLE `materialreciclavel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacao`
--

DROP TABLE IF EXISTS `movimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacao` (
  `IdMovimentacao` smallint(6) NOT NULL AUTO_INCREMENT,
  `IdUsuario` bigint(20) NOT NULL,
  `IdEntrega` smallint(6) DEFAULT NULL,
  `IdTroca` smallint(6) DEFAULT NULL,
  `IdTipoMovimentacao` smallint(6) NOT NULL,
  PRIMARY KEY (`IdMovimentacao`),
  KEY `fk_id_tipo_movimentacao2` (`IdTipoMovimentacao`),
  KEY `fk_id_usuario2` (`IdUsuario`),
  KEY `fk_id_entrega2` (`IdEntrega`),
  KEY `fk_id_troca2` (`IdTroca`),
  CONSTRAINT `fk_id_entrega2` FOREIGN KEY (`IdEntrega`) REFERENCES `entregamaterial` (`IdEntrega`) ON DELETE CASCADE,
  CONSTRAINT `fk_id_tipo_movimentacao2` FOREIGN KEY (`IdTipoMovimentacao`) REFERENCES `tipomovimentacao` (`IdTipoMovimentacao`),
  CONSTRAINT `fk_id_troca2` FOREIGN KEY (`IdTroca`) REFERENCES `trocacesta` (`IdTroca`) ON DELETE CASCADE,
  CONSTRAINT `fk_id_usuario2` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacao`
--

LOCK TABLES `movimentacao` WRITE;
/*!40000 ALTER TABLE `movimentacao` DISABLE KEYS */;
INSERT INTO `movimentacao` VALUES (3,1,3,NULL,1),(5,1,5,NULL,1),(6,1,NULL,1,2),(7,1,NULL,2,2),(8,1,6,NULL,1),(10,1,NULL,3,2),(11,1,NULL,4,2),(12,1,NULL,5,2),(13,1,NULL,6,2),(14,1,NULL,7,2),(15,1,NULL,8,2),(16,1,8,NULL,1),(17,1,NULL,9,2),(18,1,9,NULL,1),(19,1,10,NULL,1),(20,1,NULL,10,2),(21,1,NULL,11,2),(22,1,NULL,12,2);
/*!40000 ALTER TABLE `movimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipomovimentacao`
--

DROP TABLE IF EXISTS `tipomovimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipomovimentacao` (
  `IdTipoMovimentacao` smallint(6) NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IdTipoMovimentacao`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipomovimentacao`
--

LOCK TABLES `tipomovimentacao` WRITE;
/*!40000 ALTER TABLE `tipomovimentacao` DISABLE KEYS */;
INSERT INTO `tipomovimentacao` VALUES (1,'ENTREGA'),(2,'TROCA');
/*!40000 ALTER TABLE `tipomovimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trocacesta`
--

DROP TABLE IF EXISTS `trocacesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trocacesta` (
  `IdTroca` smallint(6) NOT NULL AUTO_INCREMENT,
  `IdCestaBasica` smallint(6) NOT NULL,
  `QtdTroca` smallint(6) NOT NULL,
  `ValorGeradoTroca` int(11) NOT NULL,
  `DataTroca` date NOT NULL,
  `IdUsuario` bigint(20) NOT NULL,
  PRIMARY KEY (`IdTroca`),
  KEY `fk_id_cesta_basica` (`IdCestaBasica`),
  KEY `fk_id_usuario_cesta` (`IdUsuario`),
  CONSTRAINT `fk_id_cesta_basica` FOREIGN KEY (`IdCestaBasica`) REFERENCES `cestabasica` (`IdCestaBasica`),
  CONSTRAINT `fk_id_usuario_cesta` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trocacesta`
--

LOCK TABLES `trocacesta` WRITE;
/*!40000 ALTER TABLE `trocacesta` DISABLE KEYS */;
INSERT INTO `trocacesta` VALUES (1,1001,1,500,'2025-05-12',1),(2,1001,1,500,'2025-05-12',1),(3,1001,1,500,'2025-05-12',1),(4,1001,1,500,'2025-05-12',1),(5,1001,1,500,'2025-05-12',1),(6,1001,1,500,'2025-05-13',1),(7,1001,1,500,'2025-05-13',1),(8,1001,1,500,'2025-05-13',1),(9,1002,1,750,'2025-05-14',1),(10,1001,10,750,'2025-05-15',1),(11,1001,30,2250,'2025-05-15',1),(12,1001,50,3750,'2025-05-15',1);
/*!40000 ALTER TABLE `trocacesta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_trocacesta_valida_antes_insert
BEFORE INSERT ON trocacesta
FOR EACH ROW
BEGIN
    DECLARE valorUnitario INT;
    DECLARE estoqueAtual INT;
    DECLARE saldoUsuario INT;
    DECLARE valorCalculado INT;

    -- 1. Obter valor por unidade e estoque da cesta
    SELECT ValorPorUnidade, QtdEstoque INTO valorUnitario, estoqueAtual
    FROM cestabasica
    WHERE IdCestaBasica = NEW.IdCestaBasica;

    -- 2. Calcular o valor da troca
    SET valorCalculado = NEW.QtdTroca * valorUnitario;
    SET NEW.ValorGeradoTroca = valorCalculado;

    -- 3. Validar estoque suficiente
    IF estoqueAtual < NEW.QtdTroca THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Estoque insuficiente para realizar a troca.';
    END IF;

    -- 4. Obter saldo do usuário
    SELECT SaldoCreditos INTO saldoUsuario
    FROM usuario
    WHERE IdUsuario = NEW.IdUsuario;

    -- 5. Validar saldo suficiente
    IF valorCalculado > saldoUsuario THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Saldo de créditos insuficiente para realizar a troca.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_trocacesta_insert_movimentacao
AFTER INSERT ON trocacesta
FOR EACH ROW
BEGIN
    INSERT INTO movimentacao (IdUsuario, IdTroca, IdEntrega, IdTipoMovimentacao)
    VALUES (NEW.IdUsuario, NEW.IdTroca, NULL, 2);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_update_saldo_usuario_after_troca
AFTER INSERT ON trocacesta
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET SaldoCreditos = SaldoCreditos - NEW.ValorGeradoTroca
    WHERE IdUsuario = NEW.IdUsuario;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_update_estoque_after_troca
AFTER INSERT ON trocacesta
FOR EACH ROW
BEGIN
    UPDATE cestabasica
    SET QtdEstoque = QtdEstoque - NEW.QtdTroca
    WHERE IdCestaBasica = NEW.IdCestaBasica;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_restitui_creditos_usuario_before_delete
BEFORE DELETE ON trocacesta
FOR EACH ROW
BEGIN
    UPDATE usuario
    SET SaldoCreditos = SaldoCreditos + OLD.ValorGeradoTroca
    WHERE IdUsuario = OLD.IdUsuario;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `IdUsuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Cpf` varchar(11) NOT NULL,
  `Telefone` varchar(15) NOT NULL,
  `Endereco` text NOT NULL,
  `UsuarioLogin` varchar(20) NOT NULL,
  `UsuarioSenha` varchar(45) NOT NULL,
  `SaldoCreditos` int(11) NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `Cpf` (`Cpf`),
  UNIQUE KEY `UsuarioLogin` (`UsuarioLogin`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','11111111111','(11) 99999-0000','Rua Exemplo, 123','admin','admin',1987130),(2,'JOAO CARLOS','22888888882','11737373-7575','Rua 148','joaocarlos','12345678',0);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-15 18:54:43
