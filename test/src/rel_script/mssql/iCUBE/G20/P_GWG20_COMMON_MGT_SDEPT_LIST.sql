USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_MGT_SDEPT_LIST]    Script Date: 11/28/2016 11:38:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_MGT_SDEPT_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_MGT_SDEPT_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_MGT_SDEPT_LIST]    Script Date: 11/28/2016 11:38:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
  
/*************************************************************************/              
--설    명 : 부서별 코드리스트  
--수 정 자 : tslim              
--수정일자 : 2011-08-29              
--수정내역 :               
/*************************************************************************/              
  
-- EXEC P_GWG20_COMMON_MGT_DEPT_LIST '2000'  
  
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_MGT_SDEPT_LIST]  
(  
   @CO_CD  NVARCHAR(10)  
 , @EMP_CD  NVARCHAR(10) = ''  
 , @JOB_OPTION NVARCHAR(1) = '0' -- 0:모든부서, 1:사원의 부서  
 , @LANGKIND  NVARCHAR(10) = 'KR'  
)  
   
AS  
  
IF (@JOB_OPTION = '0')  
BEGIN  
 SELECT  
    DEPT_CD  
  , CASE WHEN @LANGKIND = 'KR' THEN DEPT_NM ELSE CASE WHEN ISNULL(DEPT_NMK, '') = '' THEN DEPT_NM ELSE DEPT_NMK END END AS DEPT_NM  
  , DEPT_NMK  
    FROM SDEPT  
    WHERE CO_CD = @CO_CD
    --AND TO_DT >= SUBSTRING(replace(convert(varchar,getdate(),120),'-',''),1, 8) 
    AND (NULLIF(TO_DT,'') IS NULL OR TO_DT = '00000000' OR TO_DT >= SUBSTRING(replace(convert(varchar,getdate(),120),'-',''),1, 8) )   
END  
ELSE IF (@JOB_OPTION = '1')  
BEGIN  
 SELECT  
    A.DEPT_CD  
  , CASE WHEN @LANGKIND = 'KR' THEN DEPT_NM ELSE CASE WHEN ISNULL(DEPT_NMK, '') = '' THEN DEPT_NM ELSE DEPT_NMK END END AS DEPT_NM  
  , A.DEPT_NMK  
    FROM SDEPT A WITH(NOLOCK)  
    INNER JOIN SEMP B WITH(NOLOCK) ON (A.CO_CD = B.CO_CD AND A.DEPT_CD = B.DEPT_CD)  
    WHERE A.CO_CD = @CO_CD  
    AND B.EMP_CD = @EMP_CD
    --AND TO_DT >= SUBSTRING(replace(convert(varchar,getdate(),120),'-',''),1, 8) 
    AND (NULLIF(TO_DT,'') IS NULL OR TO_DT = '00000000' OR TO_DT >= SUBSTRING(replace(convert(varchar,getdate(),120),'-',''),1, 8) )         
END  
  

GO


