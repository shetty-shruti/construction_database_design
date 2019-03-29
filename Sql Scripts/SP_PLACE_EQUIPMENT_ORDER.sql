DROP PROCEDURE IF EXISTS MYDB.SP_PLACE_EQUIPMENT_ORDER;

DELIMITER $$
	CREATE PROCEDURE MYDB.SP_PLACE_EQUIPMENT_ORDER (IN EMP_ID INT, IN QTY INT, IN EQUIP_MANFAC_ID INT)
    BEGIN
		DECLARE V_TOTAL_QTY INT;
        DECLARE V_AVAIL_QTY INT;
        DECLARE V_EQUIP_ID INT;
        
        SELECT EQUIPMENT_ID INTO V_EQUIP_ID FROM MYDB.EQUIPMENTS_HAS_MANUFACTURER 
        WHERE ID = EQUIP_MANFAC_ID;
        
        SELECT QUANTITY INTO V_TOTAL_QTY FROM MYDB.EQUIPMENTS WHERE EQUIPMENT_ID = V_EQUIP_ID;       
        
        IF V_TOTAL_QTY > QTY THEN
        
        SET V_AVAIL_QTY = V_TOTAL_QTY - QTY;
        
		INSERT INTO MYDB.EQUIPMENT_ORDERS (EMPLOYEE_ID, QUANTITY,EQUIPMENT_HAS_MANUFACTURER_ID)
        VALUES (EMP_ID, QTY, EQUIP_MANFAC_ID);
        
        UPDATE MYDB.EQUIPMENTS SET QUANTITY = V_AVAIL_QTY WHERE EQUIPMENT_ID = V_EQUIP_ID;
        
        SELECT 'EQUIPMENT ORDER PLACED SUCCESSFULLY' AS MSG;
        ELSE
			SELECT 'QUANTITY UNAVAILABLE' AS MSG;
		END IF;
    END $$
DELIMITER ;