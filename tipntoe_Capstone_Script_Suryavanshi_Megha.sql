-- MySQL Script generated by MySQL Workbench
-- Sat May 11 01:36:51 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET FOREIGN_KEY_CHECKS=0; 
SET GLOBAL sql_mode='';
SET @@global.sql_mode= 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
set global log_bin_trust_function_creators = 1;
-- -----------------------------------------------------
-- Schema tipntoe
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tipntoe` ;

-- -----------------------------------------------------
-- Schema tipntoe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tipntoe` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `tipntoe` ;

-- -----------------------------------------------------
-- Table `services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `services` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `services` (
  `service_id` INT NOT NULL AUTO_INCREMENT,
  `service_name` VARCHAR(255) NOT NULL,
  `service_duration` TIME NOT NULL,
  `service_cost` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`service_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `service_id_UNIQUE` ON `services` (`service_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `discounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discounts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `discounts` (
  `discount_id` INT NOT NULL AUTO_INCREMENT,
  `discount_percent` DECIMAL(10,2) NULL DEFAULT 0.00,
  `discount_code` VARCHAR(60) NULL,
  PRIMARY KEY (`discount_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `discount_id_UNIQUE` ON `discounts` (`discount_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appointments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `appointment_date_time` DATETIME NOT NULL,
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `discount_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  `customer_name` VARCHAR(30) NOT NULL,
  `customer_contact` VARCHAR(30) NULL,
  `service_cost` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `services_service_id` INT NOT NULL,
  `discounts_discount_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`, `services_service_id`, `discounts_discount_id`),
  CONSTRAINT `fk_appointments_services1`
    FOREIGN KEY (`services_service_id`)
    REFERENCES `services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointments_discounts1`
    FOREIGN KEY (`discounts_discount_id`)
    REFERENCES `discounts` (`discount_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `appointment_id_UNIQUE` ON `appointments` (`appointment_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_appointments_services1_idx` ON `appointments` (`services_service_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_appointments_discounts1_idx` ON `appointments` (`discounts_discount_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name_customer` VARCHAR(45) NOT NULL,
  `last_name_customer` VARCHAR(45) NOT NULL,
  `customer_mobile` VARCHAR(45) NULL,
  `customer_email` VARCHAR(255) NULL,
  `customer_password` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `customer_id_UNIQUE` ON `customers` (`customer_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employees` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name_employee` VARCHAR(45) NOT NULL,
  `last_name_employee` VARCHAR(45) NOT NULL,
  `employee_contact` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `employee_id_UNIQUE` ON `employees` (`employee_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `customers_has_appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customers_has_appointments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `customers_has_appointments` (
  `customers_customer_id` INT NOT NULL,
  `appointments_appointment_id` INT NOT NULL,
  `appointments_employees_employee_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`appointments_employees_employee_id`),
  CONSTRAINT `fk_customers_has_appointments_customers1`
    FOREIGN KEY (`customers_customer_id`)
    REFERENCES `customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_appointments_appointments1`
    FOREIGN KEY (`appointments_appointment_id`)
    REFERENCES `appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_customers_has_appointments_appointments1_idx` ON `customers_has_appointments` (`appointments_appointment_id` ASC, `appointments_employees_employee_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_customers_has_appointments_customers1_idx` ON `customers_has_appointments` (`customers_customer_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `appointments_employees_employee_id_UNIQUE` ON `customers_has_appointments` (`appointments_employees_employee_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `employees_has_appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employees_has_appointments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `employees_has_appointments` (
  `employees_employee_id` INT NOT NULL,
  `appointments_appointment_id` INT NOT NULL,
  `appointments_employees_employee_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`appointments_employees_employee_id`),
  CONSTRAINT `fk_employees_has_appointments_employees1`
    FOREIGN KEY (`employees_employee_id`)
    REFERENCES `employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_appointments_appointments1`
    FOREIGN KEY (`appointments_appointment_id`)
    REFERENCES `appointments` (`appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert data into the Service table
INSERT INTO services (service_id, service_name, service_duration, service_cost) VALUES
(1, 'ClassicSpa Manicure', '00:50:00', 12.00 ),
(2, 'Deluxe Spa Manicure', '01:00:00', 15.00),
(3, 'European Spa Manicure', '01:00:00', 17.00), 
(4, 'Royal Spa Manicure', '01:00:00', 20.00),
(5, 'French Polish','01:00:00', 25.00),
(6, 'ClassicSpa Pedicure', '00:50:00', 20.00),
(7, 'Deluxe Spa Pedicure', '01:00:00', 25.00),
(8, 'European Spa Pedicure','01:00:00', 35.00),
(9, 'Royal Pedicure', '01:15:00', 45.00),
(10, 'Sea salt treatment', '00:15:00', 5.00)
;

-- Check inserted data for service table
SELECT * FROM services;

-- Insert data into the Discount table
INSERT INTO discounts (discount_id, discount_percent, discount_code) VALUES
(1, '30.00', 'SAVE30'),
(2, '25.00', 'SAVE25'),
(3, '20.00', 'SAVE20'), 
(4, '10.00', 'SAVE10')
;

-- Check inserted data for Discount table
SELECT * FROM discounts;

-- Insert data into the Employee table
INSERT INTO employees (employee_id, first_name_employee, last_name_employee, employee_contact) VALUES
(1, 'Levi', 'Green','8585210982'),
(2, 'Ross', 'Bing','8585710982'),
(3, 'Monika', 'Geller','6515210982'), 
(4, 'Rachel', 'Green','8580210982'),
(5, 'Chandler', 'Bing','8585210002'),
(6, 'Joey', 'Joe','6515210982'), 
(7, 'Jenice', 'Lee', '8585310880'),
(8, 'Katie', 'Dante', '8585310880'),
(9, 'Mark', 'Davis', '8585310880'),
(10, 'Nick', 'Jonas', '8585310880')
;

-- Check inserted data for Employee table
SELECT * FROM employees;

-- Insert data into the Customers table
INSERT INTO customers (customer_id, first_name_customer, last_name_customer, customer_mobile, customer_email, customer_password) VALUES
(1, 'Sofia', 'Sherwood', '858-321-0709', 'sofia.sherwood@gmail.com', '650215acec746f0e32bdfff387439eefc1358737'),
(2, 'Barry', 'Zimmer', '858-421-0709', 'barryz@gmail.com', '3f563468d42a448cb1e56924529f6e7bbe529cc7'),
(3, 'Allan', 'Brown','858-521-0709', 'allan.brown@yahoo.com', '650215acec746f0e32bdfff387439eefc1358354'), 
(4, 'Gary', 'Hernandez','858-621-0709', 'garyh@gmail.com', '1ff2b3704aede04eecb51e50ca698efd50a1379b' ),
(5, 'Frank ', 'Lee','858-621-0709', 'frank.lee@gmail.com', '3ebfa301dc59196f18593c45e519287a23297589' ),
(6, 'Erin', 'Valentino','858-121-0709', 'erinv@gmail.com', '109f4b3c50d7b0df729d299bc6f8e9ef9066971f' ),
(7, 'David', 'Goldstein','858-221-0709', 'david.goldstein@hotmail.com', 'b444ac06613fc8d63795be9ad0beaf55011936ac' ),
(8, 'Logan', 'Embelton','858-821-0709', 'logane@gmail.com', '1ff2b3704aede04eecb51e50ca698efd50a1379z' ),
(9, 'Willow', 'Hope','858-921-0709', 'hope.w@gmail.com', '1ff2b3704aede04eecb51e50ca698efd50a1379e' ),
(10, 'Erika', 'Cruz','858-021-0709', 'erika.cruz@gmail.com', '911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23' )
;

-- Check inserted data for Customer table
SELECT * FROM customers;

-- Insert data into the Appointments table
SET SQL_MODE = '';
INSERT INTO appointments (appointment_id, appointment_date_time, customer_id, employee_id, service_id, discount_id, customer_name, customer_contact, service_cost )  VALUES
(1, '2019-06-01 10:15:00', 5, 2, 1, 4, 'Frank Lee', '858-621-0709', 12.00),
(2, '2019-06-01 11:00:00', 10, 7, 2, 4, 'Erika Cruz', '858-021-0709', 15.00),
(3, '2019-06-01 11:15:00', 3, 4, 3, 4, 'Allan Brown', '858-521-0709', 17.00), 
(4, '2019-06-01 12:15:00', 8, 1, 4, 4, 'Logan Embelton', '858-821-0709', 20.00),
(5, '2019-06-01 14:00:00', 7, 3, 5, 4, 'David Goldstein', '858-221-0709', 25.00),
(6, '2019-06-01 14:15:00', 6, 5, 6, 4, 'Erin Valentino', '858-121-0709', 20.00),
(7, '2019-06-01 16:00:00', 2, 6, 7, 4, 'Barry Zimmer', '858-421-0709', 25.00), 
(8, '2019-06-01 16:30:00', 1, 10, 8, 3, 'Sofia Sherwood', '858-321-0709', 35.00),
(9, '2019-06-01 17:00:00', 4, 8, 1, 4, 'Gary Hernandez', '858-621-0709', 20.00),
(10, '2019-07-01 10:30:00', 9, 1, 9, 1, 'Willow Hope', '858-921-0709', 45.00),
(11, '2019-07-01 11:15:00', 5, 3, 10, 4, 'Frank Lee', '858-621-0709', 5.00), 
(12, '2019-07-01 12:00:00', 1, 5, 5, 3, 'Sofia Sherwood', '858-321-0709', 25.00)
;

-- Check inserted data for Appointments table
SELECT * FROM appointments;

-- Insert data into the customers_has_appointments table
INSERT INTO customers_has_appointments(customers_customer_id, appointments_appointment_id) VALUES
(5,1),
(10,2),
(3,3), 
(8,4),
(7,5),
(6,6), 
(2,7),
(1,8),
(4,9), 
(9,10),
(5,11),
(1,12)
;

-- Check inserted data for customers_has_appointments table
SELECT * FROM customers_has_appointments;

-- Insert data into the employee_has_appointments table
INSERT INTO employees_has_appointments(employees_employee_id, appointments_appointment_id) VALUES
(2,1),
(7,2),
(4,3), 
(1,4),
(3,5),
(5,6), 
(6,7),
(10,8),
(8,9), 
(1,10),
(3,11),
(5,12)
;

-- Check inserted data for employee_has_appointments table
SELECT * FROM employees_has_appointments;


-- A view to create a virtual table to check the appointments after a particular time and date using customers and appointmnts table. For example to check how many appointments are booked between 14:00 - 18:00, or to check how many appointments are booked for particular date

CREATE OR REPLACE VIEW customer_appointments AS

	SELECT 
		customer_mobile, 
		customer_name, 
		employee_id, 
		service_id, 
		appointment_date_time, 
		service_cost
        
    FROM 
		customers JOIN appointments                                                                                                                                                                    
        
    ON 
		customers.customer_id = appointments.appointment_id
        
	WHERE 
		appointment_date_time >= '2019-05-10 10:00:00'
    ;
    
    -- A query using view "customer_appointments" to find after particular date and time How many customers has appointments and for which service and with which employee.
    
   /* SELECT 
		customer_name,
        employee_id,
        service_id,
        appointment_date_time
        
    FROM 
		customer_appointments
        
    WHERE
		appointment_date_time >= '2019-06-01 16:00:00'
        
    ORDER BY 
		customer_name; */
    
    
    -- A View to display the service_cost with their respective names using services table
    CREATE OR REPLACE VIEW service_cost_name AS

	SELECT 
        service_name,
        service_cost
        
	FROM 
		services
        
	ORDER BY 
		service_cost DESC;
        
-- A query using view "service_cost_name" to update the value of cost with the name of service.
   /* UPDATE 
		service_cost_name
    
	SET	
		service_cost = '28'
    
	WHERE 
		service_name = 'French Polish'
    ; */
    

-- A Function to Display first name and last name together from employees table
DROP FUNCTION IF EXISTS get_full_names;

DELIMITER //
CREATE FUNCTION get_full_names
	( 
		EmployeeId int
    )
RETURNS VARCHAR(255)

    BEGIN 
    
    DECLARE employee_var VARCHAR(255);
    
	SELECT 
		(CONCAT(first_name_employee,' ',last_name_employee))
    INTO
		employee_var
        
	FROM 
		employees
        
	WHERE 
		employee_id = EmployeeId;
        
   RETURN employee_var;
   END//
DELIMITER ;

-- A query using function"get_full_names" to display the employee Fname and Lname together
   /*SELECT 
		employee_id,
        employee_contact,
        get_full_names(employee_id) as employee_name
        
   FROM employees
   ; */
   
   -- A function to Display the level of services offered based on the price of the services using Service table.
DROP FUNCTION IF EXISTS ServiceLevel;

DELIMITER //
CREATE FUNCTION ServiceLevel 
	(
		service_cost DECIMAL(10,2)
	) 

RETURNS VARCHAR(255)
    
BEGIN
    DECLARE service_lvl_var VARCHAR(255);
 
    IF service_cost > 30 THEN
		SET service_lvl_var = 'PLATINUM';
    ELSEIF (service_cost <= 30 AND service_cost >= 12) THEN
        SET service_lvl_var = 'GOLD';
    ELSEIF service_cost <= 11 THEN
        SET service_lvl_var = 'SILVER';
    END IF;
 
RETURN (service_lvl_var);
END//
DELIMITER ;

-- A query using "ServiceLevel" Function to display the service names and thier respective levels
/*SELECT
    service_name,
    ServiceLevel(service_cost) as service_level
    
FROM
    services
    
ORDER BY
    service_name; */
    
-- A Stored Procedure which inserts a row in Appointment table
DROP PROCEDURE IF EXISTS insert_appointment;

DELIMITER //

CREATE PROCEDURE insert_appointment
 (
	AppointmentId int(11) ,
	AppointmentDateTime datetime,
	Customer_id int(11) ,
    Employee_id int(11),
    Service_id int(11),
    Discount_id int(11),
	CustomerName varchar(30),
	CustomerContact  varchar(30),
    ServiceCost decimal(10,2)
)

BEGIN
        
IF ServiceCost <= 0 THEN
	SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 
			'The ServiceCost can not be 0 or negative.',
         MYSQL_ERRNO = 1264;
END IF;
    
INSERT INTO appointments
		( appointment_id, appointment_date_time, customer_id, employee_id, discount_id, service_id, customer_name, customer_contact, service_cost)
        
VALUES  (AppointmentId, AppointmentDateTime, Customer_id, Employee_id, Service_id, Discount_id, CustomerName, CustomerContact, ServiceCost);

END//
DELIMITER ;

/* -- Call to insert data in the table appointmnts
CALL insert_appointment(13,'2019-07-01 11:30:00', 1, 5, 7, 3, 'Sofia Sherwood', '858-321-0709', 25.00) ;

-- call which put 0 value for service_cost and gives the Error
CALL insert_appointment(13,'2019-07-01 13:00:00', 1, 5, 7, 3, 'Sofia Sherwood', '858-321-0709', 0)
; */


-- A stored procedure which updates customer contact details in Customers table
DROP PROCEDURE IF EXISTS update_customer_contact;

DELIMITER //
CREATE PROCEDURE update_customer_contact
	( 	CustomerID INT,
		CustomerMobile VARCHAR(30)
        )

BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE ;
        
    UPDATE 
		customers
    
    SET 
		customer_mobile = CustomerMobile
    
    Where 
		customer_id = CustomerID;
    END//
    DELIMITER ;
    
--  call which update the cutomer mobile number where customer id is 5.
-- CALL update_customer_contact(5, 8585310019); 
		
SHOW WARNINGS;
CREATE INDEX `fk_employees_has_appointments_employees1_idx` ON `employees_has_appointments` (`employees_employee_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_employees_has_appointments_appointments1_idx` ON `employees_has_appointments` (`appointments_appointment_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `appointments_employees_employee_id_UNIQUE` ON `employees_has_appointments` (`appointments_employees_employee_id` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
