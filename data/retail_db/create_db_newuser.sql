CREATE DATABASE itversity_retail_db;

CREATE USER itversity_retail_usernew WITH ENCRYPTED PASSWORD 'itversity';

GRANT ALL ON DATABASE itversity_retail_db To itversity_retail_usernew;

ALTER DATABASE itversity_retail_db OWNER TO itversity_retail_usernew;