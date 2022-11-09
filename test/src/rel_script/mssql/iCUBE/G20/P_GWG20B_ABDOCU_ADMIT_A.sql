USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_ADMIT_A]    Script Date: 11/28/2016 11:39:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_ADMIT_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_ADMIT_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_ADMIT_A]    Script Date: 11/28/2016 11:39:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
      
      
/*************************************************************************/                            
--설    명 : 결의서 결재상태 업데이트    
--수 정 자 : 김효신                            
--수정일자 : 2010-07-                            
--수정내역 : 그룹웨어에서 넘어간 데이터의 결의서 헤더 부분 정보를 변경 GW_STATE: 0 -> 1                                  
--                                
/*************************************************************************/                                
        
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_ADMIT_A]               
(    
   @ERP_CO_CD NVARCHAR(4)        
 , @ERP_DIV_CD NVARCHAR(4)      
 , @ERP_EMP_CD NVARCHAR(10) = ''      
 , @ERP_GISU_DT NVARCHAR(8)        
 , @ERP_GISU_SQ INT        
 , @DOC_CD NVARCHAR(100)        
 , @BANK_DT NVARCHAR(10) = ''    
 , @TRAN_CD NVARCHAR(3) = ''    
 , @ABDOCU_NO NVARCHAR(20) = ''    
 , @RETURN_MESSAGE nvarchar(1024)= NULL OUTPUT             
)     
AS            
         
   -- 세션 기본 설정                            
     SET NOCOUNT ON;              
   IF @@LOCK_TIMEOUT < 500                  -- 잠금제한 시간을 0.5초로 설정                                  
       SET LOCK_TIMEOUT  500;                                                    
   SET DEADLOCK_PRIORITY LOW;               --deadlock 시 처리 우선 순위를 낮게 함                
          
                    
SET ARITHABORT ON                                                
            
        
--======================================================================================================================================================                                  
   DECLARE @proc_name   VARCHAR(60)        -- 저장 프로시져 이름                                                       
           ,@ret_val      int              -- 결과 리턴값                                                      
           ,@error_code    int              -- SQL  명령 실행 결과 저장을 위한 임시 변수                                                             
           ,@row_cnt      int                                   
                            
                      
    -- 리턴값은 알수 없는 에러로  초기화함.                                                      
    -- 에러코드를 성공으로 초기화                                                      
     SELECT @proc_name='P_GWG20_ABDOCU_ADMIN',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::알수 없는 에러';                   
            
            
            
          
--SEQ 값들 때문에 SERIALIZABLE로 함.             
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE            
BEGIN TRANSACTION;            
--========================================================================            
        
        
DECLARE @RMK_DC NVARCHAR(200)        
SET @RMK_DC = '';        
        
        
IF (LEN(@DOC_CD) > 0)        
 SET @RMK_DC = @DOC_CD + ' '        
        
    IF ISNULL(@BANK_DT, '') != ''    
      BEGIN    
          
  IF @TRAN_CD = '000'     
    BEGIN    
   UPDATE DBO.SACBANKH SET GW_STATE = '2' WHERE GW_ID = @ABDOCU_NO    
    END    
  ELSE IF @TRAN_CD = '301'        
    BEGIN    
   UPDATE DBO.ACARD_SUNGIN SET GW_STATE = '2' WHERE GW_ID = @ABDOCU_NO    
    END    
          
      END    
 ELSE    
   BEGIN          
        
    UPDATE ABDOCU SET GW_STATE ='1'           
   , RMK_DC =  LEFT( @RMK_DC + RMK_DC , 100)    
   , MODIFY_ID = @ERP_EMP_CD    
   , MODIFY_DT = getdate()        
   WHERE CO_CD = @ERP_CO_CD          
   AND DIV_CD =@ERP_DIV_CD          
   AND GISU_DT =@ERP_GISU_DT          
   AND GISU_SQ = @ERP_GISU_SQ          
       
   END       
          
    
    
    SELECT @error_code = @@ERROR , @row_cnt = @@rowcount           
    IF @error_code!=0           
      BEGIN           
       IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;          
       SELECT @ret_val=@error_code,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::결의서 전결 중 오류 발생';                         
       GOTO END_PROC;                          
      END           
          
                 
         
            
            
  COMMIT TRANSACTION;          
   SELECT @ret_val=0 ,@RETURN_MESSAGE= N'0:성공';          
          
END_PROC:          
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED          
  SELECT @ret_val AS ret_val
       , @RETURN_MESSAGE AS RETURN_MESSAGE      
          
  return @ret_val ; 


GO


