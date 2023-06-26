DROP TABLE process_plan; --공정계획
CREATE TABLE process_plan(
    planID      VARCHAR2(20)    NOT NULL
   ,prodNo      VARCHAR2(20)    NOT NULL
   ,prodQty     NUMBER
   ,lineID      VARCHAR(20)
   ,startdate   DATE
   ,enddate     DATE
   ,empName     VARCHAR2(20)
   ,check_yn    char(1) -- Y/N
   
   ,CONSTRAINT PK_plan_ID PRIMARY KEY(planID)
   ,CONSTRAINT PK_plan_prodNo PRIMARY KEY(prodNo)
);

select * from process_plan;
--------------------------------------------------------------------------------
DROP TABLE product; --제품
CREATE TABLE product(
    prodNo      VARCHAR2(20)    NOT NULL
   ,prodName    VARCHAR2(30)
   ,prodPrice   NUMBER
   ,category    VARCHAR2(20)
   ,leadtime    NUMBER
   
   ,CONSTRAINT PK_product_No PRIMARY KEY(prodNo)
);

select * from product;
--------------------------------------------------------------------------------
DROP TABLE BOM; --제품에 들어가는 원자재관리
CREATE TABLE BOM(
    prodNo      VARCHAR2(20)    NOT NULL
   ,materNo     VARCHAR2(20)    NOT NULL
   ,materQty    NUMBER
   
   ,CONSTRAINT PK_BOM_prodNo PRIMARY KEY(prodNo)
   ,CONSTRAINT PK_BOM_materNo PRIMARY KEY(materNo)
);

select * from BOM;
--------------------------------------------------------------------------------
DROP TABLE material; --원자재
CREATE TABLE material(
    materNo      VARCHAR2(20)    NOT NULL
   ,parentNo     VARCHAR2(20)
   ,materName    VARCHAR2(20)
   ,materPrice   NUMBER
   ,node         VARCHAR2(20)
   ,unit         VARCHAR2(10)
   
   ,CONSTRAINT PK_material_No PRIMARY KEY(meterNo)
);
select * from material;
--------------------------------------------------------------------------------
DROP TABLE inventory; --재고
CREATE TABLE inventory(
    LOT        VARCHAR(10)     NOT NULL
   ,prodNo     VARCHAR2(20)
   ,materNo    VARCHAR2(20)
   ,prodQty    NUMBER
   ,materQty   NUMBER
   ,whseNo     VARCHAR2(20)
   
   ,CONSTRAINT PK_inventory_LOT PRIMARY KEY(LOT)
);

select * from inventory;
--------------------------------------------------------------------------------
DROP TABLE warehouse; --창고
CREATE TABLE warehouse(
    whseNo     VARCHAR2(20)     NOT NULL
   ,whseLoc    VARCHAR2(200)
   ,whseName   VARCHAR2(50)
    
   ,CONSTRAINT PK_warehouse_No PRIMARY KEY(whseNo)
);

select * from warehouse;
--------------------------------------------------------------------------------
DROP TABLE process; -- 공정
CREATE TABLE process
(
     processID  VARCHAR2(20) NOT NULL
    ,planID     VARCHAR2(20) 
    ,leadTime   NUMBER
    ,CONSTRAINT PK_process_ID PRIMARY KEY(processID)
);

SELECT * FROM process;
--------------------------------------------------------------------------------
DROP TABLE result_prod; -- 생산제품
CREATE TABLE result_prod 
(
     resprodID   VARCHAR2(20) 
    ,processID   VARCHAR2(20) 
    ,prodNo      VARCHAR2(20)
    ,prodName    VARCHAR2(30)
    ,prodQty     NUMBER 
    ,cycleTime   NUMBER
    ,status      NUMBER -- "0/1" -> pass/fail
    ,CONSTRAINT PK_result_prod_ID PRIMARY KEY(resprodID)
);
SELECT * FROM result_prod;
--------------------------------------------------------------------------------
DROP TABLE process_Time; -- 시간대별 생산
CREATE TABLE process_Time
(
     processTime    NUMBER  NOT NULL
    ,planID         VARCHAR2(20)
    ,value          NUMBER
    ,CONSTRAINT PK_process_Time PRIMARY KEY(processTime)
);

SELECT * FROM process_Time;
--------------------------------------------------------------------------------
DROP TABLE process_res; --공정결과
CREATE TABLE process_res (
    resID      VARCHAR2(20) NOT NULL
   ,planID     VARCHAR2(20)
   ,startdate  DATE  
   ,enddate    DATE 
   ,passedQty  NUMBER 
   ,failedQty  NUMBER 
   ,empNo      VARCHAR2(20)
   ,CONSTRAINT PK_process_res_ID PRIMARY KEY(resID)
);

SELECT * FROM process_res;
--------------------------------------------------------------------------------
DROP TABLE process_issue;-- 공정이슈
CREATE TABLE process_issue (
   arm_seq      NUMBER  NOT NULL
   ,planID      VARCHAR2(20)
   ,issueNo     VARCHAR2(10)
   ,issueInfo   VARCHAR2(50)
   ,timestamp   DATE
   
   ,CONSTRAINT PK_process_issue_seq PRIMARY KEY(arm_seq)
);

select * from process_issue;
--------------------------------------------------------------------------------
DROP TABLE issue; --이슈
CREATE TABLE issue (
    issueNo     VARCHAR2(10) NOT NULL
   ,issueName   VARCHAR2(30) 
   
   ,CONSTRAINT PK_issue_No PRIMARY KEY(issueNo)
);

select * from issue;
--------------------------------------------------------------------------------
DROP TABLE line; --생산라인
CREATE TABLE line (
    lineID     VARCHAR2(10)
   ,prodName   VARCHAR2(20)
   ,status     VARCHAR2(10) --ON/OFF 
   
   ,CONSTRAINT PK_line_ID PRIMARY KEY(lineID)
)

select * from line;
--------------------------------------------------------------------------------
CREATE TABLE e_user( --MEMBER
    USERNO  NUMBER,
    EMPNO   CHAR(10),
    NAME    VARCHAR2(30) NOT NULL,
    ID      VARCHAR2(50) NOT NULL,
    PW      VARCHAR2(50) NOT NULL,
    RANK    VARCHAR2(50) NOT NULL,
    ADMIN    CHAR(1)      DEFAULT 0,
    REGIDATE VARCHAR(20) DEFAULT SYSDATE,
    CONSTRAINT pk_USER PRIMARY KEY(userno)
    );
--------------------------------------------------------------------------------
CREATE SEQUENCE user_seq --시퀀스
       INCREMENT BY 1
       START WITH 1000
       MINVALUE 1000
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
    
SELECT user_seq.CURRVAL FROM dual;
    
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 00000000, '시스템관리자', 'admin1', 'admin123', 'Guest', 1);
INSERT INTO e_user(userno, empno, name, id, pw, rank, admin) VALUES(user_seq.NEXTVAL, 00000000, 'TEST', 'test1', 'test123', 'Guest', 0);
--------------------------------------------------------------------------------
