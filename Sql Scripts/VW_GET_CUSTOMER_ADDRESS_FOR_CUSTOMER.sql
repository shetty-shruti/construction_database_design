CREATE VIEW MYDB.VW_GET_CUSTOMER_ADDRESS_FOR_CUSTOMER AS
SELECT CUSTOMER.ID,CUSTOMER.FIRST_NAME,CUSTOMER.LAST_NAME,FLATS.FLAT_NO, FLATS.FLOOR_NO, ADDRESS.BUILDING_ID,
BUILDINGS.BUILDING_NAME,BUILDINGS.STREET, BUILDINGS.CITY,BUILDINGS.STATE
FROM MYDB.ADDRESS INNER JOIN MYDB.FLATS
ON ( ADDRESS.BUILDING_ID = FLATS.BUILDING_ID AND  ADDRESS.FLAT_NO = FLATS.FLAT_NO)
INNER JOIN MYDB.ORDERS
INNER JOIN MYDB.CUSTOMER
ON ORDERS.CUSTOMER_ID = CUSTOMER.ID
INNER JOIN BUILDINGS
ON BUILDINGS.BUILDING_ID = ADDRESS.BUILDING_ID
WHERE CUSTOMER.FIRST_NAME = SUBSTRING_INDEX(USER(), '@', 1)
WITH CHECK OPTION;

#DROP VIEW VW_GET_CUSTOMER_ADDRESS_FOR_CUSTOMER;