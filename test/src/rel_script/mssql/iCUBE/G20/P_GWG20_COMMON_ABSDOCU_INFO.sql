USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    Script Date: 11/28/2016 11:38:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_ABSDOCU_INFO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    Script Date: 11/28/2016 11:38:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    
   @CO_CD   NVARCHAR(4)      --ȸ���ڵ�    
       , @RETURN_MESSAGE NVARCHAR(1024)  = NULL OUTPUT             
AS    
    
/*                                              
   ��   �� :  ȸ�纰 ���Ǽ� ȯ�漳�� (��Ÿ�ҵ��� ���ý� ������ ���� ��)     
   ȯ   �� :                     
   ���� ��ü :                      
   �ۼ���/�ۼ��� : 2010.01. , HSKIM                    
   ���ϰ� : ����/����                
   �۾�����                                        
   ������ :                     
   ��������               
                    
EXEC dbo.P_GWG20_COMMON_ABSDOCU_INFO @CO_CD='9998'    
--================================                    
*/                      
              
   -- ���� �⺻ ����                    
   SET NOCOUNT ON;                      
   IF @@LOCK_TIMEOUT < 500                     
       SET LOCK_TIMEOUT  500;                                                            
   SET DEADLOCK_PRIORITY NORMAL;               
                                        
                    
--======================================================================================================================================================                          
   DECLARE  @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                               
           ,@ret_val      int              -- ��� ���ϰ�                                              
           ,@error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                     
           ,@row_cnt      int                           
           ,@QUERY   NVARCHAR(4000)         
              
    -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                              
    -- �����ڵ带 �������� �ʱ�ȭ                                              
     SELECT @proc_name='P_GWG20_COMMON_ABSDOCU_INFO',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';           
    
    
      SET @QUERY = 'SELECT A.NDEP_RT --�ʿ�����    
    , A.STA_RT --��Ÿ�ҵ漼��    
    , A.JTA_RT -- �ֹμ���    
    , A.MTAX_AM -- ����������    
     FROM  ABSDOCU A INNER JOIN SCO S ON A.CO_CD = S.CO_CD AND A.ACCTDEF_FG = S.ACCT_FG    
  WHERE A.CO_CD =  ''' + @CO_CD + ''''      
     
      
  EXEC(@QUERY)    
 SET NOCOUNT OFF;          
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::����';                   
END_PROC:              
              
   RETURN @ret_val ;      
    
    
    
     
    

GO


