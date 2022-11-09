USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BCLOSE_CHECK]    Script Date: 11/28/2016 11:38:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_BCLOSE_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_BCLOSE_CHECK]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BCLOSE_CHECK]    Script Date: 11/28/2016 11:38:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[P_GWG20_COMMON_BCLOSE_CHECK]      
       @CO_CD NVARCHAR(4)        -- 회사 코드       
      ,@DIV_CD     NVARCHAR(4)  -- 회계단위 (필수 PK
      ,@DATE  NVARCHAR(8)        -- 결의일
AS        
BEGIN 
DECLARE @GISU INT 

SET @GISU = dbo.F_GWG20_COMMON_GET_GISU(@CO_CD, @DATE)
     
SELECT *    
  FROM BCLOSE    
  WHERE CO_CD = @CO_CD    
  AND GISU = @GISU
  AND DIV_CD = @DIV_CD
  AND CLOSE_CD = '1'
END  

GO


