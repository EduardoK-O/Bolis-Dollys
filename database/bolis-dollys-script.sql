-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bollis_dollys
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bollis_dollys
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `bolis_dollys` DEFAULT CHARACTER SET utf8 ;
USE `bolis_dollys` ;

-- -----------------------------------------------------
-- Table `bollis_dollys`.`tipo_boli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`tipo_boli` (
  `id_tipo_boli` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`id_tipo_boli`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`bolis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`bolis` (
  `id_boli` INT NOT NULL,
  `sabor` VARCHAR(45) NULL,
  `stock` INT NULL,
  `id_tipo_boli` INT NOT NULL,
  PRIMARY KEY (`id_boli`),
  INDEX `fk_bolis_tipo_boli_idx` (`id_tipo_boli` ASC) VISIBLE,
  CONSTRAINT `fk_bolis_tipo_boli`
    FOREIGN KEY (`id_tipo_boli`)
    REFERENCES `bollis_dollys`.`tipo_boli` (`id_tipo_boli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`medidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`medidas` (
  `id_medida` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_medida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`ingredientes` (
  `id_ingrediente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cantidad` INT NULL,
  `precio` INT NULL,
  `id_medida` INT NOT NULL,
  PRIMARY KEY (`id_ingrediente`),
  INDEX `fk_ingredientes_medidas1_idx` (`id_medida` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_medidas1`
    FOREIGN KEY (`id_medida`)
    REFERENCES `bollis_dollys`.`medidas` (`id_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`recetas` (
  `id_receta` INT NOT NULL,
  `id_boli` INT NOT NULL,
  PRIMARY KEY (`id_receta`),
  INDEX `fk_recetas_bolis1_idx` (`id_boli` ASC) VISIBLE,
  CONSTRAINT `fk_recetas_bolis1`
    FOREIGN KEY (`id_boli`)
    REFERENCES `bollis_dollys`.`bolis` (`id_boli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`ingredientes_receta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`ingredientes_receta` (
  `id_igrendiente_receta` VARCHAR(45) NOT NULL,
  `id_receta` INT NOT NULL,
  `id_ingrediente` INT NOT NULL,
  `cantidad` INT NULL,
  `id_medida` INT NOT NULL,
  INDEX `fk_ingredientes_has_recetas_medidas1_idx` (`id_medida` ASC) VISIBLE,
  INDEX `fk_ingredientes_receta_ingredientes1_idx` (`id_ingrediente` ASC) VISIBLE,
  INDEX `fk_ingredientes_receta_recetas1_idx` (`id_receta` ASC) VISIBLE,
  PRIMARY KEY (`id_igrendiente_receta`),
  CONSTRAINT `fk_ingredientes_has_recetas_medidas1`
    FOREIGN KEY (`id_medida`)
    REFERENCES `bollis_dollys`.`medidas` (`id_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_receta_ingredientes1`
    FOREIGN KEY (`id_ingrediente`)
    REFERENCES `bollis_dollys`.`ingredientes` (`id_ingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_receta_recetas1`
    FOREIGN KEY (`id_receta`)
    REFERENCES `bollis_dollys`.`recetas` (`id_receta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`ingredientes_base`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`ingredientes_base` (
  `id_ingredientes_base` INT NOT NULL,
  `id_ingrediente` INT NOT NULL,
  `cantidad` INT NULL,
  `id_medida` INT NOT NULL,
  PRIMARY KEY (`id_ingredientes_base`),
  INDEX `fk_ingredientes_base_ingredientes1_idx` (`id_ingrediente` ASC) VISIBLE,
  INDEX `fk_ingredientes_base_medidas1_idx` (`id_medida` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_base_ingredientes1`
    FOREIGN KEY (`id_ingrediente`)
    REFERENCES `bollis_dollys`.`ingredientes` (`id_ingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_base_medidas1`
    FOREIGN KEY (`id_medida`)
    REFERENCES `bollis_dollys`.`medidas` (`id_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`sucursales` (
  `id_sucursal` INT NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_sucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`ventas` (
  `id_venta` INT NOT NULL,
  `fecha` DATETIME NULL,
  `total_venta` INT NULL,
  `id_sucursal` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_ventas_sucursales1_idx` (`id_sucursal` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_sucursales1`
    FOREIGN KEY (`id_sucursal`)
    REFERENCES `bollis_dollys`.`sucursales` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bollis_dollys`.`productos_vendidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bollis_dollys`.`productos_vendidos` (
  `id_productos_vendidos` INT NOT NULL,
  `id_venta` INT NOT NULL,
  `id_boli` INT NOT NULL,
  PRIMARY KEY (`id_productos_vendidos`),
  INDEX `fk_productos_vendidos_ventas1_idx` (`id_venta` ASC) VISIBLE,
  INDEX `fk_productos_vendidos_bolis1_idx` (`id_boli` ASC) VISIBLE,
  CONSTRAINT `fk_productos_vendidos_ventas1`
    FOREIGN KEY (`id_venta`)
    REFERENCES `bollis_dollys`.`ventas` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_vendidos_bolis1`
    FOREIGN KEY (`id_boli`)
    REFERENCES `bollis_dollys`.`bolis` (`id_boli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
