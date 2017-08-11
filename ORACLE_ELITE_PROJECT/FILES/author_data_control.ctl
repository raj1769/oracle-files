load data
infile '\dbfiles\applcsf\cust\bin\authordetails.txt'
insert into table AUTHORMASTERS fields terminated by "|"
(author_id, author_name, gender "nvl(:gender, 'F')", birth_date date 'DD/MM/YYYY', mother_tongue)
