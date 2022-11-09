USE [DZICUBE]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GWG20_COMMON_GISU_INFO]    Script Date: 12/16/2016 09:33:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[F_GWG20_COMMON_GISU_INFO]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[F_GWG20_COMMON_GISU_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GWG20_COMMON_GISU_INFO]    Script Date: 12/16/2016 09:33:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 CREATE FUNCTION  [dbo].[F_GWG20_COMMON_GISU_INFO](  
       @CO_CD NVARCHAR(4)        --- 회사 코드   
      ,@DATE  NVARCHAR(8)
      ,@GI_SU SMALLINT
    )   
RETURNS  @result TABLE 
        (
             GI_SU  SMALLINT 
           , FROM_DT NVARCHAR(8)
           , TO_DT NVARCHAR(8)
        )
AS   
     BEGIN                                            
                  
--======================================================================================================================================================                        
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                             
         , @ret_val      int              -- 결과 리턴값                                            
         , @error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                   
         , @row_cnt      int  
         , @FR_DT NVARCHAR(8)    
         , @TO_DT NVARCHAR(8)    
         , @GI_SU_N SMALLINT    
         , @I SMALLINT                             
                   
   DECLARE @diff SMALLINT --실 기수와의 차이  
                 
    -- 리턴값은 알수 없는 에러로  초기화함.                                            
    -- 에러코드를 성공으로 초기화                                            


   SELECT @GI_SU_N=GISU, @FR_DT=FR_DT, @TO_DT=TO_DT    
     FROM SCO WITH(NOLOCK)    
    WHERE CO_CD = @CO_CD  
  
   SET @diff = @GI_SU - @GI_SU_N
  
   INSERT INTO @result
   SELECT @GI_SU AS GISU     
        , CONVERT(NVARCHAR(8), DATEADD(yy,@diff,CONVERT(DATETIME,FR_DT)),112) AS FROM_DT
        , CONVERT(NVARCHAR(8), DATEADD(yy,@diff,CONVERT(DATETIME,TO_DT)),112) AS TO_DT
     FROM SCO WITH(NOLOCK)  
    WHERE CO_CD = @CO_CD
           
   RETURN  ; 
 END 
 

GO


