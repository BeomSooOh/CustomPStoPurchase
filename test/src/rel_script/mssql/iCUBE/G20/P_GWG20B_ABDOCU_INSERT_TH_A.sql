USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TH_A]    Script Date: 11/28/2016 11:39:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20B_ABDOCU_INSERT_TH_A]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20B_ABDOCU_INSERT_TH_A]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20B_ABDOCU_INSERT_TH_A]    Script Date: 11/28/2016 11:39:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROC [dbo].[P_GWG20B_ABDOCU_INSERT_TH_A]     
(   
 @LANGKIND NVARCHAR(3), --�������( �ʼ�, KOR, CHS, ENG, JPN ��)    
 @ERP_CO_CD  NVARCHAR(4),  
 @ERP_ISU_DT  NVARCHAR(8),  
 @ERP_ISU_SQ  NUMERIC(5),  
 @TS_DT  NVARCHAR(8),  
 @TE_DT  NVARCHAR(8),  
 @TDAY_CNT NUMERIC(3),  
 @SITE_NM  NVARCHAR(20),  
 @REQ_NM  NVARCHAR(10),  
 @SCOST_AM NUMERIC(17,4),  
 @ONTRIP_NM  NVARCHAR(40),  
 @SITE_NMK  NVARCHAR(20),  
 @ONTRIP_NMK  NVARCHAR(40),  
 @REQ_NMK  NVARCHAR(10),  
 @RSV_NM  NVARCHAR(10),  
 @RSV_NMK  NVARCHAR(10),  
 @RCOST_AM NUMERIC(17,4),  
 @INSERT_ID  NVARCHAR(10),  
 @INSERT_IP  NVARCHAR(15),  
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
     SELECT @proc_name='P_GWG20B_ABDOCU_INSERT_TH',@ret_val=-1,@error_code=0 ,@RETURN_MESSAGE='100000::�˼� ���� ����';       
     
BEGIN   
   
  
 IF EXISTS ( SELECT 1 FROM ABDOCU_TH WHERE CO_CD = @ERP_CO_CD AND ISU_DT = @ERP_ISU_DT AND ISU_SQ = @ERP_ISU_SQ )  
 BEGIN  
     
  UPDATE ABDOCU_TH  
  SET TS_DT = @TS_DT , TE_DT = @TE_DT , TDAY_CNT = @TDAY_CNT , SITE_NM = @SITE_NM,REQ_NM = @REQ_NM,  
   SCOST_AM =@SCOST_AM, ONTRIP_NM = @ONTRIP_NM, SITE_NMK = @SITE_NMK, ONTRIP_NMK = @ONTRIP_NMK, REQ_NMK = @REQ_NMK, RSV_NMK = @RSV_NMK,  
   RSV_NM = @RSV_NM, RCOST_AM = @RCOST_AM  , MODIFY_ID = @INSERT_ID, MODIFY_IP =@INSERT_IP , MODIFY_DT = GETDATE()  
  WHERE CO_CD = @ERP_CO_CD AND ISU_DT = @ERP_ISU_DT AND ISU_SQ = @ERP_ISU_SQ   
   
 END   
 ELSE  
 BEGIN  
  
  INSERT INTO ABDOCU_TH (  
   CO_CD,ISU_DT,ISU_SQ,TS_DT,TE_DT,TDAY_CNT,SITE_NM,REQ_NM,  
   SCOST_AM,ONTRIP_NM,SITE_NMK,ONTRIP_NMK,REQ_NMK,RSV_NMK,  
   RSV_NM,RCOST_AM,INSERT_ID,INSERT_IP,INSERT_DT  
  )  
  VALUES   
  (  
   @ERP_CO_CD,@ERP_ISU_DT,@ERP_ISU_SQ,@TS_DT,@TE_DT,@TDAY_CNT,@SITE_NM,@REQ_NM,  
   @SCOST_AM,@ONTRIP_NM,@SITE_NMK,@ONTRIP_NMK,@REQ_NMK,@RSV_NMK,  
   @RSV_NM,@RCOST_AM,@INSERT_ID,@INSERT_IP,GETDATE()  
  )  
 END   
    
END  
      
 SELECT @error_code = @@ERROR , @row_cnt = @@rowcount       
    IF @error_code!=0       
       BEGIN       
           IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;      
           SELECT @ret_val = -1, @RETURN_MESSAGE= CONVERT(NVARCHAR(10),@error_code)+ N'::������Ǽ� ����(ABDOCU_TH) �ű� ���� �� ���� �߻�';                     
           GOTO END_PROC;      
       END       
      
  select @ret_val = 0, @RETURN_MESSAGE = '0:����';       
      
  COMMIT TRANSACTION;      
       
  --ELECT @ret_val, @RETURN_MESSAGE, @ERP_ISU_DT, @ERP_ISU_SQ
  SELECT @ret_val AS ret_val
       , @RETURN_MESSAGE AS RETURN_MESSAGE
       , @ERP_ISU_DT AS ERP_ISU_DT
       , @ERP_ISU_SQ AS ERP_ISU_SQ 
  
END_PROC:                
           
   RETURN @ret_val ;        
   


GO


