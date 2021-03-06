
SELECT *
FROM USER_INFORMATION U JOIN DELI_PD_BANNED DPB
ON U.U_ID = DPB.U_ID;

SELECT *
FROM DELI_PD_BANNED

-- 택배거래 신고접수
SELECT *
FROM DELIVERY_PD_REPORT;

-- 택배거래 신고처리
SELECT *
FROM DELI_PD_REP_HANDLE;

-- 택배거래 차단등록 
SELECT *
FROM DELI_PD_BANNED;

-- 택배거래 판매 상품
SELECT *
FROM DELIVERY_PRODUCT;

INSERT INTO DELIVERY_PD_REPORT(REP_ID, REP_CONTENTS, U_ID, PD_REP_CID, DELI_PD_ID)
VALUES('delirep_1', '유해한 내용 업로드', 'test1', 3, 'deli_1');

INSERT INTO DELI_PD_REP_HANDLE(REP_ID, AD_ID, HAN_CATE_ID)
VALUES('delirep_1', 'cf_admin', 2);

INSERT INTO DELI_PD_BANNED(BAN_ID, BAN_REA_DETAIL, REP_ID, BAN_CATE_ID)
VALUES('ban_1', '유해한 내용을 업로드한 것을 확인함', 'delirep_1', 1);



-- 택배 상품 누적 차단 카운트를 위한 view
CREATE OR REPLACE VIEW DELIVERY_PD_BANNED_VIEW
AS
SELECT DPR.REP_ID, DPR.REP_CONTENTS, DPR.REP_DATE, DPR.PD_REP_CID, DPR.DELI_PD_ID
     , DPH.REP_HAN_DATE, DPH.HAN_CATE_ID
     , DPB.BAN_ID, DPB.BAN_REA_DETAIL, DPB.BAN_DATE, DPB.BAN_CATE_ID
     , DP.PD_TITLE, DP.PD_REGIT_DATE,DPR.U_ID AS REPORTER, DP.U_ID AS REPORTED , DPH.AD_ID
FROM DELIVERY_PD_REPORT DPR 
    JOIN DELI_PD_REP_HANDLE DPH 
    ON DPR.REP_ID = DPH.REP_ID 
    JOIN DELI_PD_BANNED DPB
    ON DPH.REP_ID = DPB.REP_ID
    JOIN DELIVERY_PRODUCT DP
    ON DP.DELI_PD_ID = DPR.DELI_PD_ID;


-- 택배 상품 누적 차단 횟수 확인 쿼리문
SELECT COUNT(*) AS COUNT
FROM DELIVERY_PD_BANNED_VIEW
WHERE REPORTED = 'test2';


SELECT *
FROM DELIVERY_PD_BANNED_VIEW
WHERE REPORTED = 'test2';


-- 직거래 상품 누적 차단 카운트를 위한 view
CREATE OR REPLACE VIEW DIRECT_PD_BANNED_VIEW
AS
SELECT DPR.REP_ID, DPR.REP_CONTENTS, DPR.REP_DATE, DPR.PD_REP_CID, DPR.DIRE_PD_ID
     , DPH.REP_HAN_DATE, DPH.HAN_CATE_ID
     , DPB.BAN_ID, DPB.BAN_REA_DETAIL, DPB.BAN_DATE, DPB.BAN_CATE_ID
     , DP.PD_TITLE, DP.PD_REGIT_DATE,DPR.U_ID AS REPORTER, DP.U_ID AS REPORTED , DPH.AD_ID
FROM DIRECT_PD_REPORT DPR 
    JOIN DIRE_PD_REP_HANDLE DPH 
    ON DPR.REP_ID = DPH.REP_ID 
    JOIN DIRE_PD_BANNED DPB
    ON DPH.REP_ID = DPB.REP_ID
    JOIN DIRECT_PRODUCT DP
    ON DP.DIRE_PD_ID = DPR.DIRE_PD_ID;


-- 직거래 상품 누적 차단 횟수 확인 쿼리문
SELECT COUNT(*) AS COUNT
FROM DIRECT_PD_BANNED_VIEW
WHERE REPORTED = 'test2';



-- 택배 거래 누적 차단 카운트를 위한 view
CREATE OR REPLACE VIEW DELIVERY_TRANS_BANNED_VIEW
AS
SELECT DTB.BAN_ID, DTB.BAN_REA_DETAIL, DTB.BAN_DATE, DTB.REP_ID, DTB.BAN_CATE_ID
     , DTH.REP_HAN_DATE, DTH.HAN_CATE_ID
     , DTR.REP_CONTENTS, DTR.REP_DATE, DTR.TRANS_REP_CID, DTR.BS_ID, DTR.REPORTER_ID
     , BS.BS_DATE, BS.BID_CODE
     , BL.BID_DATE, DP.PD_TITLE, DP.PD_REGIT_DATE
     , CASE WHEN DTR.REPORTER_ID = 1 
        THEN BL.U_ID
        ELSE DP.U_ID
        END AS REPORTER
     , CASE WHEN DTR.REPORTER_ID = 1
        THEN DP.U_ID
        ELSE BL.U_ID
        END AS REPORTED
     , DTH.AD_ID 
FROM DELI_TA_BANNED DTB
    JOIN DELI_TA_REP_HANDLE DTH
    ON DTB.REP_ID = DTH.REP_ID
    JOIN DELIVERY_TA_REPORT DTR
    ON DTH.REP_ID = DTR.REP_ID
    JOIN BID_SUCCESS BS
    ON DTR.BS_ID = BS.BS_ID
    JOIN BID_LIST BL
    ON BS.BID_CODE = BL.BID_CODE
    JOIN DELIVERY_PRODUCT DP
    ON BL.DELI_PD_ID = DP.DELI_PD_ID;
--==>> View DELIVERY_TRANS_BANNED_VIEW이(가) 생성되었습니다.



-- 택배 거래 누적 차단 횟수 확인 쿼리문
SELECT COUNT(*) AS COUNT
FROM DILIVERY_TRANS_BANNED_VIEW
WHERE REPORTED = 'test2';



-- 직거래 거래 누적 차단 카운트를 위한 view
CREATE OR REPLACE VIEW DIRECT_TRANS_BANNED_VIEW
AS
SELECT DTB.BAN_ID, DTB.BAN_REA_DETAIL, DTB.BAN_DATE, DTB.REP_ID, DTB.BAN_CATE_ID
     , DTH.REP_HAN_DATE, DTH.HAN_CATE_ID
     , DTR.REP_CONTENTS, DTR.REP_DATE, DTR.TRANS_REP_CID, DTR.SELECTED_ID, DTR.REPORTER_ID
     , S.SELECTED_DATE, S.SUGGEST_CODE
     , SL.SUGGEST_DATE, DP.PD_TITLE, DP.PD_REGIT_DATE
     , CASE WHEN DTR.REPORTER_ID = 1 
        THEN SL.U_ID
        ELSE DP.U_ID
        END AS REPORTER
     , CASE WHEN DTR.REPORTER_ID = 1
        THEN DP.U_ID
        ELSE SL.U_ID
        END AS REPORTED
     , DTH.AD_ID 
FROM DIRE_TA_BANNED DTB
    JOIN DIRE_TA_REP_HANDLE DTH
    ON DTB.REP_ID = DTH.REP_ID
    JOIN DIRECT_TA_REPORT DTR
    ON DTH.REP_ID = DTR.REP_ID
    JOIN SELECTED S
    ON DTR.SELECTED_ID = S.SELECTED_ID
    JOIN SUGGEST_LIST SL
    ON S.SUGGEST_CODE = SL.SUGGEST_CODE
    JOIN DIRECT_PRODUCT DP
    ON SL.DIRE_PD_ID = DP.DIRE_PD_ID;
--==>> View DIRECT_TRANS_BANNED_VIEW이(가) 생성되었습니다.

-- 직거래 누적 차단 횟수 확인 쿼리문
SELECT COUNT(*) AS COUNT
FROM DIRECT_TRANS_BANNED_VIEW
WHERE REPORTED = 'test2';


-- 누적차단횟수 조회 쿼리문
SELECT COUNT(*) AS COUNT
FROM
(
SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
FROM DIRECT_TRANS_BANNED_VIEW
UNION
SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
FROM DELIVERY_TRANS_BANNED_VIEW
UNION
SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
FROM DIRECT_PD_BANNED_VIEW
UNION
SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
FROM DELIVERY_PD_BANNED_VIEW
)
WHERE REPORTED = 'test2';

SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
FROM DIRECT_TRANS_BANNED_VIEW;

SELECT *
FROM COMFIT_USER;

--------------------------------------------------------------------------------

SELECT U_EMAIL, U_NAME, U_NICKNAME, U_TEL, U_JOINDATE, 
(
    SELECT COUNT(*) AS COUNT
    FROM
    (
    SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
    FROM DIRECT_TRANS_BANNED_VIEW
    UNION
    SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
    FROM DELIVERY_TRANS_BANNED_VIEW
    UNION
    SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
    FROM DIRECT_PD_BANNED_VIEW
    UNION
    SELECT BAN_ID, BAN_DATE, REPORTED, REPORTER
    FROM DELIVERY_PD_BANNED_VIEW
    )
    WHERE U_ID = REPORTED
) AS BANCOUNT
FROM USER_INFORMATION;

--------------------------------------------------------------------------------
--○ 관리자 고객센터

-- 모든 상품 신고 접수 뷰

CREATE OR REPLACE VIEW PRODUCT_REPORT_VIEW
AS
SELECT REPOTED, PD_ID, REPOTER, REP_CONTENTS, HANDLE, REP_DATE, HAN_DATE
, 
CASE WHEN HANDLE = 1 OR HANDLE = 4
THEN 'NOBLIND' 
ELSE 'BLIND'
END AS BLIND 
FROM
(
SELECT DP.U_ID "REPOTED", DPR.DELI_PD_ID "PD_ID", DPR.U_ID "REPOTER", DPR.REP_CONTENTS "REP_CONTENTS", DPH.HAN_CATE_ID "HANDLE", DPR.REP_DATE "REP_DATE", DPH.REP_HAN_DATE"HAN_DATE"
FROM DELIVERY_PD_REPORT DPR 
    LEFT OUTER JOIN DELI_PD_REP_HANDLE DPH 
    ON DPR.REP_ID = DPH.REP_ID 
    LEFT OUTER JOIN DELI_PD_BANNED DPB
    ON DPH.REP_ID = DPB.REP_ID
    LEFT OUTER JOIN DELIVERY_PRODUCT DP
    ON DP.DELI_PD_ID = DPR.DELI_PD_ID
UNION
SELECT DP.U_ID "REPOTED", DPR.DIRE_PD_ID "PD_ID", DPR.U_ID "REPOTER", DPR.REP_CONTENTS "REP_CONTENTS", DPH.HAN_CATE_ID "HANDLE", DPR.REP_DATE "REP_DATE", DPH.REP_HAN_DATE"HAN_DATE"
FROM DIRECT_PD_REPORT DPR 
    LEFT OUTER JOIN DIRE_PD_REP_HANDLE DPH 
    ON DPR.REP_ID = DPH.REP_ID 
    LEFT OUTER JOIN DIRE_PD_BANNED DPB
    ON DPH.REP_ID = DPB.REP_ID
    LEFT OUTER JOIN DIRECT_PRODUCT DP
    ON DP.DIRE_PD_ID = DPR.DIRE_PD_ID
);

SELECT *
FROM DIRECT_PD_REPORT;

SELECT *
FROM DELIVERY_PD_REPORT;


--○ 문의사항 리스트 뷰
SELECT A.U_ID"문의한회원", A.ASK_CONTENTS"문의제목", A.ASK_DATE"접수시간", AA.ASK_ID"처리여부?", AA.ANSWER_DATE"처리시간"
FROM ASK A JOIN ASK_ANSWER AA
ON A.ASK_ID = AA.ASK_ID;