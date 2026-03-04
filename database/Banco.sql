CREATE DATABASE  IF NOT EXISTS `controle_estoque` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `controle_estoque`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: controle_estoque
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `id_fornecedor` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `datacadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicopreco`
--

DROP TABLE IF EXISTS `historicopreco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historicopreco` (
  `id_historicopreco` bigint NOT NULL AUTO_INCREMENT,
  `id_material` bigint NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `datainicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datafim` datetime DEFAULT NULL,
  PRIMARY KEY (`id_historicopreco`),
  KEY `material_historicopreco_fk` (`id_material`),
  CONSTRAINT `material_historicopreco_fk` FOREIGN KEY (`id_material`) REFERENCES `material` (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historicopreco`
--

LOCK TABLES `historicopreco` WRITE;
/*!40000 ALTER TABLE `historicopreco` DISABLE KEYS */;
/*!40000 ALTER TABLE `historicopreco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localestoque`
--

DROP TABLE IF EXISTS `localestoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localestoque` (
  `id_local` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localestoque`
--

LOCK TABLES `localestoque` WRITE;
/*!40000 ALTER TABLE `localestoque` DISABLE KEYS */;
INSERT INTO `localestoque` VALUES (1,'Depósito Principal'),(2,'Área de Corte'),(3,'Prateleira de Ferragens'),(4,'Almoxarifado');
/*!40000 ALTER TABLE `localestoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `id_material` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `id_tipomaterial` int NOT NULL,
  `id_unidademedida` smallint NOT NULL,
  `id_local` int DEFAULT NULL,
  `estoqueminimo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estoqueatual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `imagem` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `datacadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_material`),
  KEY `tipomaterial_material_fk` (`id_tipomaterial`),
  KEY `unidademedida_material_fk` (`id_unidademedida`),
  KEY `localestoque_material_fk` (`id_local`),
  CONSTRAINT `localestoque_material_fk` FOREIGN KEY (`id_local`) REFERENCES `localestoque` (`id_local`),
  CONSTRAINT `tipomaterial_material_fk` FOREIGN KEY (`id_tipomaterial`) REFERENCES `tipomaterial` (`id_tipomaterial`),
  CONSTRAINT `unidademedida_material_fk` FOREIGN KEY (`id_unidademedida`) REFERENCES `unidademedida` (`id_unidademedida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacaoestoque`
--

DROP TABLE IF EXISTS `movimentacaoestoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacaoestoque` (
  `id_movimentacao` bigint NOT NULL AUTO_INCREMENT,
  `id_material` bigint NOT NULL,
  `id_usuario` bigint NOT NULL,
  `id_fornecedor` bigint DEFAULT NULL,
  `id_tipo` smallint NOT NULL,
  `quantidade` decimal(10,2) NOT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `valortotal` decimal(10,2) DEFAULT NULL,
  `numerodocumento` varchar(50) DEFAULT NULL,
  `datamovimentacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_movimentacao`),
  KEY `material_movimentacaoestoque_fk` (`id_material`),
  KEY `usuario_movimentacaoestoque_fk` (`id_usuario`),
  KEY `fornecedor_movimentacaoestoque_fk` (`id_fornecedor`),
  KEY `tipomovimentacao_movimentacaoestoque_fk` (`id_tipo`),
  CONSTRAINT `fornecedor_movimentacaoestoque_fk` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `material_movimentacaoestoque_fk` FOREIGN KEY (`id_material`) REFERENCES `material` (`id_material`),
  CONSTRAINT `tipomovimentacao_movimentacaoestoque_fk` FOREIGN KEY (`id_tipo`) REFERENCES `tipomovimentacao` (`id_tipo`),
  CONSTRAINT `usuario_movimentacaoestoque_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacaoestoque`
--

LOCK TABLES `movimentacaoestoque` WRITE;
/*!40000 ALTER TABLE `movimentacaoestoque` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimentacaoestoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipomaterial`
--

DROP TABLE IF EXISTS `tipomaterial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipomaterial` (
  `id_tipomaterial` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipomaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipomaterial`
--

LOCK TABLES `tipomaterial` WRITE;
/*!40000 ALTER TABLE `tipomaterial` DISABLE KEYS */;
INSERT INTO `tipomaterial` VALUES (1,'MDF'),(2,'Ferragem'),(3,'Cola'),(4,'Fita de Borda'),(5,'Ferramenta'),(6,'Acessório'),(7,'Outros');
/*!40000 ALTER TABLE `tipomaterial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipomovimentacao`
--

DROP TABLE IF EXISTS `tipomovimentacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipomovimentacao` (
  `id_tipo` smallint NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipomovimentacao`
--

LOCK TABLES `tipomovimentacao` WRITE;
/*!40000 ALTER TABLE `tipomovimentacao` DISABLE KEYS */;
INSERT INTO `tipomovimentacao` VALUES (1,'Entrada'),(2,'Saída');
/*!40000 ALTER TABLE `tipomovimentacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `id_tipousuario` smallint NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipousuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Administrador'),(2,'Funcionário');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidademedida`
--

DROP TABLE IF EXISTS `unidademedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidademedida` (
  `id_unidademedida` smallint NOT NULL AUTO_INCREMENT,
  `descricao` varchar(30) NOT NULL,
  `sigla` varchar(10) NOT NULL,
  PRIMARY KEY (`id_unidademedida`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidademedida`
--

LOCK TABLES `unidademedida` WRITE;
/*!40000 ALTER TABLE `unidademedida` DISABLE KEYS */;
INSERT INTO `unidademedida` VALUES (1,'Unidade','UN'),(2,'Metro','M'),(3,'Metro Quadrado','M²'),(4,'Litro','L'),(5,'Quilograma','KG'),(6,'Milímetro','MM');
/*!40000 ALTER TABLE `unidademedida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `datacadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_tipousuario` smallint NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `tipousuario_usuario_fk` (`id_tipousuario`),
  CONSTRAINT `tipousuario_usuario_fk` FOREIGN KEY (`id_tipousuario`) REFERENCES `tipousuario` (`id_tipousuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`nome`, `email`, `senha`, `ativo`, `id_tipousuario`) VALUES
('Administrador', 'admin@hrs.com', '$2b$12$d8CdIY2E8kYvFk9nBC1zP.OdFjGSmfkOimdmf2.m8l1zCzOKAx.JO', 1, 1);
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

-- Dump completed on 2026-02-28 12:58:16