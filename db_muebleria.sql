SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `db_muebleria` DEFAULT CHARACTER SET utf8 ;
USE `db_muebleria` ;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`categorias` (
  `idcategorias` INT NOT NULL,
  `sofa` VARCHAR(45) NOT NULL,
  `armario` VARCHAR(45) NOT NULL,
  `mesa` VARCHAR(45) NOT NULL,
  `escritorio` VARCHAR(45) NOT NULL,
  `silla` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategorias`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`proveedor` (
  `idproveedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefonos` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `Fax` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproveedor`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`productos` (
  `idproductos` INT NOT NULL,
  `nombre_prod` VARCHAR(45) NOT NULL,
  `precio` VARCHAR(45) NOT NULL,
  `categorias_idcategorias` INT NOT NULL,
  `proveedor_idproveedor` INT NOT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_categorias_idx` (`categorias_idcategorias` ASC) VISIBLE,
  INDEX `fk_productos_proveedor1_idx` (`proveedor_idproveedor` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias`
    FOREIGN KEY (`categorias_idcategorias`)
    REFERENCES `db_muebleria`.`categorias` (`idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_proveedor1`
    FOREIGN KEY (`proveedor_idproveedor`)
    REFERENCES `db_muebleria`.`proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`clientes` (
  `idclientes` INT NOT NULL,
  `nombre_cli` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`ventas` (
  `idventas` INT NOT NULL,
  `total_pago` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`idventas`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_idclientes` ASC) VISIBLE,
  INDEX `fk_ventas_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `db_muebleria`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `db_muebleria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`ventas_productos` (
  `ventas_idventas` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`ventas_idventas`, `productos_idproductos`),
  CONSTRAINT `fk_ventas_productos_ventas`
    FOREIGN KEY (`ventas_idventas`)
    REFERENCES `db_muebleria`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_productos_productos`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `db_muebleria`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `db_muebleria`.`ventas_detalle` (
  `idventas_detalle` INT NOT NULL,
  `total_pagar` VARCHAR(45) NOT NULL,
  `paga_con` VARCHAR(45) NOT NULL,
  `cambio` VARCHAR(45) NOT NULL,
  `ventas_idventas` INT NOT NULL,
  PRIMARY KEY (`idventas_detalle`),
  INDEX `fk_ventas_detalle_ventas1_idx` (`ventas_idventas` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_detalle_ventas1`
    FOREIGN KEY (`ventas_idventas`)
    REFERENCES `db_muebleria`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_muebleria`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `contraseñas` VARCHAR(45) NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `db_muebleria`.`usuarios` (`idusuarios`, `nombre`, `contraseñas`) VALUES (1, 'hades', '0413');

INSERT INTO `db_muebleria`.`categorias` (`idcategorias`, `sofa`, `armario`, `mesa`, `escritorio`, `silla`) 
VALUES (1, 'Sofá', 'Armario', 'Mesa', 'Escritorio', 'Silla');
INSERT INTO `db_muebleria`.`categorias` (`idcategorias`, `sofa`, `armario`, `mesa`, `escritorio`, `silla`) 
VALUES (2, 'Sofá cama', 'Gabinete', 'Mesa de centro', 'Biblioteca', 'Silla de oficina');

INSERT INTO `db_muebleria`.`proveedor` (`idproveedor`, `nombre`, `telefonos`, `correo`, `Fax`) 
VALUES (1, 'Vinicius JR', '123456789', 'rasho@hotmail.com', 'FAX-123');
INSERT INTO `db_muebleria`.`proveedor` (`idproveedor`, `nombre`, `telefonos`, `correo`, `Fax`) 
VALUES (2, 'Alex Valera', '987654321', 'tengosalud@hotmail.com', 'FAX-987');

INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (1, 'Sofá de cuero', '600', 1, 1);
INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (2, 'Armario de roble', '800', 1, 2);
INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (3, 'Mesa de comedor', '200', 1, 1);
INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (4, 'Escritorio de madera', '300', 2, 2);
INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (5, 'Silla de oficina', '200', 2, 2);
INSERT INTO `db_muebleria`.`productos` (`idproductos`, `nombre_prod`, `precio`, `categorias_idcategorias`, `proveedor_idproveedor`) 
VALUES (6, 'Sofá', '500', 1, 1);

INSERT INTO `db_muebleria`.`clientes` (`idclientes`, `nombre_cli`, `telefono`, `direccion`, `correo`) 
VALUES (1, 'Vladimir Cerron', '111111111', 'Sol Naciente', 'vladi@hotmail.com');
INSERT INTO `db_muebleria`.`clientes` (`idclientes`, `nombre_cli`, `telefono`, `direccion`, `correo`) 
VALUES (2, 'Cristiano Messi', '222222222', 'San Juan De Lurigancho', 'siuuu@hotmail.com');

INSERT INTO `db_muebleria`.`ventas` (`idventas`, `total_pago`, `fecha`, `clientes_idclientes`, `productos_idproductos`)
VALUES (1, '1500', '2023-05-30', 1, 1);
INSERT INTO `db_muebleria`.`ventas` (`idventas`, `total_pago`, `fecha`, `clientes_idclientes`, `productos_idproductos`) 
VALUES (2, '1000', '2023-05-31', 2,1);


INSERT INTO `db_muebleria`.`ventas_productos` (`ventas_idventas`, `productos_idproductos`, `cantidad`)
VALUES (1, 1, 2);
INSERT INTO `db_muebleria`.`ventas_productos` (`ventas_idventas`, `productos_idproductos`, `cantidad`) 
VALUES (1, 3, 1);
INSERT INTO `db_muebleria`.`ventas_productos` (`ventas_idventas`, `productos_idproductos`, `cantidad`) 
VALUES (2, 2, 1);
INSERT INTO `db_muebleria`.`ventas_productos` (`ventas_idventas`, `productos_idproductos`, `cantidad`) 
VALUES (2, 5, 4);





