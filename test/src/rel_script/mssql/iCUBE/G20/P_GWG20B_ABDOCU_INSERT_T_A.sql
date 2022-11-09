USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_T_A]    Script Date: 11/28/2016 11:39:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_T_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_T_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_T_A]    Script Date: 11/28/2016 11:39:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_T_A]      
(    
 @ABDOCU_NO NVARCHAR(20) = '',
 @ERP_CO_CD   NVARCHAR(4),      
 @ERP_EMP_CD   NVARCHAR(10),      
 @ERP_GISU_DT  NVARCHAR(8),      
 @ERP_GISU_SQ  NVARCHAR(10),      
 @ERP_BQ_SQ      NVARCHAR(10),      
 @TR_CD    NVARCHAR(15),   -- 거래처코드(필수)      
 @TR_NM    NVARCHAR(40), -- 거래처명(필수)      
 @CEO_NM    NVARCHAR(20), -- 대표자성명      
 @UNIT_AM   NVARCHAR(100), -- 합계금액      
 @SUP_AM    NVARCHAR(100), -- 공급가액      
 @VAT_AM    NVARCHAR(100), -- 부가세      
 @BTR_CD    NVARCHAR(10), -- 금융기관코드      
 @BTR_NM    NVARCHAR(40), -- 금융기관명칭      
 @DEPOSITOR   NVARCHAR(30), -- 예금주      
 @RMK_DC    NVARCHAR(40), -- 적요      
 @JIRO_CD   NVARCHAR(10), -- 은행코드      
 @BA_NB    NVARCHAR(20), -- 계좌번호      
 @CTR_CD    NVARCHAR(16), -- 카드거래처      
 @CTR_NM    NVARCHAR(40), -- 카드거래처명      
 @NDEP_AM   NVARCHAR(100), --필요경비금액      
 @INAD_AM   NVARCHAR(100), --소득금액      
 @INTX_AM   NVARCHAR(100), -- 소득세액      
 @RSTX_AM   NVARCHAR(100), -- 주민세액      
 @WD_AM NVARCHAR(100), -- 기타공제액    
 @ETCRVRS_YM   NVARCHAR(06),  --귀속년월      
 @ETCDUMMY1   NVARCHAR(20),  -- 소득구분    
 @CTR_APPDT   NVARCHAR(10),   -- 신용카드 적용일자      
 @TAX_DT   NVARCHAR(16),    
 @BANK_DT NVARCHAR(8),     
 @BANK_SQ NUMERIC(5,0),    
 @ISS_SQ  NUMERIC(5,0),    
 @BK_SQ NUMERIC(5,0),    
 @TRAN_CD NVARCHAR(3),    
 @IT_USE_DT NVARCHAR(8),    
 @IT_USE_NO NVARCHAR(11),    
 @IT_CARD_NO NVARCHAR(16),      
 @ET_YN NVARCHAR(1),    
 @LN_SQ    NUMERIC(4,0)= NULL OUTPUT, -- @LN_SQ    (필수 PK)      
 @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT               
     
)    
AS                
     
 IF (@ERP_BQ_SQ = N'' )      
  SET @ERP_BQ_SQ = N'0'      
      
 IF ( @WD_AM = N'' )    
  SET @WD_AM = N'0'      
       
     
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
 SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_T',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';             
 --=================================================================      
 -- 변수 선언      
      
 --====================================      
 --필수값 검사       
 -- IF NULLIF(@TR_CD,'') IS NULL       
 --BEGIN       
 --  SELECT @ret_val=1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(거래처코드)';          
 --  GOTO END_PROC;      
 --END          
 IF NULLIF(@TR_NM,'') IS NULL       
 BEGIN       
  SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':매개변수이상(거래처명)';          
  GOTO END_PROC;      
 END        
       
 IF EXISTS ( SELECT 1 FROM ABDOCU_B where CO_CD = @ERP_CO_CD       
    AND GISU_DT = @ERP_GISU_DT       
    AND GISU_SQ = @ERP_GISU_SQ      
    AND ISU_SQ > 0  )      
 BEGIN      
  SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':이미 전표가 발행된 결의서입니다.';          
  GOTO END_PROC;      
 END      
       
 BEGIN TRANSACTION;      
 
 BEGIN    
  --라인번호 구하기       
  IF( ISNULL(@LN_SQ,0) = 0)      
  BEGIN      
   SELECT @LN_SQ = ISNULL(  MAX(LN_SQ ), 0 )+1       
   FROM ABDOCU_T      
   WHERE CO_CD = @ERP_CO_CD AND ISU_DT = @ERP_GISU_DT AND ISU_SQ= @ERP_GISU_SQ      
   AND BG_SQ= @ERP_BQ_SQ      
  END      
      
  DECLARE @TR_FG   NVARCHAR(2)    
  DECLARE @ETCDIV_CD  NVARCHAR(4)    
  DECLARE @ETCDATA_CD  NVARCHAR(2)    
  DECLARE @ETCRATE  NUMERIC    
      
  SELECT @TR_FG = TR_FG    
  FROM ABDOCU_B    
  WHERE CO_CD = @ERP_CO_CD    
  AND GISU_DT = @ERP_GISU_DT    
  AND GISU_SQ = @ERP_GISU_SQ    
  AND BG_SQ = @ERP_BQ_SQ    
      
      
  IF (@TR_FG = '4')    
  BEGIN    
   SELECT @ETCDIV_CD = DIV_CD    
   FROM ABDOCU    
   WHERE CO_CD = @ERP_CO_CD    
   AND GISU_DT = @ERP_GISU_DT    
   AND GISU_SQ = @ERP_GISU_SQ    
       
   SET @ET_YN = '1'    
       
   SELECT @ETCDATA_CD = DATA_CD    
   FROM HEARNER    
   WHERE CO_CD = @ERP_CO_CD    
   AND PER_CD = @TR_CD    
   AND DATA_CD IN ('G', 'BI')    
       
   IF (CONVERT(NUMERIC, @NDEP_AM) + CONVERT(NUMERIC, @INAD_AM) > 50000)    
   BEGIN    
    SET @ETCRATE = CONVERT(NUMERIC, (CONVERT(NUMERIC, @NDEP_AM) / (CONVERT(NUMERIC, @NDEP_AM) + CONVERT(NUMERIC, @INAD_AM))) * 100)    
   END    
   ELSE    
   BEGIN    
    SET @ETCRATE = 0    
   END    
  END    
        
  INSERT INTO ABDOCU_T      
  (    
     CO_CD   , ISU_DT   , ISU_SQ   , BG_SQ    , LN_SQ   , TR_CD    
   , TR_NM   , CEO_NM   , UNIT_AM   , SUP_AM   , VAT_AM  , BTR_CD    
   , BTR_NM  , BA_NB    , DEPOSITOR   , RMK_DC   , JIRO_CD  , INSERT_ID    
   , INSERT_IP  , INSERT_DT   , CTR_CD   , CTR_NM   , ETCRVRS_YM , ETCDUMMY1, ETCDUMMY2   
   , NDEP_AM  , INAD_AM   , INTX_AM   , RSTX_AM   , TAX_DT      
   , ETCDIV_CD  , ET_YN    , ETCDATA_CD  , ETCRATE   , IT_USE_DT  , IT_USE_NO  , IT_CARD_NO  , WD_AM    
   , TR_NMK  , CEO_NMK   , RMK_DCK   , BTR_NMK   , CTR_NMK    
  )      
  VALUES       
  (    
     @ERP_CO_CD , @ERP_GISU_DT  , @ERP_GISU_SQ  , @ERP_BQ_SQ  , @LN_SQ  , @TR_CD     
   , @TR_NM  , @CEO_NM   , @UNIT_AM   , @SUP_AM   , @VAT_AM  , @BTR_CD    
   , @BTR_NM  , @BA_NB   , @DEPOSITOR  , @RMK_DC   , @JIRO_CD  , @ERP_EMP_CD    
   ,''    , GETDATE()   , @CTR_CD   , @CTR_NM   , @ETCRVRS_YM , @ETCDUMMY1, SUBSTRING(@ETCRVRS_YM,1, 4)    
   , @NDEP_AM  , @INAD_AM   , @INTX_AM   , @RSTX_AM   , @TAX_DT    
   , @ETCDIV_CD , @ET_YN   , @ETCDATA_CD  , @ETCRATE   , @IT_USE_DT , @IT_USE_NO  , @IT_CARD_NO  , @WD_AM    
   , @TR_NM  , @CEO_NM   , @RMK_DC   , @BTR_NM   , @CTR_NM    
  )  
  
  IF @BANK_DT != ''    -- 카드/계좌 연동    
 BEGIN                      
  DECLARE @BK_SQ2 NUMERIC(5,0)    
      
  SET @BK_SQ2 = 1
  -- 카드 승인내역 진행상태 변경     
  IF @TRAN_CD = '000' -- 입출금 계좌
	UPDATE DBO.SACBANKH SET GW_STATE = '1', GW_ID = @ABDOCU_NO WHERE CO_CD = @ERP_CO_CD AND BANK_DT = @BANK_DT AND BANK_SQ = @BANK_SQ
  ELSE IF @TRAN_CD = '301'
    UPDATE DBO.ACARD_SUNGIN SET GW_STATE = '1', GW_ID = @ABDOCU_NO, GISU_DT= @ERP_GISU_DT, GISU_SQ= @ERP_GISU_SQ  WHERE CO_CD = @ERP_CO_CD AND ISS_DT = @BANK_DT AND ISS_SQ = @BANK_SQ
             
   PRINT ('UPDATE GW_STATE : ' + @BANK_DT + ',' + CAST(@ISS_SQ AS VARCHAR))    
  END    
 END           
        
 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
 IF @error_code!=0       
 BEGIN       
  IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
  SELECT @ret_val=-1,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::결의서 상세(ABDOCU_B) 신규 생성 중 오류 발생';                     
  GOTO END_PROC;      
 END       
    
 select @ret_val = 0, @RETURN_MESSAGE = '0:성공';       
        
    COMMIT TRANSACTION;      
       
 -- SELECT @ret_val,  @RETURN_MESSAGE,   @ERP_GISU_DT  ,  @ERP_GISU_SQ, @ERP_BQ_SQ, @LN_SQ, @BK_SQ2      
  SELECT @ret_val AS ret_val
      , @RETURN_MESSAGE AS RETURN_MESSAGE
      , @ERP_GISU_DT AS ERP_GISU_DT
      , @ERP_GISU_SQ AS ERP_GISU_SQ
      , @ERP_BQ_SQ AS ERP_BQ_SQ
      , @LN_SQ AS ERP_LN_SQ
      , @BK_SQ2 AS ERP_BK_SQ          
 END_PROC:                
           
   RETURN @ret_val ;       
   

GO


