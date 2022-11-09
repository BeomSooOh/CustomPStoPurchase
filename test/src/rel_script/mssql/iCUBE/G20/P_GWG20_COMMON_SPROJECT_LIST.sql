USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_SPROJECT_LIST]    Script Date: 11/28/2016 11:38:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_SPROJECT_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_SPROJECT_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_SPROJECT_LIST]    Script Date: 11/28/2016 11:38:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



    
      
/*************************************************************************/      
--설    명 : 프로젝트 코드 리스트      
--요 청 자 : tslim    
--수정일자 : 2011/09/14      
--수정내역 :     
/*************************************************************************/      
    
      
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_SPROJECT_LIST]      
   @CO_CD   NVARCHAR(4)     --회사코드      
 , @PJT_CD   NVARCHAR(10) = NULL   --프로젝트 코드      
 , @PJT_NM   NVARCHAR(30) = NULL   --프로젝트 명      
 , @PJT_PROC   NCHAR(1) = NULL    --프로젝트 진행 상태        
 , @PJT_WORKTY  NCHAR(1) = NULL    --프로젝트 유형      
 , @BAST_DT   NVARCHAR(8) = NULL   --기준일자       
 , @EMP_CD   NVARCHAR(10) = NULL   --권한 있는 사원 코드       
 , @LANGKIND   NVARCHAR(10) = 'KR'    
 , @RETURN_MESSAGE NVARCHAR(1024) = NULL OUTPUT               
AS      
      
SELECT    
   A.PJT_CD    
 , CASE WHEN @LANGKIND = 'KR' THEN A.PJT_NM ELSE CASE WHEN ISNULL(A.PJT_NMK, '') = '' THEN A.PJT_NM ELSE A.PJT_NMK END END AS PJT_NM    
 , A.PROG_FG    
 , A.PJT_NMK    
 , CASE WHEN A.FR_DT IN ('00000000', '99991231') THEN '' ELSE CONVERT(NVARCHAR(10), CONVERT(DATETIME, A.FR_DT), 120) END AS PJT_FR_DT    
 , CASE WHEN A.TO_DT IN ('00000000', '99991231') THEN '' ELSE CONVERT(NVARCHAR(10), CONVERT(DATETIME, A.TO_DT), 120) END AS PJT_TO_DT    
 , CASE WHEN @LANGKIND = 'KR' THEN B.DEPT_NM ELSE CASE WHEN ISNULL(B.DEPT_NMK, '') = '' THEN B.DEPT_NM ELSE B.DEPT_NMK END END AS PJT_DEPT_NM    
 , CASE WHEN @LANGKIND = 'KR' THEN C.KOR_NM ELSE CASE WHEN ISNULL(C.KOR_NMK, '') = '' THEN C.KOR_NM ELSE C.KOR_NMK END END AS PJT_KOR_NM    
 , T.ATTR_NM
 , T.BA_NB
 , (SELECT COUNT(1) FROM IT_BUSINESSLINK I WHERE I.CO_CD = @CO_CD AND A.PJT_CD = I.PJT_CD /* AND I.TRAN_TY='INS' */) AS IT_BUSINESSLINK
FROM SPJT A WITH(NOLOCK)    
LEFT OUTER JOIN SDEPT B WITH(NOLOCK) ON (B.CO_CD = @CO_CD AND A.DEPT_CD = B.DEPT_CD)    
LEFT OUTER JOIN SEMP C WITH(NOLOCK) ON (C.CO_CD = @CO_CD AND A.EMP_CD = C.EMP_CD)    
LEFT OUTER JOIN STRADE T WITH(NOLOCK) ON (T.CO_CD = @CO_CD AND A.TR_CD = T.TR_CD)    
WHERE A.CO_CD = @CO_CD    
AND ISNULL(PROG_FG, '9') <> '9'    
AND ( CASE WHEN A.PJT_AUTH ='0' THEN CASE WHEN '' + @EMP_CD + '' IN ( SELECT EMP_CD FROM SPJT_D WHERE CO_CD = A.CO_CD AND PJT_CD = A.PJT_CD ) THEN '1' ELSE '0' END ELSE '1' END ) = '1'    

GO


