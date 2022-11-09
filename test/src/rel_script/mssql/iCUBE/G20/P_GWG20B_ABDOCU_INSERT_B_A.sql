USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_B_A]    Script Date: 11/28/2016 11:39:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_B_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_B_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_B_A]    Script Date: 11/28/2016 11:39:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



    
      
       
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_B_A]      
  --필수값      
   @ERP_CO_CD   NVARCHAR(4) --ERP회사코드      
 , @ERP_GISU_DT  NVARCHAR(8)  --결의일      
 , @ERP_GISU_SQ  NVARCHAR(8)      
 , @ERP_EMP_CD  NVARCHAR(10) --ERP작업자      
 , @BGT_CD   NVARCHAR(10) --ERP예산과목코드      
 , @SET_FG   NVARCHAR(1)  --      
 , @VAT_FG   NVARCHAR(1)  --      
 , @TR_FG   NVARCHAR(1)  --      
 , @RMK_DC NVARCHAR(200) =''    
 , @BANK_DT NVARCHAR(8)      
 , @BANK_SQ NUMERIC(5,0)    
 , @TRAN_CD NVARCHAR(3)      
 , @DIV_CD2   NVARCHAR(4)  --      
 , @IT_USE_WAY NVARCHAR(2)    
 , @BQ_SQ    NUMERIC(5,0)  = NULL OUTPUT                
 , @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT               
AS                
/*                                                
   목   적 :  결의서 미들 (ABDOCU_B) 추가함.                 
   환   경 :                       
   관련 객체 :                        
   작성일/작성자 : 2010.07. , HSKIM                      
   리턴값 : 성공/실패                  
   작업순서                                          
   주의점 :         
   수정사항 :    2010.08. , HSKIM - ABDOCU_B.RMK_DC 컬럼이 추가됨에 따라 ABDOCU.RMK_DC 정보를 가져와 INSERT     
      
--================================                      
*/                        
            
                
   -- 세션 기본 설정                      
   SET NOCOUNT ON;                        
   IF @@LOCK_TIMEOUT < 500                       
       SET LOCK_TIMEOUT  500;                                                              
   SET DEADLOCK_PRIORITY NORMAL;                 
                                          
                      
--======================================================================================================================================================                            
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                 
           ,@ret_val      int              -- 결과 리턴값                                                
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                       
           ,@row_cnt      int                             
             
    -- 리턴값은 알수 없는 에러로  초기화함.                                                
    -- 에러코드를 성공으로 초기화                                                
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_B',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';             
      
      
 --=================================================================      
 -- 변수 선언      
      
      
   --====================================      
    --필수값 검사       
      IF NULLIF(@ERP_GISU_DT,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(결의일)';          
          GOTO END_PROC;      
        END        
      IF NULLIF(@ERP_GISU_SQ,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(결의번호)';          
          GOTO END_PROC;      
        END        
      
      IF NULLIF(@BGT_CD,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(예산과목)';          
          GOTO END_PROC;      
        END        
           
      
 IF EXISTS ( SELECT 1 FROM ABDOCU_B where CO_CD = @ERP_CO_CD       
  AND GISU_DT = @ERP_GISU_SQ       
  AND GISU_SQ = @ERP_GISU_SQ      
  AND ISU_SQ > 0  )      
 BEGIN      
   SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':이미 전표가 발행된 결의서입니다.';          
   GOTO END_PROC;      
 END      
      
      
      
 SET TRANSACTION ISOLATION LEVEL SERIALIZABLE      
 BEGIN TRANSACTION;      
       
     
IF @BANK_DT != ''    -- 카드/계좌 연동    
  BEGIN                      
            
 DECLARE @BK_SQ INT    
      
 SET @BK_SQ = (SELECT  MAX(BANK_SQ) FROM ABDOCU_CMS_B (NOLOCK) WHERE CO_CD = @ERP_CO_CD AND BANK_DT = @BANK_DT AND BANK_SQ = @BANK_SQ AND TRAN_CD = @TRAN_CD)    
     
 SET @BK_SQ = ISNULL(@BK_SQ, 0) + 1    
     
 SELECT @ERP_GISU_DT = @BANK_DT,  @ERP_GISU_SQ = 0, @BQ_SQ = 0    
      
 INSERT INTO ABDOCU_CMS_B    
 (    
    CO_CD   , BANK_DT   , BANK_SQ   , BK_SQ    
  , TRAN_CD  , ABGT_CD   , VAT_FG   , TR_FG    , DIV_CD2  , RMK_DC   , INSERT_ID   ,INSERT_DT  , RMK_DCK    
 )                   
 VALUES     
 (    
    @ERP_CO_CD , @BANK_DT   , @BANK_SQ   , @BK_SQ    
  , @TRAN_CD  , @BGT_CD   , @VAT_FG   , @TR_FG    
  , @DIV_CD2  , @RMK_DC   , @ERP_EMP_CD  , GETDATE()  , @RMK_DC    
 )     
               
  END    
    
ELSE    
    
  BEGIN    
      
   --결의순번 구하기        
 EXEC USP_GET_ABDOCUB_KEY_NB @ERP_CO_CD,N'ABDOCU_B', @ERP_GISU_DT, @ERP_GISU_SQ , @BQ_SQ OUTPUT       
    
    
 INSERT INTO ABDOCU_B      
 (       
    CO_CD   , GISU_DT   , GISU_SQ   , BG_SQ    
  , ABGT_CD  , SET_FG   , VAT_FG   , TR_FG    
  , DIV_CD2  , INSERT_ID   , INSERT_IP   , INSERT_DT    
  , RMK_DC  , IT_USE_WAY  , RMK_DCK    
   )       
 VALUES (      
    @ERP_CO_CD , @ERP_GISU_DT  , @ERP_GISU_SQ  , @BQ_SQ    
  , @BGT_CD  , @SET_FG   , @VAT_FG   , @TR_FG    
  , @DIV_CD2  , @ERP_EMP_CD  , ''    , GETDATE()    
  , @RMK_DC  , @IT_USE_WAY  , @RMK_DC    
 )      
       
 END    
     
     
         
 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
    IF @error_code!=0       
       BEGIN       
           IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::결의서 상세(ABDOCU_B) 신규 생성 중 오류 발생';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:성공';       
      
    COMMIT TRANSACTION;      
       
   -- SELECT @ret_val,  @RETURN_MESSAGE,   @ERP_GISU_DT  ,  @ERP_GISU_SQ, @BQ_SQ  , @BK_SQ    
   SELECT @ret_val AS ret_val
        , @RETURN_MESSAGE AS RETURN_MESSAGE
        , @ERP_GISU_DT AS ERP_GISU_DT
        , @ERP_GISU_SQ AS ERP_GISU_SQ
        , @BQ_SQ AS ERP_BQ_SQ
        , @BK_SQ AS ERP_BK_SQ      
END_PROC:                
           
   RETURN @ret_val ;        
      
      
      
      


GO


