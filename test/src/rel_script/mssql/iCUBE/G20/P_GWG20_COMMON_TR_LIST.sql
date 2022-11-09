USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_TR_LIST]    Script Date: 11/28/2016 11:38:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_TR_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_TR_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_TR_LIST]    Script Date: 11/28/2016 11:38:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
    
CREATE PROCEDURE [dbo].[P_GWG20_COMMON_TR_LIST]      
   @CO_CD NVARCHAR(4)    
 , @TR_CD  NVARCHAR(10)= NULL    
 , @TR_NM  NVARCHAR(60)= NULL    
 , @TYPE NVARCHAR(1)='1'  -- 1. 일반 거래처, 2:금융거래처 그룹    
 , @DETAIL_TYPE  NVARCHAR(1)= NULL    
 , @LANGKIND NVARCHAR(10) = 'KR'    
 , @RETURN_MESSAGE nvarchar(1024)  = NULL OUTPUT               
AS                
/*                                                
   목   적 :  거래처 목록을 얻음.                     
   환   경 :                       
   관련 객체 :                        
   작성일/작성자 : 2009.10. , 이정길                      
   리턴값 : 성공/실패                  
   작업순서                                          
   주의점 :                       
   수정사항 : 2009.11. , HSKIM 거래처 정보 추       
        2010.03. , HSKIM 담당자 및 거래처 전화번호 추가                      
                      
                      
EXEC dbo.P_GWG20_COMMON_TR_LIST @CO_CD='2000'    
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
     SELECT @proc_name='P_GWG20_COMMON_TR_LIST',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';             
      
       
    
    
    
 SELECT A.CO_CD,  -- 0.회사 코드    
   A.TR_CD,  -- 1.거래처 코드    
   CASE WHEN @LANGKIND = 'KR' THEN A.TR_NM ELSE CASE WHEN ISNULL(A.TR_NMK, '') = '' THEN A.TR_NM ELSE A.TR_NMK END END AS TR_NM,  -- 2.거래처 명    
   A.TR_FG,  -- 3.거래구분 ( 1:일반,무역,주민,기타, 금융기관,정기예금,정기적금,카드사, 신용카드    
            CASE WHEN A.TR_FG ='1' THEN N'일반'    
                 WHEN A.TR_FG ='2' THEN N'무역'    
                 WHEN A.TR_FG ='3' THEN N'주민'    
                 WHEN A.TR_FG ='4' THEN N'기타'    
                 WHEN A.TR_FG ='5' THEN N'금융기관'    
                 WHEN A.TR_FG ='6' THEN N'정기예금'    
                 WHEN A.TR_FG ='7' THEN N'정기적금'    
                 WHEN A.TR_FG ='8' THEN N'카드사'    
                 WHEN A.TR_FG ='9' THEN N'신용카드'    
              ELSE ''    
              END AS TR_FG_NM,    
    CASE WHEN @LANGKIND = 'KR' THEN A.ATTR_NM ELSE CASE WHEN ISNULL(A.ATTR_NMK, '') = '' THEN A.ATTR_NM ELSE A.ATTR_NMK END END AS ATTR_NM, -- 4.거래처 약칭    
            A.REG_NB,     -- 5.사업자등록번호    
   A.PPL_NB,     -- 6.주민등록번호    
   A.DEPOSITOR, -- 5.예금주    
   CASE WHEN @LANGKIND = 'KR' THEN A.CEO_NM ELSE CASE WHEN ISNULL(A.CEO_NMK, '') = '' THEN A.CEO_NM ELSE A.CEO_NMK END END AS CEO_NM,  -- 6.대표자성명    
   A.JIRO_CD,  -- 7.은행코드    
   CASE WHEN @LANGKIND = 'KR' THEN C.BANK_NM ELSE CASE WHEN ISNULL(C.BANK_NMK, '') = '' THEN C.BANK_NM ELSE C.BANK_NMK END END AS JIRO_NM,  -- 8.은행명    
   A.BA_NB,   -- 9.계좌번호    
   ISNULL(A.DIV_ADDR1, '') + ' ' + ISNULL(A.ADDR2, '') As ADDR,    
   D.TRCHARGE_EMP,    
   A.TEL    
   FROM STRADE A WITH(NOLOCK) INNER JOIN     
            (   SELECT '1' AS TR_FG    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    --일반거래처(1,2,3,4)    
              UNION ALL    
                  SELECT '2'    
   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    
              UNION ALL    
                  SELECT '3'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1                UNION ALL    
                  SELECT '4'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=1    
              UNION ALL    
                  SELECT '5'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2 --금융거래처(5,6,7,8,9)    
              UNION ALL    
                  SELECT '6'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '7'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '8'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
              UNION ALL    
                  SELECT '9'    
                   WHERE  NULLIF(@TYPE ,'') IS NULL OR @TYPE=2    
             ) B    
              ON(A.TR_FG=B.TR_FG)    
   LEFT OUTER JOIN SBANK C ON ( A.JIRO_CD = C.BANK_CD)    
   LEFT OUTER JOIN ( SELECT  CO_CD, TR_CD, TRCHARGE_EMP, TRCHARGE_TEL FROM STRADE_REC WHERE REC_SQ ='1') D  ON (A.CO_CD = D.CO_CD AND A.TR_CD = D.TR_CD)    
  WHERE A.CO_CD=@CO_CD     
            AND ( NULLIF(@TR_CD,'') IS NULL OR  A.TR_CD =@TR_CD)    
            AND ( NULLIF(@TR_NM,'') IS NULL OR  A.TR_NM LIKE '%' +@TR_NM + '%')    
            AND ( NULLIF(@DETAIL_TYPE,'') IS NULL OR A.TR_FG=@DETAIL_TYPE)    
            AND A.USE_YN = 1    
     --ORDER BY TR_CD    
    
    
  SELECT @ret_val=0,@RETURN_MESSAGE=N'0::성공';                     
END_PROC:                
                
   RETURN @ret_val ;        
      
    
    
    
    


GO


