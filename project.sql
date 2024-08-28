CREATE TABLE Membership (
  MID Integer, 
  MBR_Costt Float not null unique,
  Mname Varchar(30) not null unique,
  MBR_Validity int not null unique,
  MBR_Description varchar2(255) not null unique,
  primary key(MID)
);

CREATE TABLE Package (
  PID Integer, 
  PKG_Costt Float not null unique,
  Pname Varchar(30) not null unique,
  PKG_Coins int not null unique,
  PKG_Description varchar2(255) not null unique,
  primary key(PID)
);

CREATE TABLE Notificationn 
(
stud_id integer not null,
tut_id integer not null,
msg varchar2(255) not null,
PRIMARY KEY (stud_id, tut_id),
FOREIGN KEY(stud_id) references student(stud_id),
foreign KEY(tut_id) references tutor(tut_id)
);

CREATE TABLE Student (
  Stud_ID Integer, 
  Sname varchar(20) not null, 
  Stude_phone varchar2(12) not null unique,
  Stud_email varchar2(30) not null unique,
  Stud_address varchar2(30) not null,
  Stud_DOB Date not null,
  Stud_gender char not null,
  Stud_username varchar2(15) not null unique,
  Stud_password varchar2(8) not null unique,
  Stud_CNIC varchar2(15) not null unique,
  primary key(Stud_ID)
);


CREATE TABLE Student (
  Stud_ID Integer, 
  Sname varchar(20) not null, 
  Stude_phone varchar2(12) not null unique,
  Stud_email varchar2(30) not null unique,
  Stud_address varchar2(30) not null,
  Stud_DOB Date not null,
  Stud_gender char not null,
  Stud_username varchar2(15) not null unique,
  Stud_password varchar2(8) not null unique,
  Stud_CNIC varchar2(15) not null unique,
  primary key(Stud_ID)
);

CREATE TABLE TUTOR(
  Tut_ID Integer, 
  Tname varchar(20) not null, 
  Tut_phone varchar2(12) not null unique,
  Tut_email varchar2(30) not null unique,
  Tut_MID Integer,
  Tut_gender char not null,
  Tut_DOB Date not null,
  Tut_username varchar2(15) not null unique,
  Tut_address varchar2(30) not null,
  Tut_password varchar2(8) not null unique,
  Tut_CNIC varchar2(15) not null unique,
  Tut_rating float Default 0, 
  Tut_coins float Default 0,
  Tut_Description varchar2(255) not null,
  Tut_rate float not null,
  Tut_experience Int not null,
  primary key(Tut_ID),
  Foreign Key (Tut_MID) REFERENCES Membership(MID)
);

CREATE TABLE REQUESTS(
  Req_ID Integer, 
  Stud_ID Integer,
  Req_Budget float not null,
  Req_subj varchar2(20) not null,
  Req_class integer not null,
  Req_board varchar2(20) not null,
  Req_pref_gender char not null,
  Req_pref_loc varchar2(50) not null,
  Req_mode_of_learning varchar2(20) not null,
  Req_experience Int not null,
  
  primary key(Req_ID),
  Foreign Key (Stud_ID) REFERENCES Student(Stud_ID)
);

CREATE TABLE TuTOR_INFO(
  Tut_ID Integer not null,
  Tut_pref_subj varchar2(20) not null,
  Tut_pref_board varchar2(20) not null,
  Tut_pref_loc varchar2(50) not null,
  Tut_mode_of_learning varchar2(20) not null,
  Primary Key ( Tut_ID, Tut_pref_subj, Tut_pref_board, Tut_pref_loc, Tut_mode_of_learning ),
  Foreign Key (Tut_ID) REFERENCES TutOR(Tut_ID ))
  
CREATE TABLE Applied_Tution(
  tut_ID Integer, 
  req_id Integer,
  Primary Key (tut_ID, req_id),
  Foreign Key (Tut_ID) REFERENCES Tutor(Tut_ID),
  Foreign Key (req_id) REFERENCES Requests(req_id)
);



CREATE TABLE Confirmed_Tution(
  tut_ID Integer, 
  Stud_id Integer,
  Primary Key (tut_ID, Stud_id),
  Foreign Key (Tut_ID) REFERENCES Tutor(Tut_ID),
  Foreign Key (Stud_ID) REFERENCES Student(Stud_ID)
);


set serveroutput on;
DECLARE
      Sname student.sname%type;
      Stud_phone student.Stude_phone%type;
      Stud_email student.Stud_email%type;
      Stud_address student.Stud_address%type;
      Stud_DOB student.Stud_DOB%type;
      Stud_gender student.Stud_gender%type;
      Stud_username student.Stud_username%type;
      Stud_password student.Stud_password%type;
      Stud_CNIC student.Stud_CNIC%type;
      Stud_ID student.stud_id%type; 

BEGIN
    
   
    Sname := '&name';
    Stud_phone := '&phone_number';
    Stud_email := '&email';
    Stud_address := '&address';
    Stud_DOB := '&Date_Of_Birth';
    Stud_gender := '&gender';
    Stud_username := '&username';
    Stud_password := '&password';
    Stud_CNIC := '&CNIC';
    select max(Stud_id) into Stud_id from student;
    Stud_id := Stud_id + 1;
    
    insert into student ( Stud_id, Sname, Stude_phone, Stud_email, Stud_address, Stud_DOB, Stud_gender, Stud_username, Stud_password, Stud_CNIC )
    values ( Stud_id, Sname, Stud_phone, Stud_email, Stud_address, Stud_DOB, Stud_gender, Stud_username, Stud_password, Stud_CNIC );
   
END;
/

set serveroutput on;
Declare
    username student.Stud_username%type;
    passsword student.Stud_password%type;
    countt int;
    
Begin 
    username := '&username';
    passsword := '&password';
    countt := 0;
    
    for i in (SELECT* from STUDENT WHERE Stud_username = username and Stud_Password = passsword )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Login Successful');
        countt := countt + 1;
    end Loop;
    
    if( countt < 1 ) then
        DBMS_OUTPUT.PUT_LINE('Unsuccessful Login');
    end if;
End;
/
 
 
set serveroutput on;
DECLARE
    TUT_ID TUTOR.TUT_ID%type;
    TNAME  TUTOR.TNAME%type;
    TUT_PHONE TUTOR.TUT_PHONE%type;
    TUT_EMAIL TUTOR.TUT_EMAIL%type;
    TUT_MID  TUTOR.TUT_MID%type;
    TUT_GENDER TUTOR.TUT_GENDER%type;
    TUT_DOB   TUTOR.TUT_DOB%type;
    TUT_USERNAME TUTOR.TUT_USERNAME%type;
    TUT_ADDRESS TUTOR.TUT_ADDRESS%type;
    TUT_PASSWORD TUTOR.TUT_PASSWORD %type;
    TUT_CNIC TUTOR.TUT_CNIC%type;
    TUT_RATING TUTOR.TUT_RATING%type;
    TUT_COINS TUTOR.TUT_COINS %type;
    TUT_DESCRIPTION TUTOR.TUT_DESCRIPTION%type;
    TUT_EXPERIENCE TUTOR.TUT_EXPERIENCE%type;
    TUT_PREF_SUBJ TUTOR_INFO.TUT_PREF_SUBJ % Type;
    TUT_PREF_BOARD TUTOR_INFO.TUT_PREF_BOARD % Type; 
    TUT_PREF_LOC TUTOR_INFO.TUT_PREF_LOC % Type;
    TUT_MODE_OF_LEARNING TUTOR_INFO.TUT_MODE_OF_LEARNING % Type;
    TUTor_ID TUTOR_INFO.TUT_ID % Type;
    RATE TUTOR_INFO.RATE % Type;

BEGIN
        TNAME := '&name';
        TUT_PHONE :='&phone_number';
        TUT_EMAIL := '&email';
        TUT_MID := null;
        TUT_GENDER := '&gender';
        TUT_DOB := '&DOB';
        TUT_USERNAME := '&username';
        TUT_ADDRESS := '&address';
        TUT_PASSWORD := '&password';
        TUT_CNIC := '&cnic';
        TUT_RATING := 0;
        TUT_COINS := 0;
        TUT_DESCRIPTION := '&description';
        TUT_EXPERIENCE := '&experience';
        TUT_PREF_SUBJ := '&preferred_subject';
        TUT_PREF_BOARD := '&preferred_board';
        TUT_PREF_LOC := '&preferred_location';
        TUT_MODE_OF_LEARNING := '&preferred_mode_of_learning';
        RATE := '&RATE';
       
        
    select max(TUT_ID) into TUT_ID from TUTOR;
    IF  TUT_ID IS NULL then
         TUT_ID := 2000;
    ELSE 
        TUT_ID := TUT_ID + 1;
    END IF;
    TUTor_ID := TUT_ID;
    
    insert into TUTOR ( TUT_ID, TNAME, TUT_PHONE, TUT_EMAIL, TUT_MID, TUT_GENDER, TUT_DOB, TUT_USERNAME, TUT_ADDRESS, 
    TUT_PASSWORD, TUT_CNIC, TUT_RATING, TUT_COINS, TUT_DESCRIPTION, TUT_EXPERIENCE )
    values ( TUT_ID, TNAME, TUT_PHONE, TUT_EMAIL, TUT_MID, TUT_GENDER, TUT_DOB, TUT_USERNAME, 
    TUT_ADDRESS, TUT_PASSWORD, TUT_CNIC, TUT_RATING, TUT_COINS, TUT_DESCRIPTION, TUT_EXPERIENCE );
    
    insert into tutor_info ( TUT_ID, TUT_PREF_SUBJ, TUT_PREF_BOARD, TUT_PREF_LOC, TUT_MODE_OF_LEARNING, RATE ) values 
    ( TUTor_ID, TUT_PREF_SUBJ, TUT_PREF_BOARD, TUT_PREF_LOC, TUT_MODE_OF_LEARNING, RATE);

END;
/

set serveroutput on;  --tutor buy package
DECLARE
    ppid package.pid%type;
    TUTo_ID TUTOR.TUT_ID%type;
    coins package.pkg_coins%type;

begin
    FOR i in (select pid,pkg_coins,pkg_costt from package)
    loop 
        DBMS_OUTPUT.PUT_LINE(i.pid || ' ' || i.pkg_coins || ' ' || i.pkg_costt);
    end loop;
    select max(TUT_ID) into TUTo_ID from TUTOR;
    DBMS_OUTPUT.PUT_LINE(TUTo_ID);
    ppid := '&package_id';
    select pkg_coins into coins from package where pid = ppid;
    update TUTOR set TUT_COINS = TUT_COINS + coins where TUT_ID = TUTo_ID;
    DBMS_OUTPUT.PUT_LINE('Successful Purchase');
    
end;
/
 
 set serveroutput on;  --student requests tutor
DECLARE
        REQ_ID	NUMBER(38,0);
        STUD_ID	NUMBER(38,0);
        REQ_BUDGET	FLOAT;
        REQ_SUBJ	VARCHAR2(20 BYTE);
        REQ_CLASS	NUMBER(38,0);
        REQ_BOARD	VARCHAR2(20 BYTE);
        REQ_PREF_GENDER	CHAR(1 BYTE);
        REQ_PREF_LOC	VARCHAR2(50 BYTE);
        REQ_MODE_OF_LEARNING	VARCHAR2(20 BYTE);
        REQ_EXPERIENCE	NUMBER(38,0);

begin
    select max(REQ_ID) into REQ_ID from REQUESTS;
    IF  REQ_ID IS NULL then
         REQ_ID := 500;
    ELSE 
        REQ_ID := REQ_ID + 1;
    END IF;
    select max(STUD_ID) into STUD_ID from student;
    REQ_BUDGET := '&requested_budget';
    REQ_SUBJ := '&subject';
    REQ_CLASS := '&class';
    REQ_BOARD := '&board';
    REQ_PREF_GENDER := '&gender';
    REQ_PREF_LOC := '&preferred_location';
    REQ_MODE_OF_LEARNING := '&MODE_OF_LEARNING';
    REQ_EXPERIENCE := '&EXPERIENCE';
    insert into requests (REQ_ID, STUD_ID, REQ_BUDGET, REQ_SUBJ, REQ_CLASS, REQ_BOARD, REQ_PREF_GENDER, 
    REQ_PREF_LOC, REQ_MODE_OF_LEARNING, REQ_EXPERIENCE) values (REQ_ID, STUD_ID, REQ_BUDGET, REQ_SUBJ, REQ_CLASS, REQ_BOARD, REQ_PREF_GENDER, 
    REQ_PREF_LOC, REQ_MODE_OF_LEARNING, REQ_EXPERIENCE);
    
    DBMS_OUTPUT.PUT_LINE('Successfully submitted request');
    
end;
/   

set serveroutput on;  --student dels request
DECLARE
    STUD_ID	NUMBER(38,0);
    RREQ_ID	NUMBER(38,0);
    
begin
    select max(STUD_ID) into STUD_ID from student;
    RREQ_ID := '&REQUEST_ID';
   DELETE FROM REQUESTS WHERE REQ_ID = RREQ_ID;
    DBMS_OUTPUT.PUT_LINE('Successfully Deleted');
    
end;

set serveroutput on;  --tutor upgrades membership request
DECLARE
    TUTO_ID NUMBER(38,0);
    MEM_ID	NUMBER(38,0);
    
begin
    select max(TUT_ID) into TUTO_ID from TUTOR;
    FOR i in (select MID,mbr_costt,mname from MEMBERSHIP)
    loop 
        DBMS_OUTPUT.PUT_LINE(i.mid || ' ' || i.mbr_costt || ' ' || i.mname);
    end loop;
    MEM_ID := '&MEMBERSHIP_ID_';
    UPDATE TUTOR SET TUT_MID = MEM_ID WHERE TUT_ID = TUTO_ID;
    DBMS_OUTPUT.PUT_LINE('Membership Successfully Upgraded');
end;

set serveroutput on;  --tutor upgrades membership request
DECLARE
    TUTO_ID NUMBER(38,0);
    
begin
    select max(TUT_ID) into TUTO_ID from TUTOR;
    FOR i in (select TUT_MID from TUTOR where TUTO_ID = TUT_ID )
    loop 
        DBMS_OUTPUT.PUT_LINE(i.TUT_MID);
    end loop;
    UPDATE TUTOR SET TUT_MID = NULL WHERE TUT_ID = TUTO_ID;
    DBMS_OUTPUT.PUT_LINE('Membership Successfully Deleted');
end;

set serveroutput on;  --tutor browses vacancies
DECLARE
     TUTO_ID NUMBER(38,0) ;
     TUTO_PREF_SUBJ VARCHAR2(20);
     TUTO_PREF_BOARD VARCHAR2(20);
     reqq_id integer;
     coins float;
     SNAMEE VARCHAR2(20);
     PHONE VARCHAR2(12);
     
begin 
     select max(TUT_ID) into TUTO_ID from TUTOR;
     select TUT_PREF_SUBJ, TUT_PREF_BOARD into TUTO_PREF_SUBJ, TUTO_PREF_BOARD from tutor_info where TUT_ID = TUTO_ID;
     
     for i in (select req_id from requests where REQ_SUBJ = TUTO_PREF_SUBJ and REQ_BOARD = TUTO_PREF_BOARD) 
     LOOP
         DBMS_OUTPUT.PUT_LINE(i.req_id);
     end loop;
     reqq_id := '&request_id';
     select TUT_COINS into coins from tutor where TUT_ID = TUTO_ID;
     if coins > 100 Then
        select SNAME, STUDE_PHONE INTO SNAMEE, PHONE from STUDENT,REQUESTS where STUDENT.STUD_ID = REQUESTS.STUD_ID;
        DBMS_OUTPUT.PUT_LINE(SNAMEE || '  ' || PHONE);
        INSERT INTO APPLIED_TUTION (TUT_ID, REQ_ID ) VALUES( TUTO_ID, reqq_id );
        DBMS_OUTPUT.PUT_LINE('SUCCESSFUL');
    ELSE 
         DBMS_OUTPUT.PUT_LINE('NO MATCHING RESULTS');
    END IF;
END;
/

set serveroutput on;  
Declare
    STUD_IDD INTEGER;
    TUT_IDD INTEGER;
    PREF_SUBJ VARCHAR2(20);
    PREF_BOARD VARCHAR2(20);
    PREF_LOC VARCHAR2(20);
    RATEE FLOAT;
    STATUSS INT;
    
Begin
    STATUSS := 0;
    select max(STUD_ID) into STUD_IDD from STUDENT;
    SELECT REQ_SUBJ, REQ_BOARD, REQ_PREF_LOC, REQ_BUDGET INTO PREF_SUBJ, PREF_BOARD, PREF_LOC, RATEE 
    from STUDENT, REQUESTS  WHERE REQUESTS.STUD_ID = STUDENT.STUD_ID AND STUDENT.STUD_ID = STUD_IDD;
    
    --DBMS_OUTPUT.PUT_LINE(PREF_SUBJ|| ' ' ||PREF_BOARD|| ' ' ||PREF_LOC || ' ' || RATEE);
    FOR i in ( select TUT_ID from TUTOR_INFO where TUT_PREF_SUBJ = PREF_SUBJ and TUT_PREF_BOARD = PREF_BOARD and TUT_PREF_LOC = PREF_LOC
    and RATE < RATEE )
    LOOP
        STATUSS := 1;
        DBMS_OUTPUT.PUT_LINE(i.TUT_ID);
    END LOOP;
    IF STATUSS = 1 THEN
        TUT_IDD := '&TUT_ID';
        INSERT INTO NOTIFICATIONN(MSG, STUD_ID, TUT_ID) VALUES('MSG SENT', STUD_IDD, TUT_IDD );
        DBMS_OUTPUT.PUT_LINE('NOTIFIED');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO MATCHING RESULTS');
    END IF;
END;  

SAVEPOINT S1;
set serveroutput on;  --tutor confirms
Declare
    req_idd INTEGER;
    TUT_IDD INTEGER;
    STUD_IDD INTEGER;
    STATUS INTEGER;
BEGIN
    select max(TUT_ID) into TUT_IDD from TUTOR;
    STATUS := 0;
    FOR i in (SELECT REQ_ID FROM APPLIED_TUTION WHERE TUT_ID = TUT_IDD)
    LOOP
        DBMS_OUTPUT.PUT_LINE(i.REQ_ID);
        STATUS := 1;
    END LOOP;
    IF STATUS = 1 THEN
        req_idd := '&req_id';
        DBMS_OUTPUT.PUT_LINE(req_idd);
        SELECT STUD_ID INTO STUD_IDD FROM REQUESTS, applied_tution WHERE REQUESTS.REQ_ID = applied_tution.req_id AND REQUESTS.REQ_ID = req_idd ;
        DELETE FROM APPLIED_TUTION where REQ_ID = req_idd;
        INSERT INTO CONFIRMED_TUTION VALUES (TUT_IDD, STUD_IDD);
        DELETE FROM REQUESTS where REQ_ID = req_idd;
        DBMS_OUTPUT.PUT_LINE('REQUEST DELETED');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO APPLIED REQUES');
    END IF; 
END;
/
rollback S1;  

SAVEPOINT S2;
set serveroutput on;  --student gives feedback

DECLARE 
    STUD_IDD INTEGER;
    TUT_IDD INTEGER;
    RATING INTEGER;
    STATUS INTEGER;
    
BEGIN
    select max(STUD_ID) into STUD_IDD from STUDENT;
    STATUS := 0;
    FOR i in (SELECT TUT_ID FROM CONFIRMED_TUTION WHERE STUD_ID = STUD_IDD)
    LOOP
        DBMS_OUTPUT.PUT_LINE(i.TUT_ID);
        STATUS := 1;
    END LOOP;
    IF STATUS = 1 THEN
        TUT_IDD := '&TUT_ID';
        RATING := '&RATING';
        UPDATE TUTOR SET TUT_RATING = (TUT_RATING + RATING) / 2 WHERE TUT_ID = TUT_IDD;
        DBMS_OUTPUT.PUT_LINE('FEEDBACK SUBMITTED');
        
    ELSE 
        DBMS_OUTPUT.PUT_LINE('NO CONFIRMED TUTION');
    END IF;
    
END;
/
ROLLBACK S2;    

CREATE TABLE ADMIN
(
    USERNAME VARCHAR2(20),
    PASSSWORD VARCHAR2(20),
    EMAIL VARCHAR2(30),
    PRIMARY KEY (USERNAME)
);

INSERT INTO ADMIN VALUES ('SAROSH27' , 'sar123' , 'sarosh.irfan45@goog.com' );

set serveroutput on;  --admin login
Declare
    usern varchar2(20);
    pass varchar2(20);
    userNa varchar2(20);
    passs varchar2(20);
begin
    usern := '&username';
    pass := '&password';
    
    SELECT username, passsword into userNa, passs from admin where rownum = 1;
    if usern = userNa and pass = passs then
        DBMS_OUTPUT.PUT_LINE('LOGIN SUCCESSFUL');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('LOGIN UNSUCCESSFUL');
    END IF;  
END;
/
  
savepoint S3;
set serveroutput on;  --admin block student
Declare  
    stud_idd integer;
    status integer;
begin
    stud_idd := '&student_id';
    status := 0;
    for i in (select stud_id from student where stud_id = stud_idd)
    LOOP
        delete from student where stud_id = stud_idd;
        DBMS_OUTPUT.PUT_LINE('BLOCKED SUCCESSFULLY');
        status := 1;
    END LOOP;
    
    if status = 0 then
        DBMS_OUTPUT.PUT_LINE('BLOCKED UNSUCCESSFUL');
    end if;
end;
/
rollback s3;