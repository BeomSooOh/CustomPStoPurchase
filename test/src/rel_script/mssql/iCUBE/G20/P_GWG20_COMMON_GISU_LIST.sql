USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_LIST]    Script Date: 11/28/2016 11:38:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_GISU_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_GISU_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_LIST]    Script Date: 11/28/2016 11:38:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_GISU_LIST]      
       @CO_CD NVARCHAR(4)        --- ȸ�� �ڵ�       
      ,@GISU tinyint = NULL     -- ��û ���       
      ,@RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT               
AS                
/*                                                
   ��   �� :  ����� �������ڿ� �������� ����� ����.                     
   ȯ   �� :                       
   ���� ��ü :                        
   �ۼ���/�ۼ��� : 2009.08. , ������                      
   ���ϰ� : ����/����                  
   �۾�����                                          
   ������ :                       
   ��������                        
                      
                      
EXEC dbo.P_GWG20_COMMON_GISU_LIST @CO_CD='1000',@GISU=16      
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
     SELECT @proc_name='P_GWG20_COMMON_GISU_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';             
      
       
      
      SELECT @GISU = CASE WHEN ISNUMERIC(@GISU) = 0  THEN GISU   -- ��� ������ ���ڰ� �ƴϸ�, ���� ����� ��.       
                          WHEN ISNULL(@GISU,0) > GISU THEN GISU   --���� ������� ���̸�, ���� ����� �ʱ�ȭ       
                          WHEN ISNULL(@GISU,0)<=0      THEN  1      
                          ELSE @GISU END       
            ,@diff=GISU-   CASE WHEN ISNUMERIC(@GISU) = 0  THEN GISU        
                          WHEN ISNULL(@GISU,0) > GISU THEN GISU        
                          ELSE @GISU END      
         FROM SCO WITH(NOLOCK)      
         WHERE CO_CD = @CO_CD       
      
      
      
      
    SELECT GISU,FROM_DT,TO_DT,CURRENT_YN      
       FROM (      
               --���� ��� ����      
    SELECT @GISU -1 AS GISU      --��� ����      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)-1,CONVERT(datetime,FR_DT)),112) AS FROM_DT       -- ��� ��������      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)-1,CONVERT(datetime,TO_DT)),112) AS TO_DT         -- ��� ������       
                    ,'N' AS CURRENT_YN                                                                           -- ����(��û) ��� ����       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD  AND (@GISU -1)>0    --����� 0 �� ������ �� ����.       
  UNION ALL   -- ��û ��� ����       
    SELECT @GISU AS GISU         
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1),CONVERT(datetime,FR_DT)),112) AS ORG_FR_DT      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1),CONVERT(datetime,TO_DT)),112) AS ORG_TO_DT       
                    ,'Y' AS CURRENT_YN       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD       
  UNION ALL     -- ���� ��� ����       
    SELECT @GISU +1AS GISU         
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)+1,CONVERT(datetime,FR_DT)),112) AS ORG_FR_DT      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)+1,CONVERT(datetime,TO_DT)),112) AS ORG_TO_DT       
                    ,'N' AS CURRENT_YN       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD       
       )A       
     ORDER BY GISU      
      
      
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::����';                     
END_PROC:                
                
   RETURN @ret_val ;        
      
      
      
       
      

GO


