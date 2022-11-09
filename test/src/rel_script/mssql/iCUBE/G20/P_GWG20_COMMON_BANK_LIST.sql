USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BANK_LIST]    Script Date: 11/28/2016 11:38:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_BANK_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_BANK_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BANK_LIST]    Script Date: 11/28/2016 11:38:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
        
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_BANK_LIST]          
   @CO_CD NVARCHAR(4)        
 , @BANK_CD  NVARCHAR(10) = NULL        
 , @BANK_NM  NVARCHAR(60) = NULL        
 , @LANGKIND NVARCHAR(10) = 'KR'    
 , @RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT                   
AS                    
/*                                                    
   목   적 :  금융기관 목록을 얻음.                         
   환   경 :                           
   관련 객체 :                            
   작성일/작성자 : 2010.04. , hskim      
   리턴값 : 성공/실패                      
   작업순서                                              
   주의점 :                           
   수정사항 :                        
                          
                          
EXEC dbo.P_GWG20_COMMON_BANK_LIST @CO_CD='2000'        
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
 SELECT @proc_name='P_GWG20_COMMON_BANK_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';                 
           
 SELECT A.BANK_CD, CASE WHEN @LANGKIND = 'KR' THEN A.BANK_NM ELSE CASE WHEN ISNULL(A.BANK_NMK, '') = '' THEN A.BANK_NM ELSE A.BANK_NMK END END AS BANK_NM    
 FROM SBANK A      
 WHERE ( NULLIF(@BANK_CD,'') IS NULL OR  A.BANK_CD =@BANK_CD)        
 AND ( NULLIF(@BANK_NM,'') IS NULL OR  A.BANK_NM =@BANK_NM)        
 ORDER BY A.BANK_CD      
        
 SELECT @ret_val=0,@RETURN_MESSAGE=N'0::성공';                         
 END_PROC:                    
                    
 RETURN @ret_val ;            

GO


