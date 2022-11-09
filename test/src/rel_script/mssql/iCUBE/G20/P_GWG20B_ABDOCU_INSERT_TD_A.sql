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
 @LANGKIND    NVARCHAR(3), --�������( �ʼ�, KOR, CHS, ENG, JPN ��)    
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
--��    �� : ȸ����� - ���Ǽ�(��������) - ����(�߰�) ��ȸ  
--�� �� �� : ��뿵  
--�������� : 2008/10/13  
--�������� : 2008/10/13 : �ű�   
/***/  
--======================================================================================================================================================                            
   DECLARE @proc_name   VARCHAR(60)        -- ���� ���ν��� �̸�                                                 
           ,@ret_val      int              -- ��� ���ϰ�                                                
           ,@error_code    int              -- SQL  ��� ���� ��� ������ ���� �ӽ� ����                                                       
           ,@row_cnt      int                             
             
    -- ���ϰ��� �˼� ���� ������  �ʱ�ȭ��.                                                
    -- �����ڵ带 �������� �ʱ�ȭ                                                
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_TD',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';       
     
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
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::������Ǽ� ����(ABDOCU_TD) �ű� ���� �� ���� �߻�';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:����';       
      
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


