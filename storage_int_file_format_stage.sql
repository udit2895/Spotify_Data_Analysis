CREATE OR REPLACE STORAGE INTEGRATION S3_INT
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::858745858084:role/SNOWFLAKE_S3_CONNECTION'
    STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-etl-data-engineering/transformed_data/album_data/','s3://spotify-etl-data-engineering/transformed_data/artist_data/','s3://spotify-etl-data-engineering/transformed_data/songs_data/')
    COMMENT = 'Creating connection to S3';


DESC INTEGRATION S3_INT;

CREATE OR REPLACE FILE FORMAT CSV_FILEFORMAT
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL','null')
    error_on_column_count_mismatch=false
    EMPTY_FIELD_AS_NULL = TRUE
    ;

CREATE OR REPLACE STAGE CSV_FOLDER_ALB
    URL = 's3://spotify-etl-data-engineering/transformed_data/album_data/'
    STORAGE_INTEGRATION = S3_INT
    FILE_FORMAT = CSV_FILEFORMAT;

CREATE OR REPLACE STAGE CSV_FOLDER_ART
    URL = 's3://spotify-etl-data-engineering/transformed_data/artist_data/'
    STORAGE_INTEGRATION = S3_INT
    FILE_FORMAT = CSV_FILEFORMAT;

CREATE OR REPLACE STAGE CSV_FOLDER_SONGS
    URL = 's3://spotify-etl-data-engineering/transformed_data/songs_data/'
    STORAGE_INTEGRATION = S3_INT
    FILE_FORMAT = CSV_FILEFORMAT;

LIST @CSV_FOLDER_ART;