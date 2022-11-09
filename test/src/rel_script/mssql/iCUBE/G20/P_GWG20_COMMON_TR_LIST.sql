USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_TR_LIST]    Script Date: 11/28/2016 11:38:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_TR_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_TR_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_TR_LIST]    Script Date: 11/28/2016 11:38:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_TR_LIST]      
   @CO_CD NVARCHAR(4)    
 , @TR_CD  NVARCHAR(10)= NULL    
 , @TR_NM  NVARCHAR(60)= NULL    
 , @TYPE NVARCHAR(1)='1'  -- 1. �Ϲ� �ŷ�ó, 2:�����ŷ�ó �׷�    
 , @DETAIL_TYPE  NVARCHAR(1)= NULL    
 , @LANGKIND NVARCHAR(10) = 'KR'    
 , @RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT               
AS                
/*                                                
   ��   �� :  �ŷ�ó ����� ����.                     
   ȯ   �� :                       
   ���� ��ü :                        
   �ۼ���/�ۼ��� : 2009.10. , ������                      
   ���ϰ� : ����/����                  
   �۾�����                                          
   ������ :                       
   �������� : 2009.11. , HSKIM �ŷ�ó ���� ��       
        2010.03. , HSKIM ����� �� �ŷ�ó ��ȭ��ȣ �߰�                      
                      
                      
EXEC dbo.P_GWG20_COMMON_TR_LIST @CO_CD='2000'    
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
     SELECT @proc_name='P_GWG20_COMMON_TR_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';             
      
       
    
    
    
 SELECT A.CO_CD,  -- 0.ȸ�� �ڵ�    
   A.TR_CD,  -- 1.�ŷ�ó �ڵ�    
   CASE WHEN @LANGKIND = 'KR' THEN A.TR_NM ELSE CASE WHEN ISNULL(A.TR_NMK, '') = '' THEN A.TR_NM ELSE A.TR_NMK END END AS TR_NM,  -- 2.�ŷ�ó ��    
   A.TR_FG,  -- 3.�ŷ����� ( 1:�Ϲ�,����,�ֹ�,��Ÿ, �������,���⿹��,��������,ī���, �ſ�ī��    
            CASE WHEN A.TR_FG ='1' THEN N'�Ϲ�'    
                 WHEN A.TR_FG ='2' THEN N'����'    
                 WHEN A.TR_FG ='3' THEN N'�ֹ�'    
                 WHEN A.TR_FG ='4' THEN N'��Ÿ'    
                 WHEN A.TR_FG ='5' THEN N'�������'    
                 WHEN A.TR_FG ='6' THEN N'���⿹��'    
                 WHEN A.TR_FG ='7' THEN N'��������'    
                 WHEN A.TR_FG ='8' THEN N'ī���'    
                 WHEN A.TR_FG ='9' THEN N'�ſ�ī��'    
              ELSE ''    
              END AS TR_FG_NM,    
    CASE WHEN @LANGKIND = 'KR' THEN A.ATTR_NM ELSE CASE WHEN ISNULL(A.ATTR_NMK, '') = '' THEN A.ATTR_NM ELSE A.ATTR_NMK END END AS ATTR_NM, -- 4.�ŷ�ó ��Ī    
            A.REG_NB,     -- 5.����ڵ�Ϲ�ȣ    
   A.PPL_NB,     -- 6.�ֹε�Ϲ�ȣ    
   A.DEPOSITOR, -- 5.������    
   CASE WHEN @LANGKIND = 'KR' THEN A.CEO_NM ELSE CASE WHEN ISNULL(A.CEO_NMK, '') = '' THEN A.CEO_NM ELSE A.CEO_NMK END END AS CEO_NM,  -- 6.��ǥ�ڼ���    
   A.JIRO_CD,  -- 7.�����ڵ�    
   CASE WHEN @LANGKIND = 'KR' THEN C.BANK_NM ELSE CASE WHEN ISNULL(C.BANK_NMK, '') = '' THEN C.BANK_NM ELSE C.BANK_NMK END END AS JIRO_NM,  -- 8.�����    
   A.BA_NB,   -- 9.���¹�ȣ    
   ISNULL(A.DIV_ADDR1, '') + ' ' + ISNULL(A.ADDR2, '') As ADDR,    
   D.TRCHARGE_EMP,    
   A.TEL    
   FROM STRADE A WITH(NOLOCK) INNER JOIN     
            (   SELECT '1' AS TR_FG    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    --�Ϲݰŷ�ó(1,2,3,4)    
              UNION ALL    
                  SELECT '2'    
   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    
              UNION ALL    
                  SELECT '3'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1                UNION ALL    
                  SELECT '4'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    
              UNION ALL    
                  SELECT '5'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2 --�����ŷ�ó(5,6,7,8,9)    
              UNION ALL    
                  SELECT '6'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '7'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '8'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '9'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
             ) B    
              ON(A.TR_FG=B.TR_FG)    
   LEFT OUTER JOIN SBANK C ON ( A.JIRO_CD = C.BANK_CD)    
   LEFT OUTER JOIN ( SELECT  CO_CD, TR_CD, TRCHARGE_EMP, TRCHARGE_TEL FROM STRADE_REC WHERE REC_SQ ='1') D  ON (A.CO_CD = D.CO_CD AND A.TR_CD = D.TR_CD)    
  WHERE A.CO_CD=@CO_CD     
            AND ( NULLIF(@TR_CD,'') IS NULL OR  A.TR_CD =@TR_CD)    
            AND ( NULLIF(@TR_NM,'') IS NULL OR  A.TR_NM LIKE '%' +@TR_NM + '%')    
            AND ( NULLIF(@DETAIL_TYPE,'') IS NULL OR A.TR_FG=@DETAIL_TYPE)    
            AND A.USE_YN = 1    
     --ORDER BY TR_CD    
    
    
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::����';                     
END_PROC:                
                
   RETURN @ret_val ;        
      
    
    
    
    


GO


