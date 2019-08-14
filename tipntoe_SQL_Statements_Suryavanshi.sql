/*
Megha Suryavanshi
823443511
CS648
Final Project 5 Sql Statements
Spring 2019
*/

use tipntoe;

SET FOREIGN_KEY_CHECKS=0; 
SET GLOBAL sql_mode='';
SET @@global.sql_mode= 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

--  SQL Query 1 - SQL Query using aggregate function to check the number of times the customers has booked appointment with thier customer id

SELECT 
	customer_name,
	COUNT(`customer_id`) as 'Number of visit'

FROM 
	`appointments` 

WHERE 
	`customer_id` = 1 
    ;


/* SQL Query 2. Display query using a function "get_full_name" which will display customer first name and last name together from customer table. 
		The code for fuction "get_full_name" is -
        -- A function to Display first name and last name together
        
			DROP FUNCTION IF EXISTS get_full_names;
			DELIMITER //
			CREATE FUNCTION get_full_names
				( 
					EmployeeId int
				)
			RETURNS VARCHAR(255)

			BEGIN 
				
				DECLARE employee_var varchar(255);
                
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
			DELIMITER ;   */
            
	SELECT 
		employee_id, 
		employee_contact, 
		get_full_names(employee_id) as employee_name
		
	FROM 
		employees
        ;

-- SQL Query 3-  Insert Query which inserts a row in appointmnts table.
	-- This insert query is using the Stored Procedure "insert_appointments", The code for procedure is -
   /* DROP PROCEDURE IF EXISTS insert_appointment;

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
DELIMITER ; */

CALL insert_appointment(14, '2019-07-01 13:00:00', 1, 5, 7, 3, 'Sofia Sherwood', '858-321-0709', 20.00)
;


/*SQL Query 4.
	A UPDATE Query to change the appointment date and time if customer requests to reschedule appointmnet
		This UPDATE query is using a view "customer_appointments" and the code of View is -
        
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
        
	WHERE appointment_date_time >= '2019-06-01 16:00:00'
    ;*/
    
UPDATE 
	customer_appointments
    
SET	
	appointment_date_time = '2019-06-01 16:15:00'
    
WHERE 
	customer_name = 'Barry Zimmer'
    ;


-- SQL Query 5-  
	-- Delete Query which will delete a row from appointments table

DELETE 

FROM 
	appointments
    
WHERE 
	appointment_id = 13
    ;



