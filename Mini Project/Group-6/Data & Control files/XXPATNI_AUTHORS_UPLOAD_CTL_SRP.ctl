LOAD DATA
INFILE  '/dbfiles/applcsf/cust/bin/XXPATNI_AUTHORS_DATA_SRP.dat'
REPLACE INTO TABLE xxpatni_authors_stage_srp
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(author_id,
author_name,
gender,
birth_date "TO_DATE(:birth_date,'DD/MM/YYYY')",
mother_tongue)





