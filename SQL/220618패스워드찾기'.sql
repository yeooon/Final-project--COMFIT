SELECT COUNT(*)
FROM USER_INFORMATION
WHERE U_EMAIL = 'kkk@naver.com'
AND U_TEL = '010-2222-3333'
AND U_NAME = '김민성'
;
--==>1 .. 정확한 값
---> 0 .. 틀린 값

-- 한줄 구성

SELECT COUNT(*) FROM USER_INFORMATION WHERE U_EMAIL = 'kkk@naver.com' AND U_TEL = '010-2222-3333' AND U_NAME = '김민성'
;

-- 비밀번호 찾기용
INSERT INTO USER_EMAIL_AUTH(E_AUTH_ID, AUTH_CODE, U_ID, AU_CATE_ID ) VALUES(CONCAT('auth_', USER_EMAIL_AUTH_SEQ.NEXTVAL), ? , ?, 2)
;

SELECT C.U_ID
FROM COMFIT_USER C JOIN USER_INFORMATION U
ON C.U_ID = U.U_ID
WHERE U.U_EMAIL = 'hjui78@naver.com';

-- 비밀번호 찾기용, U_ID 가 필요함..
INSERT INTO USER_EMAIL_AUTH(E_AUTH_ID, AUTH_CODE, U_ID, AU_CATE_ID ) VALUES(CONCAT('auth_', USER_EMAIL_AUTH_SEQ.NEXTVAL), ? ,(SELECT C.U_ID FROM COMFIT_USER C JOIN USER_INFORMATION U ON C.U_ID = U.U_ID WHERE U.U_EMAIL = ?), 2)
;

-- 인증키 사용 여부
SELECT COUNT(*) FROM USER_EMAIL_AUTH WHERE AUTH_CODE = '86LfyVFuLG' AND auth_use_date IS NULL
;

-- 인증 키 사용하기
UPDATE USER_EMAIL_AUTH SET AUTH_USE_DATE = SYSDATE WHERE AUTH_CODE = ?
;



-- 비밀번호 변경

UPDATE USER_INFORMATION SET U_PASSWORD = CRYPTPACK.ENCRYPT('1234','1234') WHERE U_ID = (SELECT U_ID FROM USER_EMAIL_AUTH WHERE AUTH_CODE='2inR6denlG')
;


COMMIT;


select count(*)
from user_information
where u_email='hjui78@naver.com'
and u_password=cryptpack.encrypt('1234','1234');


SELECT UI.U_ID AS U_ID , NVL(TO_CHAR(UE.AUTH_USE_DATE,'YYYY-MM-DD'), '0') AS AUTH
		FROM USER_INFORMATION UI JOIN USER_EMAIL_AUTH UE
		ON UI.U_ID = UE.U_ID
		WHERE UI.U_EMAIL = 'hjui78@naver.com'
		AND UI.U_PASSWORD = CRYPTPACK.ENCRYPT('1234', '1234')
        AND UE.AU_CATE_ID=1;

select count(*)
from user_email_auth
where u_id = 'test36';

UPDATE USER_INFORMATION
SET U_PROFILE = 'defaultprofil.jpg'
WHERE U_ID = 'test36'
;
commit;

SELECT BID_CODE, U_NICKNAME, PRICE, BID_DATE, ADDRESS, PROFILE
FROM BID_LIST_REALVIEW;
		




SELECT PD_ID, PD_TITLE, PD_NAME, PD_PHOTO, PD_AS_REMAIN, PD_HITCOUNT, PRICE
		     , PD_REGIT_DATE, PD_MAKER_ID, PD_AS_ID, PD_AS_NAME, CATEGORY_NAME, SELLER
		     , U_NICKNAME, MAKER_NAME, MAKER_NAME2, CF_PRICE, COMMENTS, IMDPRICE, (PD_REGIT_DATE+5) AS REMAIN_DATE 
             , PROFILE
		FROM DELI_PD_LIST_REALVIEW; 
	
    
SELECT PD_ID, PD_NAME, PRICE, PD_PHOTO
FROM PD_LIST_MAIN_VIEW
ORDER BY PD_REGIT_DATE    ;







