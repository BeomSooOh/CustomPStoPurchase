USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_INFO]    Script Date: 11/28/2016 11:38:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_GISU_INFO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_GISU_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_INFO]    Script Date: 11/28/2016 11:38:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[P_GWG20_COMMON_GISU_INFO]  
(  
       @CO_CD NVARCHAR(4)    
      ,@DATE  NVARCHAR(8)
)  
   
AS  
  
BEGIN  
  SET NOCOUNT ON  
  DECLARE @GISU INT 
    
  SET @GISU = dbo.F_GWG20_COMMON_GET_GISU(@CO_CD, @DATE)

  SELECT * FROM dbo.F_GWG20_COMMON_GISU_INFO(@CO_CD, @DATE,@GISU); 
   
  SET NOCOUNT OFF  
END  

GO


