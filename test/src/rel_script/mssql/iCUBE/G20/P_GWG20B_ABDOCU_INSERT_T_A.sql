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
 @TR_CD    NVARCHAR(15),   -- �ŷ�ó�ڵ�(�ʼ�)      
 @TR_NM    NVARCHAR(40), -- �ŷ�ó��(�ʼ�)      
 @CEO_NM    NVARCHAR(20), -- ��ǥ�ڼ���      
 @UNIT_AM   NVARCHAR(100), -- �հ�ݾ�      
 @SUP_AM    NVARCHAR(100), -- ���ް���      
 @VAT_AM    NVARCHAR(100), -- �ΰ���      
 @BTR_CD    NVARCHAR(10), -- ��������ڵ�      
 @BTR_NM    NVARCHAR(40), -- ���������Ī      
 @DEPOSITOR   NVARCHAR(30), -- ������      
 @RMK_DC    NVARCHAR(40), -- ����      
 @JIRO_CD   NVARCHAR(10), -- �����ڵ�      
 @BA_NB    NVARCHAR(20), -- ���¹�ȣ      
 @CTR_CD    NVARCHAR(16), -- ī��ŷ�ó      
 @CTR_NM    NVARCHAR(40), -- ī��ŷ�ó��      
 @NDEP_AM   NVARCHAR(100), --�ʿ���ݾ�      
 @INAD_AM   NVARCHAR(100), --�ҵ�ݾ�      
 @INTX_AM   NVARCHAR(100), -- �ҵ漼��      
 @RSTX_AM   NVARCHAR(100), -- �ֹμ���      
 @WD_AM NVARCHAR(100), -- ��Ÿ������    
 @ETCRVRS_YM   NVARCHAR(06),  --�ͼӳ��      
 @ETCDUMMY1   NVARCHAR(20),  -- �ҵ汸��    
 @CTR_APPDT   NVARCHAR(10),   -- �ſ�ī�� ��������      
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
 @LN_SQ    NUMERIC(4,0)= NULL OUTPUT, -- @LN_SQ    (�ʼ� PK)      
 @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT               
     
)    
AS                
     
 IF (@ERP_BQ_SQ = N'' )      
  SET @ERP_BQ_SQ = N'0'      
      
 IF ( @WD_AM = N'' )    
  SET @WD_AM = N'0'      
       
     
 -- ���� �⺻ ����                      
 SET NOCOUNT ON;                        
 IF @@LOCK_TIMEOUT < 500                       
  SET LOCK_TIMEOUT  500;                                                              
 SET DEADLOCK_PRIORITY NORMAL;                 
                                          
 --======================================================================================================================================================                            
 DECLARE @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                                 
           ,@ret_val      int              -- ��� ���ϰ�                                                
           ,@error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                       
           ,@row_cnt      int                             
                      
 -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                                
 -- �����ڵ带 �������� �ʱ�ȭ                                                
 SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_T',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';             
 --=================================================================      
 -- ���� ����      
      
 --====================================      
 --�ʼ��� �˻�       
 -- IF NULLIF(@TR_CD,'') IS NULL       
 --BEGIN       
 --  SELECT @ret_val=1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(�ŷ�ó�ڵ�)';          
 --  GOTO END_PROC;      
 --END          
 IF NULLIF(@TR_NM,'') IS NULL       
 BEGIN       
  SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(�ŷ�ó��)';          
  GOTO END_PROC;      
 END        
       
 IF EXISTS ( SELECT 1 FROM ABDOCU_B where CO_CD = @ERP_CO_CD       
    AND GISU_DT = @ERP_GISU_DT       
    AND GISU_SQ = @ERP_GISU_SQ      
    AND ISU_SQ > 0  )      
 BEGIN      
  SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�̹� ��ǥ�� ����� ���Ǽ��Դϴ�.';          
  GOTO END_PROC;      
 END      
       
 BEGIN TRANSACTION;      
 
 BEGIN    
  --���ι�ȣ ���ϱ�       
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
  
  IF @BANK_DT != ''    -- ī��/���� ����    
 BEGIN                      
  DECLARE @BK_SQ2 NUMERIC(5,0)    
      
  SET @BK_SQ2 = 1
  -- ī�� ���γ��� ������� ����     
  IF @TRAN_CD = '000' -- ����� ����
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
  SELECT @ret_val=-1,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::���Ǽ� ��(ABDOCU_B) �ű� ���� �� ���� �߻�';                     
  GOTO END_PROC;      
 END       
    
 select @ret_val = 0, @RETURN_MESSAGE = '0:����';       
        
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


