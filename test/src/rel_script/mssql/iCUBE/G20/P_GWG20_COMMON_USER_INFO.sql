USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_USER_INFO]    Script Date: 11/28/2016 11:38:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_USER_INFO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_USER_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_USER_INFO]    Script Date: 11/28/2016 11:38:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_USER_INFO]        
   @CO_CD NVARCHAR(4)         
 , @EMP_CD NVARCHAR(10)       
 , @LANGKIND NVARCHAR(10) = 'KR'    
AS        
      
SET NOCOUNT ON       
      
DECLARE @BASE_DT NVARCHAR(8)     
SET @BASE_DT = CONVERT(VARCHAR(8), GETDATE(), 112)     
      
EXEC dbo.P_GWG20_COMMON_EMP_LIST @CO_CD = @CO_CD, @DIV_CD = NULL, @DEPT_CD = NULL, @EMP_CD = @EMP_CD, @EMP_NM = NULL, @BASE_DT = @BASE_DT, @LANGKIND = @LANGKIND, @RETURN_MESSAGE = NULL    


GO


