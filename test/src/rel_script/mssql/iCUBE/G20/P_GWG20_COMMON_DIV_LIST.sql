USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_DIV_LIST]    Script Date: 11/28/2016 11:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_DIV_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_DIV_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_DIV_LIST]    Script Date: 11/28/2016 11:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_DIV_LIST]    
   @CO_CD   NVARCHAR(4)    --ȸ���ڵ�    
 , @BASE_DT   NVARCHAR(8) = NULL  --��ȸ ��������(���Ⱓ �̿��� ���ؼ�)    
 , @LANGKIND   NVARCHAR(10) = ''    
 , @RETURN_MESSAGE NVARCHAR(1024) = NULL OUTPUT             
AS    
    
/*                                              
   ��   �� :  ȸ�纰 ȸ�����(�����) ����� ����.               
   ȯ   �� :                     
   ���� ��ü :                      
   �ۼ���/�ۼ��� : 2010.01. , HSKIM                    
   ���ϰ� : ����/����                
   �۾�����                                        
   ������ :                     
   ��������                      
                    
                    
EXEC dbo.P_GWG20_COMMON_DIV_LIST @CO_CD='2000', @DIV_CD='',@BASE_DT='20100101'    
--================================                    
*/                      
          
-- ���� �⺻ ����                    
SET NOCOUNT ON;                      
IF @@LOCK_TIMEOUT < 500                     
SET LOCK_TIMEOUT  500;                                                            
SET DEADLOCK_PRIORITY NORMAL;               
    
--======================================================================================================================================================                          
DECLARE   @proc_name VARCHAR(60)  -- ���� ���ν��� �̸�                                               
  , @ret_val  INT    -- ��� ���ϰ�                                              
  , @error_code INT    -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                     
  , @row_cnt  INT                           
  , @QUERY  NVARCHAR(4000)         
    
-- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                              
-- �����ڵ带 �������� �ʱ�ȭ                                              
SELECT @proc_name='P_GWG20_COMMON_DIV_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';           
    
SET @QUERY = 'SELECT DIV_CD, CASE WHEN ''' + UPPER(@LANGKIND) + ''' = ''KR'' THEN DIV_NM ELSE CASE WHEN ISNULL(DIV_NMK, '''') = '''' THEN DIV_NM ELSE DIV_NMK END END AS DIV_NM, DIV_NMK FROM SDIV WHERE CO_CD = ''' + @CO_CD + ''''      
    
IF ISNULL(@BASE_DT, '') <> ''    
BEGIN    
 SET @QUERY = @QUERY + ' AND (CASE WHEN CLOSE_DT = ''00000000'' OR CLOSE_DT = '''' THEN ''99999999'' ELSE ISNULL(CLOSE_DT, ''99999999'') END) >= ''' + @BASE_DT + ''''    
END    
    
EXEC(@QUERY)    
    
SET NOCOUNT OFF;          
    
SELECT @ret_val=0,@RETURN_MESSAGE=N'0::����';                   
    
END_PROC:              
    
RETURN @ret_val ;      


GO


