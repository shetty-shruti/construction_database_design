DROP TRIGGER MYDB.TR_BEFORE_BUILDS_INSERT;

DELIMITER $$
CREATE TRIGGER MYDB.TR_BEFORE_BUILDS_UPDATE
BEFORE UPDATE ON BUILDS
FOR EACH ROW
	BEGIN
    DECLARE MSG VARCHAR(100);
    DECLARE V_CONSTRUCTION_STATUS VARCHAR(45);
		IF NEW.BUILDING_ID  NOT IN (SELECT DISTINCT (BUILDING_ID) FROM BUILDINGS) THEN
			SET MSG = 'INVALID BUILDING ID';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
			IF NEW.EMPLOYEE_ID NOT IN (SELECT DISTINCT(EMPLOYEE_ID) FROM EMPLOYEES) THEN
				SET MSG = 'INVALID EMPLOYEE ID';
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG;
				IF NEW.FLOORS_COMPLETED > (SELECT NO_OF_FLOORS FROM BUILDINGS WHERE BUILDING_ID = NEW.BUILDING_ID) THEN
					SET MSG = 'INVALID FLOOR NO';
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG; 
                    #SELECT CONSTRUCTION_STATUS INTO V_CONSTRUCTION_STATUS FROM MYDB.BUILDS WHERE BUILDING_ID 
                    #IN (SELECT BUILDING_ID FROM MYDB.BUILDS WHERE BUILDS);
				END IF;
                END IF;
		END IF;        
    END $$
DELIMITER ;
