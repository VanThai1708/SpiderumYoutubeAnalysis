-- PROCEDURE: public.etl_add_comment_level()

-- DROP PROCEDURE IF EXISTS public.etl_add_comment_level();

CREATE OR REPLACE PROCEDURE public.etl_add_comment_level(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE test
	SET id_comment_level = 
		CASE
			WHEN commnent_count <= 2000 THEN 1
			WHEN commnent_count > 2000 AND commnent_count <= 5000 THEN 2
			WHEN commnent_count > 5000 AND commnent_count <= 10000 THEN 3
			ELSE 4
		END;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_comment_level()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_duration_level()

-- DROP PROCEDURE IF EXISTS public.etl_add_duration_level();

CREATE OR REPLACE PROCEDURE public.etl_add_duration_level(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
UPDATE test
SET id_duration = 
	CASE
		WHEN duration_seconds <= 60 THEN 1
		WHEN duration_seconds > 60 AND duration_seconds <= 600 THEN 2
		WHEN duration_seconds > 600 AND duration_seconds <= 900 THEN 3
		WHEN duration_seconds > 900 AND duration_seconds <= 1200 THEN 4
		ELSE 5
	END;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_duration_level()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_id_author()

-- DROP PROCEDURE IF EXISTS public.etl_add_id_author();

CREATE OR REPLACE PROCEDURE public.etl_add_id_author(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE TABLE dim_author RESTART IDENTITY CASCADE;
	INSERT INTO dim_author (author)
		SELECT DISTINCT author
		FROM test;
	UPDATE dim_author
	SET author_type = 
		CASE
			WHEN author = 'spiderum' THEN 'spiderum'
			ELSE 'contributors'
		END;

	UPDATE test
		SET id_author = dim_author.id
		FROM dim_author
		WHERE test.author = dim_author.author;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_id_author()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_id_topic()

-- DROP PROCEDURE IF EXISTS public.etl_add_id_topic();

CREATE OR REPLACE PROCEDURE public.etl_add_id_topic(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	update test
	set playlist_title = 'khác'
	where playlist_title not in ('khoa học','thế giới','quan điểm','short','giáo dục','tiền tài','khác','tâm sự','yêu');
	
	TRUNCATE TABLE dim_topic RESTART IDENTITY CASCADE;

	INSERT INTO dim_topic (topic)
		SELECT DISTINCT playlist_title
		FROM test;

	UPDATE test
		SET id_topic = dim_topic.id
		FROM dim_topic
		WHERE test.playlist_title = dim_topic.topic;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_id_topic()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_id_topic()

-- DROP PROCEDURE IF EXISTS public.etl_add_id_topic();

CREATE OR REPLACE PROCEDURE public.etl_add_id_topic(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	update test
	set playlist_title = 'khác'
	where playlist_title not in ('khoa học','thế giới','quan điểm','short','giáo dục','tiền tài','khác','tâm sự','yêu');
	
	TRUNCATE TABLE dim_topic RESTART IDENTITY CASCADE;

	INSERT INTO dim_topic (topic)
		SELECT DISTINCT playlist_title
		FROM test;

	UPDATE test
		SET id_topic = dim_topic.id
		FROM dim_topic
		WHERE test.playlist_title = dim_topic.topic;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_id_topic()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_like_level()

-- DROP PROCEDURE IF EXISTS public.etl_add_like_level();

CREATE OR REPLACE PROCEDURE public.etl_add_like_level(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE test
	SET id_like_level = 
		CASE
			WHEN like_count <= 2000 THEN 1
			WHEN like_count > 2000 AND like_count <= 5000 THEN 2
			WHEN like_count > 5000 AND like_count <= 10000 THEN 3
			ELSE 4
		END;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_like_level()
    OWNER TO postgres;

-- PROCEDURE: public.etl_add_view_level()

-- DROP PROCEDURE IF EXISTS public.etl_add_view_level();

CREATE OR REPLACE PROCEDURE public.etl_add_view_level(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
UPDATE test
SET id_view_level = 
	CASE
		WHEN view_count < 50000 THEN 1
		WHEN view_count >= 50000 AND view_count < 100000 THEN 2
		WHEN view_count >= 100000 AND view_count < 200000 THEN 3
		WHEN view_count >= 20000 AND view_count < 500000 THEN 4
		ELSE 5
	END;
END;
$BODY$;
ALTER PROCEDURE public.etl_add_view_level()
    OWNER TO postgres;

-- PROCEDURE: public.etl_duration()

-- DROP PROCEDURE IF EXISTS public.etl_duration();

CREATE OR REPLACE PROCEDURE public.etl_duration(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE test
	SET duration_seconds = 
		CASE
			WHEN duration ~ '^PT[0-9]+M' THEN	(CAST(substring(duration FROM 'PT(\d+)M') AS INTEGER) * 60) +
				(CAST(substring(duration FROM 'M(\d+)S') AS INTEGER))
			WHEN duration ~ '^PT[0-9]+S$' THEN	CAST(substring(duration FROM 'PT(\d+)S') AS INTEGER)
			ELSE 0
		END;

	UPDATE test
	SET duration_seconds = (CAST(substring(duration FROM 'PT(\d+)M') AS INTEGER) * 60)
	where duration ~ 'PT[0-9]+M$';
END;
$BODY$;
ALTER PROCEDURE public.etl_duration()
    OWNER TO postgres;

-- PROCEDURE: public.etl_topic_author()

-- DROP PROCEDURE IF EXISTS public.etl_topic_author();

CREATE OR REPLACE PROCEDURE public.etl_topic_author(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE test
	SET title_lower = lower(title);
	
	-- TACH COLUMN TITLE LOWER RA THANH MANG
	UPDATE test
	SET split_array = string_to_array(title_lower, '|');
	
	-- CAP NHAT GIA TRI CHO COLUMN PLAYLIST TITLE
	UPDATE test
	SET playlist_title = trim(split_array[3]);

	UPDATE test
	SET playlist_title = 'khác'
	where playlist_title = 'spiderum';

	UPDATE test
	SET playlist_title = trim(split_array[2])
	WHERE trim(split_array[2]) IN (select distinct playlist_title 
								  from test 
								  WHERE playlist_title IS NOT NULL);

	UPDATE test
	SET playlist_title = 'short'
	WHERE title ~ '#';	

	UPDATE test
	SET playlist_title = 'khác'
	WHERE playlist_title is null;
	
	-- CAP NHAT GIA TRI CHO COT AUTHOR
	UPDATE test
	SET author = trim(split_array[2]);

	UPDATE test
	SET author = 'spiderum'
	where author in (SELECT DISTINCT playlist_title FROM test WHERE playlist_title IS NOT NULL);

	-- AP DUNG CHO ARRAY CO 1 PHAN TU
	UPDATE test
	SET author = 'spiderum'
	WHERE author IS NULL;

	UPDATE test
	SET author = 'spiderum'
	WHERE length(author) > 22;
END;
$BODY$;
ALTER PROCEDURE public.etl_topic_author()
    OWNER TO postgres;

-- PROCEDURE: public.main_procedure()

-- DROP PROCEDURE IF EXISTS public.main_procedure();

CREATE OR REPLACE PROCEDURE public.main_procedure(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Gọi procedure1
    CALL etl_topic_author();

    -- Gọi procedure2
    CALL etl_duration();

    -- Gọi procedure3
    CALL etl_add_comment_level();
    CALL etl_add_duration_level();
    CALL etl_add_like_level();
    CALL etl_add_view_level();
    CALL etl_add_id_topic();
    CALL etl_add_id_author();
END;
$BODY$;
ALTER PROCEDURE public.main_procedure()
    OWNER TO postgres;

-- PROCEDURE: public.test_to_fact()

-- DROP PROCEDURE IF EXISTS public.test_to_fact();

CREATE OR REPLACE PROCEDURE public.test_to_fact(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
TRUNCATE fact_spiderum_youtube;
INSERT INTO fact_spiderum_youtube (id, id_view_level,id_like_level, id_comment_level,
								id_author, id_topic, id_duration,create_at,title,view_count, like_count, comment_count 
							  	) 
							   select id, id_view_level,id_like_level, id_comment_level,
								id_author, id_topic, id_duration,published_at,title, view_count, like_count, commnent_count 
							   from test;
-- 							   WHERE date_extract = CURRENT_DATE;
END;
$BODY$;
ALTER PROCEDURE public.test_to_fact()
    OWNER TO postgres;
