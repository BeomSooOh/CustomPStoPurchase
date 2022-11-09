USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]    Script Date: 11/28/2016 11:39:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_H_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]    Script Date: 11/28/2016 11:39:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_H]    Script Date: 09/10/2012 10:23:19 ******/    

/*    
1. EZICUBE DB�� P_GWG20B_ABDOCU_INSERT_H ���ν����� ���� ����.    
2. ABDOCU �� DUMMY1 �� GW ���� ������ �����͸� ������.    
3. ���а� ���� ��� ��ȸ�������� �̿�    
    
*/    
        
CREATE PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_H_A]                  
  --�ʼ���                   
   @ERP_CO_CD   NVARCHAR(4) --ERPȸ���ڵ�                  
 , @ERP_GISU_DT  NVARCHAR(8)  --������                  
 , @ERP_EMP_CD  NVARCHAR(10) --ERP�۾���                  
 , @ERP_DIV_CD  NVARCHAR(4)  --ERP������ڵ�                  
 , @ERP_DEPT_CD  NVARCHAR(4)  --ERP�μ��ڵ�                  
 , @MGT_CD   NVARCHAR(10) --ERP ������Ʈ �ڵ�                  
 , @DOCU_FG   NVARCHAR(2)  --ERP ���Ǳ���                  
 , @RMK_DC   NVARCHAR(100) --ERP ����                  
 , @ADMIT_YN   NVARCHAR(1)  --                  
 , @ACISU_DT   NVARCHAR(8)  --                  
 , @EXEC_DT   NVARCHAR(8)  --                  
 , @REG_DT   NVARCHAR(8)  --                   
 , @RISU_DT   NVARCHAR(8)  --                  
 , @RISU_SQ   INT                  
 , @BTR_CD   NVARCHAR(10)  --                  
 , @BTR_NM   NVARCHAR(40)  --                  
 , @CAUSE_DT   NVARCHAR(8)  --                  
 , @SIGN_DT   NVARCHAR(8)  --                  
 , @INSPECT_DT  NVARCHAR(8)  --                  
 , @GISU_DT   NVARCHAR(8)  = NULL OUTPUT                          
 , @GISU_SQ   NUMERIC(5,0)  = NULL OUTPUT                 
 , @REF_PART_FG NVARCHAR(2)                        
 , @REF_GET_NO NVARCHAR(16)                        
 , @REF_PART_DT NVARCHAR(16)                        
 , @REF_PART_SQ NVARCHAR(10)      
 , @BANK_DT NVARCHAR(8)      
 , @TRAN_CD NVARCHAR(3)      
 , @BOTTOM_CD NVARCHAR(10)    
 , @DUMMY1 NVARCHAR(50) = null    
 , @CAUSE_ID NVARCHAR(10) --����������
 , @RETURN_MESSAGE  NVARCHAR(2048)  = NULL OUTPUT          
AS                            
/*                                                            
   ��   �� :  ���Ǽ� ��� (ABDOCU) �߰���.                             
   ȯ   �� :                                   
   ���� ��ü :                                    
   �ۼ���/�ۼ��� : 2009.11. , HSKIM                                  
   ���ϰ� : ����/����                              
   �۾�����                                                      
   ������ :                     
   �������� :                     
                  
--================================                                  
*/                                    
-- ���� �⺻ ����                                  
SET NOCOUNT ON;                                    
IF @@LOCK_TIMEOUT < 500                                   
SET LOCK_TIMEOUT  500;                                                                          
SET DEADLOCK_PRIORITY NORMAL;                             
    
--======================================================================================================================================================                                        
DECLARE   @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                                             
  , @ret_val      int              -- ��� ���ϰ�                                                            
  , @error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                                   
  , @row_cnt      int                                         
    
-- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                                            
-- �����ڵ带 �������� �ʱ�ȭ                                                            
SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_H',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';                         
    
--=================================================================                  
-- ���� ����                  
--====================================                  
    
--�ʼ��� �˻�                   
IF NULLIF(@ERP_CO_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(ȸ���ڵ�)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@ERP_DIV_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(������ڵ�)';                   
 GOTO END_PROC;                  
END                    
    
/*    
IF NULLIF(@ERP_DEPT_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(�μ��ڵ�)';                      
 GOTO END_PROC;                  
END        
*/                
    
/*    
IF NULLIF(@ERP_EMP_CD,'') IS NULL                   
BEGIN                   
 SELECT @ret_val=-10,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(�����ȣ)';                      
 GOTO END_PROC;                  
END                    
*/    
IF NULLIF(@MGT_CD,'') IS NULL               
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(������Ʈ/�μ��ڵ�)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@DOCU_FG,'') IS NULL                  
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(���Ǳ���)';                      
 GOTO END_PROC;                  
END                    
    
IF NULLIF(@ERP_GISU_DT,'') IS NULL                  
BEGIN                   
 SELECT @ret_val=-1,@RETURN_MESSAGE=CONVERT(NVARCHAR(10),@ret_val) + N':�Ű������̻�(������)';                      
 GOTO END_PROC;                  
END                   
    
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE                  
BEGIN TRANSACTION;                  
    
DECLARE @BANK_SQ NUMERIC(5,0)    

BEGIN    
 --���ǹ�ȣ ��������                   
 EXEC USP_GET_ABDOCU_KEY_NB @ERP_CO_CD,N'ABDOCU', @ERP_GISU_DT, @GISU_SQ OUTPUT                  
    
 --���Ǽ� ��� (ABDOCU)                  
 INSERT INTO ABDOCU                   
 (                   
    CO_CD   , DIV_CD   , DEPT_CD   , EMP_CD    
  , GISU_DT  , GISU_SQ   , DOCU_FG   , MGT_CD    
  , RMK_DC  , RMK_DCK   , ACISU_DT   , EXEC_DT    
  , REG_DT  , CAUSE_DT   , SIGN_DT   , INSPECT_DT    
  , BTR_CD  , GW_STATE   , INSERT_ID   , INSERT_IP    
  , INSERT_DT  , EXTER_FG   , BOTTOM_CD   , DUMMY2 , CAUSE_ID   
 )                   
 VALUES    
 (                  
    @ERP_CO_CD , @ERP_DIV_CD  , @ERP_DEPT_CD  , @ERP_EMP_CD    
  , @ERP_GISU_DT , @GISU_SQ   , @DOCU_FG   , @MGT_CD    
  , @RMK_DC  , @RMK_DC   , @ACISU_DT   , @EXEC_DT    
  , @REG_DT  , @CAUSE_DT   , @SIGN_DT   , @INSPECT_DT    
  , @BTR_CD  , '0'    , @ERP_EMP_CD  , ''    
  , GETDATE()  , 'GW'    , @BOTTOM_CD  , @DUMMY1 , @CAUSE_ID    
 )             
END         
    
------------------------------------------------------------------------------------------------------              
-- @REF_GET_NO �� ���� ��� ���� ǰ�Ǽ� �̹Ƿ� ABIN ���̺��� ������Ʈ            
-- 2010-08-17 ����� �߰�                 
------------------------------------------------------------------------------------------------------      
IF ISNULL(@REF_GET_NO,'') != ''            
BEGIN              
 -- PART_YN : 1.��ü, 2.�κ�����            
 -- PART_ST : 2.��ü, 1.�κ�����           
 IF ISNULL(@REF_PART_FG, '') = '1'        
 BEGIN        
  UPDATE ABIN           
  SET           
     PART_YN ='1'          
   , PART_ST = '2'          
   , GW_YN = '1'          
   , GISU_NO = @ERP_GISU_DT + '-' + CAST(@GISU_SQ AS VARCHAR)          
   , GISU_DT = @ERP_GISU_DT          
   , GISU_SQ = @GISU_SQ           
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO            
 END        
 ELSE        
 BEGIN        
  -- �κ�����        
  UPDATE ABIN           
  SET           
     PART_YN ='2'          
   , PART_ST = '1'          
   , GW_YN = '1'          
   , GISU_NO = '�κ�����'        
   , GISU_DT = @ERP_GISU_DT          
   , GISU_SQ = @GISU_SQ           
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO         
    
    
  UPDATE ABIN_PART_H      
  SET GISU_DT = @ERP_GISU_DT      
   , GISU_SQ = @GISU_SQ      
   , MODIFY_ID = @ERP_EMP_CD      
   , MODIFY_DT = GETDATE()      
  WHERE CO_CD = @ERP_CO_CD AND DIV_CD = @ERP_DIV_CD AND GET_NO = @REF_GET_NO         
  AND PART_DT = @REF_PART_DT AND PART_SQ = CAST(@REF_PART_SQ AS INT)      
 END              
END            
    
------------------------------------------------------------------------------------------------------      
SELECT @error_code = @@ERROR , @row_cnt = @@rowcount                   
    
IF @error_code!=0                   
BEGIN                   
 IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;                  
 SELECT @ret_val=-1,@RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::���Ǽ� ���(ABDOCU) �ű� ���� �� ���� �߻�';                                 
 GOTO END_PROC;                  
END                   
    
 select @ret_val = 0, @RETURN_MESSAGE = '0:����';       
        
COMMIT TRANSACTION;                  
    
END_PROC:       
    
-- SELECT 0,'0::����',  @ERP_GISU_DT  ,  @GISU_SQ, ISNULL(@BANK_SQ, 0)    
SELECT @ret_val AS ret_val
     , @RETURN_MESSAGE AS RETURN_MESSAGE
     , @ERP_GISU_DT AS ERP_GISU_DT
     , @GISU_SQ AS ERP_GISU_SQ
     , ISNULL(@BANK_SQ, 0) AS ERP_BANK_SQ  
    
print '@ret_val : ' + cast(@ret_val as varchar) + ':' + @RETURN_MESSAGE                
RETURN @ret_val ; 


GO


