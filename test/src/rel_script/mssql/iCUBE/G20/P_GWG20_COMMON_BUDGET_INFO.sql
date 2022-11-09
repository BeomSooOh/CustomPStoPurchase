USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BUDGET_INFO]    Script Date: 11/28/2016 11:38:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_BUDGET_INFO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_BUDGET_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BUDGET_INFO]    Script Date: 11/28/2016 11:38:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
/*************************************************************************/        
-- 설    명 : 자산관리 - 예산조회        
-- 수 정 자 : 이혜영        
-- 수정일자 : 2013/04/03        
-- 수정내역 : P_GWG20_COMMON_LEFT_AMT 에서 F_GWG20_COMMON_LEFT_AMT_BY_GISU_DT   =>  F_GWG20_COMMON_LEFT_AMT_BY_GISU_DT_NP 변
-- exec P_GWG20_COMMON_LEFT_AMT_NP @CO_CD=N'2000',@DIV_CD=N'1000',@BGT_CD=N'100090202',@MGT_CD=N'2101',@GISU_DT=N'20100823', @SUM_CT_AM = 0        
                
/*************************************************************************/        
        
        
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_BUDGET_INFO]        
(        
   @CO_CD      NVARCHAR(4)  -- 회사코드 (필수 PK)        
    , @DIV_CD     NVARCHAR(4)  -- 회계단위 (필수 PK)            
    , @BGT_CD     NVARCHAR(10) -- 예산과목         
    , @MGT_CD     NVARCHAR(10) -- 예산통제방법에 따른 부서코드 또는 프로젝트코드             
    , @GISU_DT NVARCHAR(16)     
    , @SUM_CT_AM NUMERIC(21,4) -- 금회 요청금액        
    , @BOTTOM_CD NVARCHAR(10)    
    , @LANGKIND  NVARCHAR(10) = 'KR'    
        
)         
         
        
         
AS        
BEGIN        
  SET NOCOUNT ON            
      
  --SELECT * FROM F_GWG20_COMMON_LEFT_AMT_BY_GISU_DT_NP (@CO_CD,@DIV_CD,@MGT_CD,@BGT_CD,@GISU_DT, @SUM_CT_AM, @BOTTOM_CD, @LANGKIND)     
  SELECT * FROM F_GWG20_COMMON_BY_BUDGET_INFO (@CO_CD,@DIV_CD,@MGT_CD,@BGT_CD,@GISU_DT, @SUM_CT_AM, @BOTTOM_CD, @LANGKIND)     
      
                 
  SET NOCOUNT OFF        
      
         
      
END 


GO


