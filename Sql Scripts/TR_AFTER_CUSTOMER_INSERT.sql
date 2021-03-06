DROP TRIGGER IF EXISTS MYDB.TR_AFTER_CUSTOMER_INSERT;

DELIMITER $$
	CREATE TRIGGER MYDB.TR_AFTER_CUSTOMER_INSERT
	AFTER INSERT ON MYDB.CUSTOMER
    FOR EACH ROW
    BEGIN
   INSERT INTO MYSQL.USER (HOST, USER, AUTHENTICATION_STRING)
	VALUES ('%',New.FIRST_NAME,PASSWORD(New.FIRST_NAME)); 
    END $$    
DELIMITER ;