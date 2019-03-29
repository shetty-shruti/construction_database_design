DROP FUNCTION IF EXISTS MYDB.FN_GET_TOTAL_PROFIT;

DELIMITER $$
CREATE FUNCTION MYDB.FN_GET_TOTAL_PROFIT (a int) RETURNS DOUBLE
	DETERMINISTIC
BEGIN
	DECLARE V_TOTAL_COST_PRICE DOUBLE;
    DECLARE V_TOTAL_SELLING_PRICE DOUBLE;
    DECLARE V_TOTAL_EQUIPMENT_ORDERS_PRICE DOUBLE;
    DECLARE V_TOTAL_PROFIT DOUBLE;
    
    SELECT SUM(FLAT_COST_PRICE) INTO V_TOTAL_COST_PRICE FROM MYDB.FLATS;
    
    SELECT SUM(FLAT_SELLING_PRICE) INTO V_TOTAL_SELLING_PRICE FROM MYDB.FLATS
    WHERE FLATS.FLAT_BOOKED_STATUS = 'Y';
    
    SELECT SUM(TOTAL_PRICE) INTO V_TOTAL_EQUIPMENT_ORDERS_PRICE FROM MYDB.VW_GET_EQUIPMENT_ORDER_DETAILS;
    
    SET V_TOTAL_PROFIT = V_TOTAL_SELLING_PRICE - (V_TOTAL_COST_PRICE + V_TOTAL_EQUIPMENT_ORDERS_PRICE);
    
    RETURN V_TOTAL_PROFIT;
END $$
DELIMITER ;