USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_DELETE_A]    Script Date: 11/28/2016 11:39:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_DELETE_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_DELETE_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_DELETE_A]    Script Date: 11/28/2016 11:39:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

      
        
/*************************************************************************/                              
--��    �� : ���Ǽ� ����ó��      
--�� �� �� : ��ȿ��                              
--�������� : 2010-07-                              
--�������� :       
--                                  
/*************************************************************************/                                  
      
      
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_DELETE_A]             
(      
   @ERP_CO_CD NVARCHAR(4)      
 , @ERP_DIV_CD NVARCHAR(4)      
 , @ERP_GISU_DT NVARCHAR(8)      
 , @ERP_GISU_SQ INT  = null    
 , @TRAN_CD NVARCHAR(3) = ''      
 , @ABDOCU_NO NVARCHAR(20) = ''      
 , @BANK_DT NVARCHAR(8) = ''      
 , @BANK_SQ INT = 0      
 , @DUMMY1 NVARCHAR(50) = null    
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
       
--IF ISNULL(@BANK_DT, '') != ''       
BEGIN      
 UPDATE DBO.SACBANKH SET GW_STATE = '0', GW_ID= NULL WHERE GW_STATE = '1' AND GW_ID = @ABDOCU_NO      
 UPDATE DBO.ACARD_SUNGIN SET GW_STATE = '', GW_ID= NULL , GISU_DT= NULL, GISU_SQ= NULL  WHERE GW_STATE IN ('1', '2') AND GW_ID = @ABDOCU_NO      
 DELETE FROM ABDOCU_CMS_H WHERE CO_CD = @ERP_CO_CD AND BANK_DT = @BANK_DT AND BANK_SQ = @BANK_SQ AND TRAN_CD = @TRAN_CD      
 DELETE FROM ABDOCU_CMS_B WHERE CO_CD = @ERP_CO_CD AND BANK_DT = @BANK_DT AND BANK_SQ = @BANK_SQ AND TRAN_CD = @TRAN_CD      
 DELETE FROM ABDOCU_CMS_T WHERE CO_CD = @ERP_CO_CD AND BANK_DT = @BANK_DT AND BANK_SQ = @BANK_SQ AND TRAN_CD = @TRAN_CD          
END      
    
    
--ELSE      
BEGIN    
    
 DELETE FROM ABDOCU WHERE CO_CD =@ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND  GISU_DT = @ERP_GISU_DT AND ISNULL(DUMMY2,DUMMY1) = @DUMMY1    
    
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
            
 --select  @ret_val , @RETURN_MESSAGE; 
 SELECT @ret_val AS ret_val
       , @RETURN_MESSAGE AS RETURN_MESSAGE
  



GO


