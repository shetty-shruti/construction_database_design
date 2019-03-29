DROP TRIGGER IF EXISTS MYDB.TR_AFTER_ORDERS_INSERT;

DELIMITER $$
CREATE TRIGGER MYDB.TR_AFTER_ORDERS_INSERT
	AFTER INSERT ON MYDB.ORDERS
    FOR EACH ROW		
BEGIN
	UPDATE MYDB.FLATS SET ORDER_ID = NEW.ORDER_ID, FLAT_BOOKED_STATUS='Y' WHERE FLAT_ID = NEW.FLAT_ID; 
END $$
DELIMITER ;