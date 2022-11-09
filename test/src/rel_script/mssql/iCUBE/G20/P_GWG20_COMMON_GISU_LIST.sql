USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_LIST]    Script Date: 11/28/2016 11:38:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_GISU_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_GISU_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_GISU_LIST]    Script Date: 11/28/2016 11:38:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_GISU_LIST]      
       @CO_CD NVARCHAR(4)        --- 회사 코드       
      ,@GISU tinyint = NULL     -- 요청 기수       
      ,@RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT               
AS                
/*                                                
   목   적 :  기수별 시작일자와 종료일자 목록을 얻음.                     
   환   경 :                       
   관련 객체 :                        
   작성일/작성자 : 2009.08. , 이정길                      
   리턴값 : 성공/실패                  
   작업순서                                          
   주의점 :                       
   수정사항                        
                      
                      
EXEC dbo.P_GWG20_COMMON_GISU_LIST @CO_CD='1000',@GISU=16      
--================================                      
*/                        
            
                
   -- 세션 기본 설정                      
   SET NOCOUNT ON;                        
   IF @@LOCK_TIMEOUT < 500                       
       SET LOCK_TIMEOUT  500;                                                              
   SET DEADLOCK_PRIORITY LOW;                 
                                          
                      
--======================================================================================================================================================                            
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                 
           ,@ret_val      int              -- 결과 리턴값                                                
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                       
           ,@row_cnt      int                             
                      
                
       DECLARE @diff tinyint --실 기수와의 차이      
            
                
    -- 리턴값은 알수 없는 에러로  초기화함.                                                
    -- 에러코드를 성공으로 초기화                                                
     SELECT @proc_name='P_GWG20_COMMON_GISU_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';             
      
       
      
      SELECT @GISU = CASE WHEN ISNUMERIC(@GISU) = 0  THEN GISU   -- 기수 정보가 숫자가 아니면, 현재 기수로 함.       
                          WHEN ISNULL(@GISU,0) > GISU THEN GISU   --현재 기수보다 위이면, 현재 기수로 초기화       
                          WHEN ISNULL(@GISU,0)<=0      THEN  1      
                          ELSE @GISU END       
            ,@diff=GISU-   CASE WHEN ISNUMERIC(@GISU) = 0  THEN GISU        
                          WHEN ISNULL(@GISU,0) > GISU THEN GISU        
                          ELSE @GISU END      
         FROM SCO WITH(NOLOCK)      
         WHERE CO_CD = @CO_CD       
      
      
      
      
    SELECT GISU,FROM_DT,TO_DT,CURRENT_YN      
       FROM (      
               --이전 기수 정보      
    SELECT @GISU -1 AS GISU      --기수 정보      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)-1,CONVERT(datetime,FR_DT)),112) AS FROM_DT       -- 기수 시작일자      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)-1,CONVERT(datetime,TO_DT)),112) AS TO_DT         -- 기수 끝일자       
                    ,'N' AS CURRENT_YN                                                                           -- 현재(요청) 기수 여부       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD  AND (@GISU -1)>0    --기수는 0 이 존재할 수 없음.       
  UNION ALL   -- 요청 기수 정보       
    SELECT @GISU AS GISU         
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1),CONVERT(datetime,FR_DT)),112) AS ORG_FR_DT      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1),CONVERT(datetime,TO_DT)),112) AS ORG_TO_DT       
                    ,'Y' AS CURRENT_YN       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD       
  UNION ALL     -- 이후 기수 정보       
    SELECT @GISU +1AS GISU         
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)+1,CONVERT(datetime,FR_DT)),112) AS ORG_FR_DT      
     ,CONVERT(nvarchar(8),DATEADD(yy, @diff*(-1)+1,CONVERT(datetime,TO_DT)),112) AS ORG_TO_DT       
                    ,'N' AS CURRENT_YN       
    FROM SCO WITH(NOLOCK)      
    WHERE CO_CD = @CO_CD       
       )A       
     ORDER BY GISU      
      
      
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::성공';                     
END_PROC:                
                
   RETURN @ret_val ;        
      
      
      
       
      

GO


