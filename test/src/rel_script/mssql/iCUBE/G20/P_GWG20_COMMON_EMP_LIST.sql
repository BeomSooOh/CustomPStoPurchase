USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_EMP_LIST]    Script Date: 11/28/2016 11:38:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_EMP_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_EMP_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_EMP_LIST]    Script Date: 11/28/2016 11:38:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_EMP_LIST]    
   @CO_CD   NVARCHAR(4)                --ȸ�� �ڵ�         
 , @DIV_CD   NVARCHAR(4) = NULL         --����� �ڵ�     
 , @DEPT_CD   NVARCHAR(4) = NULL         -- �μ� �ڵ�       
 , @EMP_CD   NVARCHAR(10) = NULL        -- ����ڵ�    
 , @EMP_NM   NVARCHAR(20) = NULL        -- ����� (���� ����)    
 , @BASE_DT   NVARCHAR(8) = '19000101'   -- ��� ���� ����     
 , @LANGKIND   NVARCHAR(10) = 'KR'   
 , @TO_DT      NVARCHAR(8) = NULL
 , @RETURN_MESSAGE NVARCHAR(1024)  = NULL OUTPUT             
AS    
    
/*                                              
   ��   �� :  ������ ������ ����.       
   ȯ   �� :                     
   ���� ��ü :                      
   �ۼ���/�ۼ��� : 2009.08. , ������                    
   ���ϰ� : ����/����                
   �۾�����                                        
   ������ :                     
   ��������                      
                    
                    
EXEC dbo.P_GWG20_COMMON_EMP_LIST  @CO_CD = '1000'--,@DIV_CD='1000'--,@EMP_NM=N'Baik'--,@DEPT_CD ='1300'    
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
                    
    
 -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                              
 -- �����ڵ带 �������� �ʱ�ȭ                                              
 SELECT @proc_name='P_GWG20_COMMON_EMP_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';           
    
    
 DECLARE @nSubUseYN NVARCHAR(1)    
     
 SELECT @nSubUseYN = use_yn FROM SYSCFG WHERE CO_CD = @CO_CD and MODULE_CD = '4' and CTR_CD = '16'    
    
    
 IF ISDATE(@BASE_DT) = 0     
  SET @BASE_DT ='19000101'    
    
    
 IF (@nSubUseYN IS NOT NULL AND @nSubUseYN = '1')    
 BEGIN    
  SELECT     
     EMP_CD    
   , KOR_NM
   , ENLS_NM    
   , DEPT_CD    
   , DEPT_NM  
   , DIV_CD    
   , DIV_NM
   , BANK_CD    
   , BANK_NM
   , ACCT_NO    
   , DPST_NM   
   , PRTT_CD
   , HTYP_CD 
   , CASE WHEN @nSubUseYN = '1' THEN USE_FG ELSE 1 END AS USE_FG
   , CO_CD 
   , CO_NM   
  FROM (    
   SELECT E.PRTY_CD AS PRTT_CD, E.HTYP_CD, E.EMP_CD, E.KOR_NM, E.KOR_NMK, E.ENLS_NM, D.DEPT_CD, D.DEPT_NM, D.DEPT_NMK, V.DIV_CD, V.DIV_NM, V.DIV_NMK, B.BANK_CD, B.BANK_NM, B.BANK_NMK, E.ACCT_NO, E.DPST_NM    
   ,ISNULL(NULLIF(E.RTR_DT,''),'99991231') AS RTR_DT   --�����(���� ���� ���,��ȸ�� ���ؼ� �߻��� �� ���� ���ڷ� ����)    
   , E.USE_FG , E.CO_CD, C.CO_NM         
   FROM SEMP E WITH(NOLOCK)    
   LEFT OUTER JOIN SDEPT D WITH(NOLOCK) ON (D.CO_CD = E.CO_CD AND D.DEPT_CD = E.DEPT_CD)    
   LEFT OUTER JOIN SDIV V WITH(NOLOCK) ON (D.CO_CD = V.CO_CD AND D.DIV_CD = V.DIV_CD)    
   LEFT OUTER JOIN SBANK B WITH(NOLOCK) ON (E.PYTB_CD = B.BANK_CD)    
   LEFT OUTER JOIN SCO C WITH(NOLOCK) ON (C.CO_CD = E.CO_CD)    
   WHERE E.CO_CD =  @CO_CD AND E.EMPL_FG <> '002' AND E.ENRL_FG <> 'J05'-- AND E.USR_YN = '1'    
   AND (NULLIF(@DIV_CD,'') IS NULL OR V.DIV_CD=@DIV_CD)    
   AND (NULLIF(@DEPT_CD,'') IS NULL OR D.DEPT_CD=@DEPT_CD)    
   AND (NULLIF(@EMP_CD,'') IS NULL OR E.EMP_CD = @EMP_CD)
   AND (NULLIF(D.TO_DT,'') IS NULL OR D.TO_DT = '00000000' OR D.TO_DT >= ISNULL(@TO_DT,''))    
  ) A    
  WHERE RTR_DT >=@BASE_DT AND (NULLIF(@EMP_NM,'') IS NULL OR KOR_NM LIKE '%'+@EMP_NM +'%'  OR ENLS_NM LIKE '%'+@EMP_NM +'%' )      
  ORDER BY EMP_CD    
 END    
 ELSE    
 BEGIN    
  SELECT     
     EMP_CD    
   , KOR_NM
   , ENLS_NM    
   , DEPT_CD    
   , DEPT_NM  
   , DIV_CD    
   , DIV_NM
   , BANK_CD    
   , BANK_NM
   , ACCT_NO    
   , DPST_NM 
   , PRTT_CD
   , HTYP_CD  
   , CASE WHEN @nSubUseYN = '1' THEN USE_FG ELSE 1 END AS USE_FG 
   , CO_CD   
  FROM (    
   SELECT E.PRTY_CD AS PRTT_CD, E.HTYP_CD, E.EMP_CD, E.KOR_NM, E.KOR_NMK, E.ENLS_NM, D.DEPT_CD, D.DEPT_NM, D.DEPT_NMK, V.DIV_CD, V.DIV_NM, V.DIV_NMK, B.BANK_CD, B.BANK_NM, B.BANK_NMK, E.ACCT_NO, E.DPST_NM    
   ,ISNULL(NULLIF(E.RTR_DT,''),'99991231') AS RTR_DT   --�����(���� ���� ���,��ȸ�� ���ؼ� �߻��� �� ���� ���ڷ� ����)    
   , E.USE_FG, E.CO_CD     
   FROM SEMP E WITH(NOLOCK)    
   LEFT OUTER JOIN SDEPT D WITH(NOLOCK) ON (D.CO_CD = E.CO_CD AND D.DEPT_CD = E.DEPT_CD )    
   LEFT OUTER JOIN SDIV V WITH(NOLOCK) ON (D.CO_CD = V.CO_CD AND D.DIV_CD = V.DIV_CD)    
   LEFT OUTER JOIN SBANK B WITH(NOLOCK) ON (E.PYTB_CD = B.BANK_CD)    
   WHERE E.CO_CD =  @CO_CD AND E.EMPL_FG <> '002' AND E.ENRL_FG <> 'J05'-- AND E.USR_YN = '1'    
   AND (NULLIF(@EMP_CD,'') IS NULL OR E.EMP_CD = @EMP_CD)  
   AND (NULLIF(D.TO_DT,'') IS NULL OR D.TO_DT = '00000000' OR D.TO_DT >= ISNULL(@TO_DT,'') )    
  ) A    
  WHERE RTR_DT >=@BASE_DT AND (NULLIF(@EMP_NM,'') IS NULL OR KOR_NM LIKE '%'+@EMP_NM +'%'  OR ENLS_NM LIKE '%'+@EMP_NM +'%' )      
  ORDER BY EMP_CD    
 END    
              
              

GO


