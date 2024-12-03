Create Database itversity_sms_db;

CREATE USER itversity_sms_usernew WITH ENCRYPTED PASSWORD 'itversity';

GRANT ALL ON DATABASE itversity_sms_db To itversity_sms_usernew;

ALTER DATABASE itversity_sms_db OWNER TO itversity_sms_usernew;


