USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_D_A]    Script Date: 11/28/2016 11:39:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_D_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_D_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_D_A]    Script Date: 11/28/2016 11:39:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROC [dbo].[P_GWG20B_ABDOCU_INSERT_D_A]   
(  
 @LANGKIND  NVARCHAR(3), --언어종류( 필수, KOR, CHS, ENG, JPN 등)  
 @ERP_CO_CD   NVARCHAR(4),  -- 회사코드(필수)    
 @ERP_ISU_DT   NVARCHAR(8),  -- 결의일자(필수)  
 @ERP_ISU_SQ   NUMERIC(5) ,  -- 결의번호  
 @ERP_LN_SQ   NUMERIC(3) = NULL OUTPUT,
 @ITEM_NM  NVARCHAR(40),  
 @ITEM_NMK  NVARCHAR(40),  
 @ITEM_DC  NVARCHAR(40),  
 @UNIT_DC  NVARCHAR(40),  
 @CT_QT   NUMERIC(17,6),  
 @UNIT_AM  NUMERIC(17,4),  
 @CT_AM   NUMERIC(17,4),  
 @RMK_DC   NVARCHAR(40),  
 @RMK_DCK  NVARCHAR(40) ,   
 @INSERT_ID  NVARCHAR(10),  -- 입력자(필수)  
 @INSERT_IP  NVARCHAR(15),   -- 입력IP(필수)  
 @ITEM_CD  NVARCHAR(10),  
 @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT     
)  
--WITH ENCRYPTION  
AS  
/*************************************************************************/  
--설    명 : 회계관리 - 결의서(복수예산) - 헤더 저장  
--수 정 자 : 김대영  
--수정일자 : 2008/10/13  
--수정내역 : 2008/10/13 : 신규   
--         : 2009/11/06 : ITME_CD 추가   
/***/  

--======================================================================================================================================================                            
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                 
           ,@ret_val      int              -- 결과 리턴값                                                
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                       
           ,@row_cnt      int                             
             
    -- 리턴값은 알수 없는 에러로  초기화함.                                                
    -- 에러코드를 성공으로 초기화                                                
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_D',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';       
     
BEGIN  
  
 SELECT @ERP_LN_SQ = isnull(MAX(ISNULL(LN_SQ,0) ),0) + 1   
 FROM ABDOCU_D  
 WHERE CO_CD=@ERP_CO_CD   
 AND ISU_DT=@ERP_ISU_DT  
 AND ISU_SQ=@ERP_ISU_SQ   
  
 INSERT INTO ABDOCU_D (CO_CD, ISU_DT,ISU_SQ,LN_SQ,ITEM_NM,ITEM_NMK,ITEM_DC,UNIT_DC,  
     CT_QT, UNIT_AM, CT_AM,RMK_DC,RMK_DCK,INSERT_ID,INSERT_IP, INSERT_DT, ITEM_CD)  
 VALUES( @ERP_CO_CD, @ERP_ISU_DT,@ERP_ISU_SQ,@ERP_LN_SQ,@ITEM_NM,@ITEM_NMK,@ITEM_DC,@UNIT_DC,  
     @CT_QT, @UNIT_AM, @CT_AM,@RMK_DC,@RMK_DCK,@INSERT_ID,@INSERT_IP, GETDATE(),@ITEM_CD)  
  
END  
  
 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
    IF @error_code!=0       
       BEGIN       
           IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::결의서 상세(ABDOCU_D) 신규 생성 중 오류 발생';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:성공';       
      
    COMMIT TRANSACTION;      
       
   -- SELECT @ret_val, @RETURN_MESSAGE, @ERP_ISU_DT, @ERP_ISU_SQ, @ERP_LN_SQ    
   SELECT @ret_val AS ret_val
        , @RETURN_MESSAGE AS RETURN_MESSAGE
        , @ERP_ISU_DT AS ERP_ISU_DT
        , @ERP_ISU_SQ AS ERP_ISU_SQ
        , @ERP_LN_SQ AS ERP_LN_SQ   
END_PROC:                
           
   RETURN @ret_val ;        
   


GO


