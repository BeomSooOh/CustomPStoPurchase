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
  --�ʼ���      
   @ERP_CO_CD   NVARCHAR(4) --ERPȸ���ڵ�      
 , @ERP_GISU_DT  NVARCHAR(8)  --������      
 , @ERP_GISU_SQ  NVARCHAR(8)      
 , @ERP_EMP_CD  NVARCHAR(10) --ERP�۾���      
 , @BGT_CD   NVARCHAR(10) --ERP��������ڵ�      
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
   ��   �� :  ���Ǽ� �̵� (ABDOCU_B) �߰���.                 
   ȯ   �� :                       
   ���� ��ü :                        
   �ۼ���/�ۼ��� : 2010.07. , HSKIM                      
   ���ϰ� : ����/����                  
   �۾�����                                          
   ������ :         
   �������� :    2010.08. , HSKIM - ABDOCU_B.RMK_DC �÷��� �߰��ʿ� ���� ABDOCU.RMK_DC ������ ������ INSERT     
      
--================================                      
*/                        
            
                
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
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_B',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';             
      
      
 --=================================================================      
 -- ���� ����      
      
      
   --====================================      
    --�ʼ��� �˻�       
      IF NULLIF(@ERP_GISU_DT,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(������)';          
          GOTO END_PROC;      
        END        
      IF NULLIF(@ERP_GISU_SQ,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(���ǹ�ȣ)';          
          GOTO END_PROC;      
        END        
      
      IF NULLIF(@BGT_CD,'') IS NULL       
        BEGIN       
          SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(�������)';          
          GOTO END_PROC;      
        END        
           
      
 IF EXISTS ( SELECT 1 FROM ABDOCU_B where CO_CD = @ERP_CO_CD       
  AND GISU_DT = @ERP_GISU_SQ       
  AND GISU_SQ = @ERP_GISU_SQ      
  AND ISU_SQ > 0  )      
 BEGIN      
   SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�̹� ��ǥ�� ����� ���Ǽ��Դϴ�.';          
   GOTO END_PROC;      
 END      
      
      
      
 SET TRANSACTION ISOLATION LEVEL SERIALIZABLE      
 BEGIN TRANSACTION;      
       
     
IF @BANK_DT != ''    -- ī��/���� ����    
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
      
   --���Ǽ��� ���ϱ�        
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
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::���Ǽ� ��(ABDOCU_B) �ű� ���� �� ���� �߻�';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:����';       
      
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


