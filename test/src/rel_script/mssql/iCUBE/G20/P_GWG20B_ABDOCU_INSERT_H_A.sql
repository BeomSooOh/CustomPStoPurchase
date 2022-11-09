USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]    Script Date: 11/28/2016 11:39:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_H_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]    Script Date: 11/28/2016 11:39:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H]    Script Date: 09/10/2012 10:23:19 ******/    

/*    
1. EZICUBE DB의 P_GWG20B_ABDOCU_INSERT_H 프로시저와 내용 같음.    
2. ABDOCU 의 DUMMY1 에 GW 에서 제공한 데이터를 저장함.    
3. 실패가 났을 경우 조회조건으로 이용    
    
*/    
        
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]                  
  --필수값                   
   @ERP_CO_CD   NVARCHAR(4) --ERP회사코드                  
 , @ERP_GISU_DT  NVARCHAR(8)  --결의일                  
 , @ERP_EMP_CD  NVARCHAR(10) --ERP작업자                  
 , @ERP_DIV_CD  NVARCHAR(4)  --ERP사업장코드                  
 , @ERP_DEPT_CD  NVARCHAR(4)  --ERP부서코드                  
 , @MGT_CD   NVARCHAR(10) --ERP 프로젝트 코드                  
 , @DOCU_FG   NVARCHAR(2)  --ERP 결의구분                  
 , @RMK_DC   NVARCHAR(100) --ERP 적요                  
 , @ADMIT_YN   NVARCHAR(1)  --                  
 , @ACISU_DT   NVARCHAR(8)  --                  
 , @EXEC_DT   NVARCHAR(8)  --                  
 , @REG_DT   NVARCHAR(8)  --                   
 , @RISU_DT   NVARCHAR(8)  --                  
 , @RISU_SQ   INT                  
 , @BTR_CD   NVARCHAR(10)  --                  
 , @BTR_NM   NVARCHAR(40)  --                  
 , @CAUSE_DT   NVARCHAR(8)  --                  
 , @SIGN_DT   NVARCHAR(8)  --                  
 , @INSPECT_DT  NVARCHAR(8)  --                  
 , @GISU_DT   NVARCHAR(8)  = NULL OUTPUT                          
 , @GISU_SQ   NUMERIC(5,0)  = NULL OUTPUT                 
 , @REF_PART_FG NVARCHAR(2)                        
 , @REF_GET_NO NVARCHAR(16)                        
 , @REF_PART_DT NVARCHAR(16)                        
 , @REF_PART_SQ NVARCHAR(10)      
 , @BANK_DT NVARCHAR(8)      
 , @TRAN_CD NVARCHAR(3)      
 , @BOTTOM_CD NVARCHAR(10)    
 , @DUMMY1 NVARCHAR(50) = null    
 , @CAUSE_ID NVARCHAR(10) --원인행위자
 , @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT          
AS                            
/*                                                            
   목   적 :  결의서 헤더 (ABDOCU) 추가함.                             
   환   경 :                                   
   관련 객체 :                                    
   작성일/작성자 : 2009.11. , HSKIM                                  
   리턴값 : 성공/실패                              
   작업순서                                                      
   주의점 :                     
   수정사항 :                     
                  
--================================                                  
*/                                    
-- 세션 기본 설정                                  
SET NOCOUNT ON;                                    
IF @@LOCK_TIMEOUT < 500                                   
SET LOCK_TIMEOUT  500;                                                                          
SET DEADLOCK_PRIORITY NORMAL;                             
    
--======================================================================================================================================================                                        
DECLARE   @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                             
  , @ret_val      int              -- 결과 리턴값                                                            
  , @error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                                   
  , @row_cnt      int                                         
    
-- 리턴값은 알수 없는 에러로  초기화함.                                                            
-- 에러코드를 성공으로 초기화                                                            
SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_H',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';                         
    
--=================================================================                  
-- 변수 선언                  
--====================================                  
    
--필수값 검사                   
IF NULLIF(@ERP_CO_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(회사코드)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@ERP_DIV_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(사업장코드)';                   
 GOTO END_PROC;                  
END                    
    
/*    
IF NULLIF(@ERP_DEPT_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(부서코드)';                      
 GOTO END_PROC;                  
END        
*/                
    
/*    
IF NULLIF(@ERP_EMP_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(사원번호)';                      
 GOTO END_PROC;                  
END                    
*/    
IF NULLIF(@MGT_CD,'') IS NULL               
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(프로젝트/부서코드)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@DOCU_FG,'') IS NULL                  
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(결의구분)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@ERP_GISU_DT,'') IS NULL                  
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(결의일)';                      
 GOTO END_PROC;                  
END                   
    
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE                  
BEGIN TRANSACTION;                  
    
DECLARE @BANK_SQ NUMERIC(5,0)    

BEGIN    
 --결의번호 가져오기                   
 EXEC USP_GET_ABDOCU_KEY_NB @ERP_CO_CD,N'ABDOCU', @ERP_GISU_DT, @GISU_SQ OUTPUT                  
    
 --결의서 등록 (ABDOCU)                  
 INSERT INTO ABDOCU                   
 (                   
    CO_CD   , DIV_CD   , DEPT_CD   , EMP_CD    
  , GISU_DT  , GISU_SQ   , DOCU_FG   , MGT_CD    
  , RMK_DC  , RMK_DCK   , ACISU_DT   , EXEC_DT    
  , REG_DT  , CAUSE_DT   , SIGN_DT   , INSPECT_DT    
  , BTR_CD  , GW_STATE   , INSERT_ID   , INSERT_IP    
  , INSERT_DT  , EXTER_FG   , BOTTOM_CD   , DUMMY2 , CAUSE_ID   
 )                   
 VALUES    
 (                  
    @ERP_CO_CD , @ERP_DIV_CD  , @ERP_DEPT_CD  , @ERP_EMP_CD    
  , @ERP_GISU_DT , @GISU_SQ   , @DOCU_FG   , @MGT_CD    
  , @RMK_DC  , @RMK_DC   , @ACISU_DT   , @EXEC_DT    
  , @REG_DT  , @CAUSE_DT   , @SIGN_DT   , @INSPECT_DT    
  , @BTR_CD  , '0'    , @ERP_EMP_CD  , ''    
  , GETDATE()  , 'GW'    , @BOTTOM_CD  , @DUMMY1 , @CAUSE_ID    
 )             
END         
    
------------------------------------------------------------------------------------------------------              
-- @REF_GET_NO 가 있을 경우 참조 품의서 이므로 ABIN 테이블을 업데이트            
-- 2010-08-17 김재경 추가                 
------------------------------------------------------------------------------------------------------      
IF ISNULL(@REF_GET_NO,'') != ''            
BEGIN              
 -- PART_YN : 1.전체, 2.부분전송            
 -- PART_ST : 2.전체, 1.부분전송           
 IF ISNULL(@REF_PART_FG, '') = '1'        
 BEGIN        
  UPDATE ABIN           
  SET           
     PART_YN ='1'          
   , PART_ST = '2'          
   , GW_YN = '1'          
   , GISU_NO = @ERP_GISU_DT + '-' + CAST(@GISU_SQ AS VARCHAR)          
   , GISU_DT = @ERP_GISU_DT          
   , GISU_SQ = @GISU_SQ           
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO            
 END        
 ELSE        
 BEGIN        
  -- 부분전송        
  UPDATE ABIN           
  SET           
     PART_YN ='2'          
   , PART_ST = '1'          
   , GW_YN = '1'          
   , GISU_NO = '부분전송'        
   , GISU_DT = @ERP_GISU_DT          
   , GISU_SQ = @GISU_SQ           
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO         
    
    
  UPDATE ABIN_PART_H      
  SET GISU_DT = @ERP_GISU_DT      
   , GISU_SQ = @GISU_SQ      
   , MODIFY_ID = @ERP_EMP_CD      
   , MODIFY_DT = GETDATE()      
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO         
  AND PART_DT = @REF_PART_DT AND PART_SQ = CAST(@REF_PART_SQ AS INT)      
 END              
END            
    
------------------------------------------------------------------------------------------------------      
SELECT @error_code = @@ERROR , @row_cnt = @@rowcount                   
    
IF @error_code!=0                   
BEGIN                   
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;                  
 SELECT @ret_val=-1,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::결의서 헤더(ABDOCU) 신규 생성 중 오류 발생';                                 
 GOTO END_PROC;                  
END                   
    
 select @ret_val = 0, @RETURN_MESSAGE = '0:성공';       
        
COMMIT TRANSACTION;                  
    
END_PROC:       
    
-- SELECT 0,'0::성공',  @ERP_GISU_DT  ,  @GISU_SQ, ISNULL(@BANK_SQ, 0)    
SELECT @ret_val AS ret_val
     , @RETURN_MESSAGE AS RETURN_MESSAGE
     , @ERP_GISU_DT AS ERP_GISU_DT
     , @GISU_SQ AS ERP_GISU_SQ
     , ISNULL(@BANK_SQ, 0) AS ERP_BANK_SQ  
    
print '@ret_val : ' + cast(@ret_val as varchar) + ':' + @RETURN_MESSAGE                
RETURN @ret_val ; 


GO


