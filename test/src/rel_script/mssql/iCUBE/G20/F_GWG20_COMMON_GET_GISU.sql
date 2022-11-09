USE [DZICUBE]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GWG20_COMMON_GET_GISU]    Script Date: 12/16/2016 09:32:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[F_GWG20_COMMON_GET_GISU]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[F_GWG20_COMMON_GET_GISU]
GO

USE [DZICUBE]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GWG20_COMMON_GET_GISU]    Script Date: 12/16/2016 09:32:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
CREATE FUNCTION  [dbo].[F_GWG20_COMMON_GET_GISU](             
       @CO_CD NVARCHAR(4)    
      ,@DATE  NVARCHAR(8)    
)    
RETURNS SMALLINT    
AS    
BEGIN      
/*                                                
   목   적 :  일자가 속한 기수 정보를 돌려줌                   
   환   경 :                       
   관련 객체 :                        
   작성일/작성자 : 2009.08. , 이정길                      
   리턴값 : 기수값                  
   작업순서                                          
   주의점 :                       
   수정사항                        
                      
                      
EXEC dbo.P_GWG20_COMMON_GISU_LIST @CO_CD='1000',@GISU=16      
--================================                      
*/           
  DECLARE @FR_DT NVARCHAR(8)    
         ,@TO_DT NVARCHAR(8)    
         ,@GI_SU SMALLINT       
         ,@I SMALLINT     
    
  SELECT @GI_SU=GISU, @FR_DT=FR_DT, @TO_DT=TO_DT    
    FROM SCO WITH(NOLOCK)    
    WHERE CO_CD = @CO_CD    
    

  WHILE 0<1    
     BEGIN     
     SET @i = 0 ;    
     IF @DATE <@FR_DT     
        SET @i = -1    
     ELSE IF @DATE >@TO_DT    
    SET @i = 1    
     ELSE BREAK     -- 현재 기수내일 경우는 LOOP 종료    
               
    --기수와 기수의 시작일과 종료일 변경     
    SET @GI_SU= @GI_SU +@i     
    SELECT @FR_DT= CONVERT(NVARCHAR(8), DATEADD(yy,@i,CONVERT(DATETIME,@FR_DT)),112)    
    SELECT @TO_DT= CONVERT(NVARCHAR(8), DATEADD(yy,@i,CONVERT(DATETIME,@TO_DT)),112)    
    
    -- under/over flow 처리      
    IF (@GI_SU<1) OR (@GI_SU>19999)    
      BREAK;    
     END --WHILE     
    
   RETURN @GI_SU    
END 

GO


