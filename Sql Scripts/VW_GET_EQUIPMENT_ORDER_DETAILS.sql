 CREATE VIEW MYDB.VW_GET_EQUIPMENT_ORDER_DETAILS AS 
 SELECT EQUIPMENT_ORDERS.EQUIPMENT_ORDERS_ID, EQUIPMENT_ORDERS.EMPLOYEE_ID,
 MANUFACTURER.MANUFACTURER_NAME, EQUIPMENTS.EQUIPMENT_NAME,
 EQUIPMENT_ORDERS.QUANTITY,EQUIPMENTS.PRICE AS 'INDIVIDUAL PRICE', 
 (EQUIPMENT_ORDERS.QUANTITY * EQUIPMENTS.PRICE) AS 'TOTAL_PRICE'
 FROM EQUIPMENT_ORDERS INNER JOIN EQUIPMENTS_HAS_MANUFACTURER
 ON EQUIPMENTS_HAS_MANUFACTURER.ID = EQUIPMENT_ORDERS.EQUIPMENT_HAS_MANUFACTURER_ID
 INNER JOIN MANUFACTURER
 ON MANUFACTURER.MANUFACTURER_ID = EQUIPMENTS_HAS_MANUFACTURER.MANUFACTURER_ID
 INNER JOIN EQUIPMENTS
 ON EQUIPMENTS.EQUIPMENT_ID = EQUIPMENTS_HAS_MANUFACTURER.EQUIPMENT_ID
 WITH CHECK OPTION;
 
 #DROP VIEW MYDB.VW_GET_EQUIPMENT_ORDER_DETAILS
 
 

 