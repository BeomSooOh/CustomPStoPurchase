USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_ADMIT_A]    Script Date: 11/28/2016 11:39:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_ADMIT_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_ADMIT_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_ADMIT_A]    Script Date: 11/28/2016 11:39:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
      
      
/*************************************************************************/                            
--��    �� : ���Ǽ� ������� ������Ʈ    
--�� �� �� : ��ȿ��                            
--�������� : 2010-07-                            
--�������� : �׷����� �Ѿ �������� ���Ǽ� ��� �κ� ������ ���� GW_STATE: 0 -> 1                                  
--                                
/*************************************************************************/                                
        
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_ADMIT_A]               
(    
   @ERP_CO_CD NVARCHAR(4)        
 , @ERP_DIV_CD NVARCHAR(4)      
 , @ERP_EMP_CD NVARCHAR(10) = ''      
 , @ERP_GISU_DT NVARCHAR(8)        
 , @ERP_GISU_SQ INT        
 , @DOC_CD NVARCHAR(100)        
 , @BANK_DT NVARCHAR(10) = ''    
 , @TRAN_CD NVARCHAR(3) = ''    
 , @ABDOCU_NO NVARCHAR(20) = ''    
 , @RETURN_MESSAGE nvarchar(1024)= NULL OUTPUT             
)     
AS            
         
   -- ���� �⺻ ����                            
     SET NOCOUNT ON;              
   IF @@LOCK_TIMEOUT < 500                  -- ������� �ð��� 0.5�ʷ� ����                                  
       SET LOCK_TIMEOUT  500;                                                    
   SET DEADLOCK_PRIORITY LOW;               --deadlock �� ó�� �켱 ������ ���� ��                
          
                    
SET ARITHABORT ON                                                
            
        
--======================================================================================================================================================                                  
   DECLARE @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                                       
           ,@ret_val      int              -- ��� ���ϰ�                                                      
           ,@error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                             
           ,@row_cnt      int                                   
                            
                      
    -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                                      
    -- �����ڵ带 �������� �ʱ�ȭ                                                      
     SELECT @proc_name='P_GWG20_ABDOCU_ADMIN',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';                   
            
            
            
          
--SEQ ���� ������ SERIALIZABLE�� ��.             
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE            
BEGIN TRANSACTION;            
--========================================================================            
        
        
DECLARE @RMK_DC NVARCHAR(200)        
SET @RMK_DC = '';        
        
        
IF (LEN(@DOC_CD) > 0)        
 SET @RMK_DC = @DOC_CD + ' '        
        
    IF ISNULL(@BANK_DT, '') != ''    
      BEGIN    
          
  IF @TRAN_CD = '000'     
    BEGIN    
   UPDATE DBO.SACBANKH SET GW_STATE = '2' WHERE GW_ID = @ABDOCU_NO    
    END    
  ELSE IF @TRAN_CD = '301'        
    BEGIN    
   UPDATE DBO.ACARD_SUNGIN SET GW_STATE = '2' WHERE GW_ID = @ABDOCU_NO    
    END    
          
      END    
 ELSE    
   BEGIN          
        
    UPDATE ABDOCU SET GW_STATE ='1'           
   , RMK_DC =  LEFT( @RMK_DC + RMK_DC , 100)    
   , MODIFY_ID = @ERP_EMP_CD    
   , MODIFY_DT = getdate()        
   WHERE CO_CD = @ERP_CO_CD          
   AND DIV_CD =@ERP_DIV_CD          
   AND GISU_DT =@ERP_GISU_DT          
   AND GISU_SQ = @ERP_GISU_SQ          
       
   END       
          
    
    
    SELECT @error_code = @@ERROR , @row_cnt = @@rowcount           
    IF @error_code!=0           
      BEGIN           
       IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;          
       SELECT @ret_val=@error_code,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::���Ǽ� ���� �� ���� �߻�';                         
       GOTO END_PROC;                          
      END           
          
                 
         
            
            
  COMMIT TRANSACTION;          
   SELECT @ret_val=0 ,@RETURN_MESSAGE= N'0:����';          
          
END_PROC:          
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED          
  SELECT @ret_val AS ret_val
       , @RETURN_MESSAGE AS RETURN_MESSAGE      
          
  return @ret_val ; 


GO


