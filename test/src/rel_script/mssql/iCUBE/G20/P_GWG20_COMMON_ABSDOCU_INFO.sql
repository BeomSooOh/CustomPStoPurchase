USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    Script Date: 11/28/2016 11:38:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_ABSDOCU_INFO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    Script Date: 11/28/2016 11:38:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_ABSDOCU_INFO]    
   @CO_CD   NVARCHAR(4)      --회사코드    
       , @RETURN_MESSAGE NVARCHAR(1024)  = NULL OUTPUT             
AS    
    
/*                                              
   목   적 :  회사별 결의서 환경설정 (기타소득자 선택시 과세율 정보 등)     
   환   경 :                     
   관련 객체 :                      
   작성일/작성자 : 2010.01. , HSKIM                    
   리턴값 : 성공/실패                
   작업순서                                        
   주의점 :                     
   수정사항               
                    
EXEC dbo.P_GWG20_COMMON_ABSDOCU_INFO @CO_CD='9998'    
--================================                    
*/                      
              
   -- 세션 기본 설정                    
   SET NOCOUNT ON;                      
   IF @@LOCK_TIMEOUT < 500                     
       SET LOCK_TIMEOUT  500;                                                            
   SET DEADLOCK_PRIORITY NORMAL;               
                                        
                    
--======================================================================================================================================================                          
   DECLARE  @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                               
           ,@ret_val      int              -- 결과 리턴값                                              
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                     
           ,@row_cnt      int                           
           ,@QUERY   NVARCHAR(4000)         
              
    -- 리턴값은 알수 없는 에러로  초기화함.                                              
    -- 에러코드를 성공으로 초기화                                              
     SELECT @proc_name='P_GWG20_COMMON_ABSDOCU_INFO',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';           
    
    
      SET @QUERY = 'SELECT A.NDEP_RT --필요경비율    
    , A.STA_RT --기타소득세율    
    , A.JTA_RT -- 주민세율    
    , A.MTAX_AM -- 과세최저한    
     FROM  ABSDOCU A INNER JOIN SCO S ON A.CO_CD = S.CO_CD AND A.ACCTDEF_FG = S.ACCT_FG    
  WHERE A.CO_CD =  ''' + @CO_CD + ''''      
     
      
  EXEC(@QUERY)    
 SET NOCOUNT OFF;          
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::성공';                   
END_PROC:              
              
   RETURN @ret_val ;      
    
    
    
     
    

GO


