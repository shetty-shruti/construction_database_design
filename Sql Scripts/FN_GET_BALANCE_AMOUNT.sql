DROP FUNCTION IF EXISTS MYDB.FN_GET_BALANCE_AMOUNT;

DELIMITER $$
CREATE FUNCTION MYDB.FN_GET_BALANCE_AMOUNT (V_CUST_ID BIGINT(30),  V_FLAT_ID INT) RETURNS DOUBLE
	DETERMINISTIC
BEGIN
	DECLARE V_BALANCE_AMOUNT DOUBLE;
    DECLARE V_TOTAL_AMOUNT DOUBLE;
    DECLARE V_SELLING_PRICE DOUBLE;
    
    SELECT SUM(PAYMENT_AMOUNT) INTO V_TOTAL_AMOUNT FROM MYDB.VW_CUSTOMER_FLAT_PAYMENT_DETAILS_FOR_ADMIN
    WHERE FLAT_BOOKED = V_FLAT_ID AND ID = V_CUST_ID;
    
    SELECT FLAT_SELLING_PRICE INTO V_SELLING_PRICE FROM MYDB.FLATS
    WHERE FLATS.FLAT_ID = V_FLAT_ID;
    
    SET V_BALANCE_AMOUNT = V_SELLING_PRICE - V_TOTAL_AMOUNT;
    
    RETURN (V_BALANCE_AMOUNT);
END $$
DELIMITER ;