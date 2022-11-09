USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_DIV_LIST]    Script Date: 11/28/2016 11:38:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_DIV_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_DIV_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_DIV_LIST]    Script Date: 11/28/2016 11:38:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_DIV_LIST]    
   @CO_CD   NVARCHAR(4)    --회사코드    
 , @BASE_DT   NVARCHAR(8) = NULL  --조회 기준일자(사용기간 이용을 위해서)    
 , @LANGKIND   NVARCHAR(10) = ''    
 , @RETURN_MESSAGE NVARCHAR(1024) = NULL OUTPUT             
AS    
    
/*                                              
   목   적 :  회사별 회계단위(사업장) 목록을 얻음.               
   환   경 :                     
   관련 객체 :                      
   작성일/작성자 : 2010.01. , HSKIM                    
   리턴값 : 성공/실패                
   작업순서                                        
   주의점 :                     
   수정사항                      
                    
                    
EXEC dbo.P_GWG20_COMMON_DIV_LIST @CO_CD='2000', @DIV_CD='',@BASE_DT='20100101'    
--================================                    
*/                      
          
-- 세션 기본 설정                    
SET NOCOUNT ON;                      
IF @@LOCK_TIMEOUT < 500                     
SET LOCK_TIMEOUT  500;                                                            
SET DEADLOCK_PRIORITY NORMAL;               
    
--======================================================================================================================================================                          
DECLARE   @proc_name VARCHAR(60)  -- 저장 프로시져 이름                                               
  , @ret_val  INT    -- 결과 리턴값                                              
  , @error_code INT    -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                     
  , @row_cnt  INT                           
  , @QUERY  NVARCHAR(4000)         
    
-- 리턴값은 알수 없는 에러로  초기화함.                                              
-- 에러코드를 성공으로 초기화                                              
SELECT @proc_name='P_GWG20_COMMON_DIV_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';           
    
SET @QUERY = 'SELECT DIV_CD, CASE WHEN ''' + UPPER(@LANGKIND) + ''' = ''KR'' THEN DIV_NM ELSE CASE WHEN ISNULL(DIV_NMK, '''') = '''' THEN DIV_NM ELSE DIV_NMK END END AS DIV_NM, DIV_NMK FROM SDIV WHERE CO_CD = ''' + @CO_CD + ''''      
    
IF ISNULL(@BASE_DT, '') <> ''    
BEGIN    
 SET @QUERY = @QUERY + ' AND (CASE WHEN CLOSE_DT = ''00000000'' OR CLOSE_DT = '''' THEN ''99999999'' ELSE ISNULL(CLOSE_DT, ''99999999'') END) >= ''' + @BASE_DT + ''''    
END    
    
EXEC(@QUERY)    
    
SET NOCOUNT OFF;          
    
SELECT @ret_val=0,@RETURN_MESSAGE=N'0::성공';                   
    
END_PROC:              
    
RETURN @ret_val ;      


GO


