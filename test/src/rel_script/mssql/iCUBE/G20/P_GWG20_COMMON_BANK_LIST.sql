USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BANK_LIST]    Script Date: 11/28/2016 11:38:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_BANK_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_BANK_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BANK_LIST]    Script Date: 11/28/2016 11:38:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
        
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_BANK_LIST]          
   @CO_CD NVARCHAR(4)        
 , @BANK_CD  NVARCHAR(10) = NULL        
 , @BANK_NM  NVARCHAR(60) = NULL        
 , @LANGKIND NVARCHAR(10) = 'KR'    
 , @RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT                   
AS                    
/*                                                    
   ��   �� :  ������� ����� ����.                         
   ȯ   �� :                           
   ���� ��ü :                            
   �ۼ���/�ۼ��� : 2010.04. , hskim      
   ���ϰ� : ����/����                      
   �۾�����                                              
   ������ :                           
   �������� :                        
                          
                          
EXEC dbo.P_GWG20_COMMON_BANK_LIST @CO_CD='2000'        
--================================                          
*/                            
                    
 -- ���� �⺻ ����                          
 SET NOCOUNT ON;                            
 IF @@LOCK_TIMEOUT < 500                           
  SET LOCK_TIMEOUT  500;                                                                  
 SET DEADLOCK_PRIORITY LOW;                     
                                              
                          
 --======================================================================================================================================================                                
 DECLARE @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                                     
           ,@ret_val      int              -- ��� ���ϰ�                                                    
           ,@error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                           
           ,@row_cnt      int                                 
                          
                    
 DECLARE @diff tinyint --�� ������� ����          
                
                    
    -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                                    
    -- �����ڵ带 �������� �ʱ�ȭ                                                    
 SELECT @proc_name='P_GWG20_COMMON_BANK_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';                 
           
 SELECT A.BANK_CD, CASE WHEN @LANGKIND = 'KR' THEN A.BANK_NM ELSE CASE WHEN ISNULL(A.BANK_NMK, '') = '' THEN A.BANK_NM ELSE A.BANK_NMK END END AS BANK_NM    
 FROM SBANK A      
 WHERE ( NULLIF(@BANK_CD,'') IS NULL OR  A.BANK_CD =@BANK_CD)        
 AND ( NULLIF(@BANK_NM,'') IS NULL OR  A.BANK_NM =@BANK_NM)        
 ORDER BY A.BANK_CD      
        
 SELECT @ret_val=0,@RETURN_MESSAGE=N'0::����';                         
 END_PROC:                    
                    
 RETURN @ret_val ;            

GO


