USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TD_A]    Script Date: 11/28/2016 11:39:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_TD_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_TD_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TD_A]    Script Date: 11/28/2016 11:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROC [dbo].[P_GWG20B_ABDOCU_INSERT_TD_A]     
(   
 @LANGKIND    NVARCHAR(3), --언어종류( 필수, KOR, CHS, ENG, JPN 등)    
 @ERP_CO_CD  NVARCHAR(4),  
 @ERP_ISU_DT  NVARCHAR(8),  
 @ERP_ISU_SQ  NUMERIC(5),  
 @ERP_LN_SQ NUMERIC(5) = NULL OUTPUT,  
 @JONG_NM   NVARCHAR(10),  
 @JKM_CNT NUMERIC(17,4),  
 @JGRADE   NVARCHAR(3),  
 @JUNIT_AM NUMERIC(17,4),  
 @JTOT_AM NUMERIC(17,4),  
 @JONG_NMK  NVARCHAR(10),   
 @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT
)  
-- WITH ENCRYPTION  
AS  
/*************************************************************************/  
--설    명 : 회계관리 - 결의서(복수예산) - 라인(중간) 조회  
--수 정 자 : 김대영  
--수정일자 : 2008/10/13  
--수정내역 : 2008/10/13 : 신규   
/***/  
--======================================================================================================================================================                            
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                 
           ,@ret_val      int              -- 결과 리턴값                                                
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                       
           ,@row_cnt      int                             
             
    -- 리턴값은 알수 없는 에러로  초기화함.                                                
    -- 에러코드를 성공으로 초기화                                                
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_TD',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';       
     
BEGIN   
   
    
  SELECT @ERP_LN_SQ = ISNULL(  MAX(LN_SQ ), 0 )+1   
    FROM ABDOCU_TD  
   WHERE CO_CD = @ERP_CO_CD AND ISU_DT = @ERP_ISU_DT AND ISU_SQ = @ERP_ISU_SQ     
  
 INSERT INTO ABDOCU_TD ( CO_CD,ISU_DT,ISU_SQ,LN_SQ,JONG_NM,JKM_CNT,JGRADE,JUNIT_AM,JTOT_AM,JONG_NMK)  
 VALUES( @ERP_CO_CD,@ERP_ISU_DT,@ERP_ISU_SQ,@ERP_LN_SQ,@JONG_NM,@JKM_CNT,@JGRADE,@JUNIT_AM,@JTOT_AM,@JONG_NMK)  
  
    
END  

 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
    IF @error_code!=0       
       BEGIN       
           IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::여비결의서 명세서(ABDOCU_TD) 신규 생성 중 오류 발생';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:성공';       
      
  COMMIT TRANSACTION;      
       
  --SELECT @ret_val, @RETURN_MESSAGE, @ERP_ISU_DT, @ERP_ISU_SQ, @ERP_LN_SQ    
  SELECT @ret_val AS ret_val
       , @RETURN_MESSAGE AS RETURN_MESSAGE
       , @ERP_ISU_DT AS ERP_ISU_DT
       , @ERP_ISU_SQ AS ERP_ISU_SQ
       , @ERP_LN_SQ AS ERP_LN_SQ   
       
END_PROC:                
           
   RETURN @ret_val ;        
   


GO


