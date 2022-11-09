USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABGT_BOTTOM_LIST]    Script Date: 11/28/2016 11:38:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_ABGT_BOTTOM_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_ABGT_BOTTOM_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_ABGT_BOTTOM_LIST]    Script Date: 11/28/2016 11:38:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_ABGT_BOTTOM_LIST]      
   @CO_CD  NVARCHAR(4)        --- 회사 코드       
 , @MGT_CD  NVARCHAR(10)           
 , @LANGKIND  NVARCHAR(10) = 'KR'    
AS                
/*                                                
 목   적 : 하위사업 조회    
 환   경 :                       
 관련 객체 :                        
 작성일/작성자 : 2011.07, tslim    
 리턴값 : 성공/실패                  
 작업순서                                          
 주의점 :                       
 수정사항                        
                      
 EXEC dbo.P_GWG20_COMMON_ABGT_BOTTOM_LIST @CO_CD='1000'    
--================================                      
*/                        
            
 -- 세션 기본 설정                      
 SET NOCOUNT ON;                        
 IF @@LOCK_TIMEOUT < 500                       
 SET LOCK_TIMEOUT  500;                                                              
 SET DEADLOCK_PRIORITY LOW;                 
    
 SELECT    
    BOTTOM_CD    
  , CASE WHEN @LANGKIND = 'KR' THEN BOTTOM_NM ELSE CASE WHEN ISNULL(BOTTOM_NMK, '') = '' THEN BOTTOM_NM ELSE BOTTOM_NMK END END AS BOTTOM_NM    
 FROM ABGT_BOTTOM    
 WHERE CO_CD = @CO_CD    
 AND MGT_CD = @MGT_CD    

GO


