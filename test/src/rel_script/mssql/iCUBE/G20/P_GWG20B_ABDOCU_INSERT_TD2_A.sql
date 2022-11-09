USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TD2_A]    Script Date: 11/28/2016 11:39:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_TD2_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_TD2_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TD2_A]    Script Date: 11/28/2016 11:39:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_TD2_A]  
(  
    @LANGKIND   NVARCHAR(3), --언어종류( 필수, KOR, CHS, ENG, JPN 등)  
    @CO_CD      NVARCHAR(4),  
    @ERP_ISU_DT     NVARCHAR(8),  
    @ERP_ISU_SQ     NUMERIC(5),  
    @ERP_LN_SQ      NUMERIC(5) = NULL OUTPUT,  
    @TRIP_DT    NVARCHAR(8),  
    @NT_CNT     NUMERIC(3),  
    @DAY_CNT    NUMERIC(3),  
    @START_NM   NVARCHAR(20),  
    @CROSS_NM   NVARCHAR(20),  
    @ARR_NM     NVARCHAR(20),  
    @JONG_NM    NVARCHAR(10),  
    @KM_AM      NUMERIC(17,4),  
    @FAIR_AM    NUMERIC(17,4),  
    @TRMK_DC    NVARCHAR(20),  
    @START_NMK  NVARCHAR(20),  
    @CROSS_NMK  NVARCHAR(20),  
    @ARR_NMK    NVARCHAR(20),  
    @JONG_NMK   NVARCHAR(10),  
    @TRMK_DCK   NVARCHAR(20),  
    @EMP_NM     NVARCHAR(30),  
    @DAY_AM     NUMERIC(17,4),  
    @FOOD_AM    NUMERIC(17,4),  
    @ROOM_AM    NUMERIC(17,4),  
    @OTHER_AM   NUMERIC(17,4),  
    @DEPT_NM    NVARCHAR(20),  
    @HCLS_NM    NVARCHAR(50),
    @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT   
)  
--WITH ENCRYPTION  
AS  
/*************************************************************************/  
-- 설    명   : G20 예산관리 - 결의서 - 여비 하단 저장  
-- 수정일자   : 수정자 : 수정내역  
-- 2008/10/13 : 김대영 : 신규  
-- 2011/01/24 : 김대영 : EMP_NM 추가   
-- 2011/06/16 : 김대영 : 일비외 컬럼 추가  
-- 2013/01/31 : 김현철 : 부서/직급 추가  
/************************************************************************/  
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                 
           ,@ret_val      int              -- 결과 리턴값                                                
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                       
           ,@row_cnt      int                             
             
    -- 리턴값은 알수 없는 에러로  초기화함.                                                
    -- 에러코드를 성공으로 초기화                                                
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_TD2',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';       
     
BEGIN  
  
    SET NOCOUNT ON;  
  
     SELECT @ERP_LN_SQ = ISNULL(MAX(LN_SQ), 0) + 1  
       FROM ABDOCU_TD2  
      WHERE CO_CD = @CO_CD  
        AND ISU_DT = @ERP_ISU_DT  
        AND ISU_SQ = @ERP_ISU_SQ;  
  
    INSERT INTO ABDOCU_TD2  
    (  
        CO_CD,ISU_DT,ISU_SQ,LN_SQ,TRIP_DT,NT_CNT,DAY_CNT,  
        START_NM,CROSS_NM,ARR_NM,JONG_NM,KM_AM,FAIR_AM,  
        TRMK_DC,START_NMK,CROSS_NMK,ARR_NMK,JONG_NMK,TRMK_DCK, EMP_NM,  
        DAY_AM,FOOD_AM,ROOM_AM,OTHER_AM,DEPT_NM,HCLS_NM  
    )  
    VALUES  
    (  
        @CO_CD,@ERP_ISU_DT,@ERP_ISU_SQ,@ERP_LN_SQ,@TRIP_DT,@NT_CNT,@DAY_CNT,  
        @START_NM,@CROSS_NM,@ARR_NM,@JONG_NM,@KM_AM,@FAIR_AM,  
        @TRMK_DC,@START_NMK,@CROSS_NMK,@ARR_NMK,@JONG_NMK,@TRMK_DCK, @EMP_NM,  
        @DAY_AM,@FOOD_AM,@ROOM_AM,@OTHER_AM,@DEPT_NM,@HCLS_NM  
    );  
  
    SET NOCOUNT OFF;  
END  
 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
    IF @error_code!=0       
       BEGIN       
           IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::여비결의서 명세서(ABDOCU_TD2) 신규 생성 중 오류 발생';                     
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


