DROP PROCEDURE IF EXISTS MYDB.SP_MAKE_PAYMENT_BY_CUSTOMER;

DELIMITER $$
CREATE PROCEDURE MYDB.SP_MAKE_PAYMENT_BY_CUSTOMER (IN PLACED_ORDER_ID INT, IN CUSTOMER_ACCOUNT_NO VARCHAR(45), IN AMOUNT_TO_BE_PAID DOUBLE, IN PAYMENT_TYPE INT)
BEGIN
	DECLARE CODE CHAR(5) DEFAULT '00000';
    DECLARE MSG TEXT;
    DECLARE RESULT TEXT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN 
		GET DIAGNOSTICS CONDITION 1
			CODE = RETURNED_SQLSTATE, MSG = MESSAGE_TEXT;
		END;
        IF CUSTOMER_ACCOUNT_NO IS NOT NULL AND PAYMENT_TYPE IN(1,2)  THEN
			IF  CUSTOMER_ACCOUNT_NO IN (SELECT DISTINCT(ACCOUNT_NUMBER) FROM ACCOUNTS WHERE CUSTOMER_ID IN 
			(SELECT CUSTOMER_ID FROM ORDERS WHERE ORDER_ID = PLACED_ORDER_ID)) THEN
				IF PAYMENT_TYPE IN (SELECT TRANSACTION_ID FROM MYDB.TRANSACTIONTYPE) THEN				
					## INSERT VALUES IN PAYMENT TABLE
					INSERT INTO MYDB.PAYMENTS (PAYMENT_DATE,STATUS_ID,ORDER_ID,ACCOUNT_NUMBER,PAYMENT_AMOUNT)
					VALUES (NOW(),10,PLACED_ORDER_ID, CUSTOMER_ACCOUNT_NO,AMOUNT_TO_BE_PAID);
					
					## INSERT VALUES IN FINANCIAL_TRANSACTION TABLE
					INSERT INTO MYDB.FINANCIAL_TRANSACTION (TRANSACTION_ID, PAYMENT_ID) 
					VALUES (PAYMENT_TYPE, LAST_INSERT_ID());              
					
					IF CODE ='00000' THEN 
						SET RESULT = 'PAYMENT SUCCESSFULL';
					ELSE	
						SET RESULT = CONCAT('PAYMENT UNSUCCESSFUL, MESSAGE = ',MSG);
					END IF;
				ELSE
					SET RESULT = 'INVALID TRANSACTION TYPE';
				END IF;
			ELSE
				SET RESULT = 'INVALID CUSTOMER ACCOUNT';
			END IF;
		ELSE
				SET RESULT = 'INVALID PAYMENT TYPE';
		END IF;
				
    SELECT RESULT;
END $$
DELIMITER ;
