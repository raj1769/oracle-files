rem Load Author Flat File Records into Staging Table,validate those and put them in Author Master Table
HOST sqlldr Userid=apps/apps Control='&1'.ctl Data='&2'.txt Log='&3'.log

DECLARE
TYPE xxpatni_authors_t IS TABLE OF xxpatni_authors_stage_srp%ROWTYPE INDEX BY pls_integer;
xxpatni_authors xxpatni_authors_t;
v_gender CHAR(1):='F';
v_author_s CHAR(1);
v_user_id NUMBER:=fnd_global.user_id;
v_date DATE:=current_date;
v_login_id NUMBER:=fnd_global.login_id;
BEGIN

FND_FILE.PUT_LINE(FND_FILE.OUTPUT,'1.Loaded into Staging Table');

SELECT * BULK COLLECT
INTO xxpatni_authors
FROM xxpatni_authors_stage_srp;

FND_FILE.PUT_LINE(FND_FILE.OUTPUT,'2.Loaded Author Records into PL/SQL Table');

FOR i IN xxpatni_authors.FIRST..xxpatni_authors.LAST
LOOP

-- Return the Gender --
v_gender:=xxpatni_authors_pkg_srp.xxpatni_gender_value(xxpatni_authors(i).author_id);


-- Return the Status of Valid/Invalid Author ID --
v_author_s:=xxpatni_authors_pkg_srp.xxpatni_validate_author_id(xxpatni_authors(i).author_id);


IF v_author_s = 'P' THEN

xxpatni_authors_pkg_srp.xxpatni_insert_authors
(p_author_id		=> xxpatni_authors(i).author_id,
 p_author_name 		=> xxpatni_authors(i).author_name,
 p_gender 		=> v_gender,
 p_birth_date 		=> xxpatni_authors(i).birth_date,
 p_mother_tongue 	=> xxpatni_authors(i).mother_tongue,
 p_created_by		=> v_user_id,
 p_creation_date	=> v_date,
 p_last_updated_by	=> v_user_id,
 p_last_update_date	=> v_date,
 p_last_update_login	=> v_login_id);

ELSIF v_author_s = 'E' THEN

xxpatni_authors_pkg_srp.xxpatni_error_report(xxpatni_authors(i).author_id);

END IF;

END LOOP;

END;
/
