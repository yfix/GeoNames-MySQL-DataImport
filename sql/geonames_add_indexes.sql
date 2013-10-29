/* Example: CALL CREATE_INDEX_IF_NOT_EXISTS('tablename','indexname','thisfield,thatfield'); */
DELIMITER $$
DROP PROCEDURE IF EXISTS `create_index_if_not_exists`$$
CREATE DEFINER=`user`@`%` PROCEDURE `create_index_if_not_exists` (table_name_vc varchar(50), index_name_vc varchar(50), field_list_vc varchar(200))
SQL SECURITY INVOKER
BEGIN
	SET @Index_cnt = (SELECT COUNT(1) cnt FROM INFORMATION_SCHEMA.STATISTICS WHERE table_name = table_name_vc AND index_name = index_name_vc);
	IF ifnull(@Index_cnt,0) = 0 THEN 
		SET @index_sql = CONCAT('ALTER TABLE ',table_name_vc,' ADD INDEX ',index_name_vc,'(',field_list_vc,');');
		PREPARE stmt FROM @index_sql;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;
END$$
DELIMITER ;

CALL CREATE_INDEX_IF_NOT_EXISTS('geo_geoname', 'feature_class', 'feature_class');
CALL CREATE_INDEX_IF_NOT_EXISTS('geo_geoname', 'feature_code', 'feature_code');
CALL CREATE_INDEX_IF_NOT_EXISTS('geo_geoname', 'country', 'country');
CALL CREATE_INDEX_IF_NOT_EXISTS('geo_geoname', 'admin1', 'admin1');
