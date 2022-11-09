USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BTR_CD_LIST]    Script Date: 11/28/2016 11:38:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_COMMON_BTR_CD_LIST]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_COMMON_BTR_CD_LIST]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_COMMON_BTR_CD_LIST]    Script Date: 11/28/2016 11:38:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*************************************************************************/            
--��    �� : ������Ʈ ����ݰ��� �ڵ帮��Ʈ
--�� �� �� : �����            
--�������� : 2010-08-25            
--�������� :             
/*************************************************************************/            

-- EXEC P_GWG20_COMMON_BTR_CD_LIST '2000'

CREATE PROCEDURE [dbo].[P_GWG20_COMMON_BTR_CD_LIST]
(
    @CO_CD     NVARCHAR(10)    -- 2.ȸ���ڵ�
)
 

 
AS

DECLARE @LANGKIND    NVARCHAR(3),     -- 0.�������( �ʼ�, KOR, CHS, ENG, JPN �� )
    @P_HELP_TY   NVARCHAR(20),    -- 1.����â Ÿ��
    @P_CODE      NVARCHAR(10),    -- 3.�ڵ尪1(�ڵ�˻��ÿ��� ���)
    @P_CODE2     NVARCHAR(4000),  -- 4.�ڵ尪2
    @P_CODE3     NVARCHAR(10),    -- 5.�ڵ尪3
    @P_USE_YN    NVARCHAR(1),     -- 6.��뿩��
    @P_NAME      NVARCHAR(50),    -- 7.�ڵ��(����â���� Ű���� �˻��ø� ���)
    @P_STD_DT    NVARCHAR(8),     -- 8.������
    @P_WHERE     NVARCHAR(4000),   -- 9.�߰�WHERE��
    @P_CO_CD	 NVARCHAR(4)

SELECT @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=@CO_CD, @P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5'' AND USE_YN = ''1'' '
   

BEGIN  
 
  DECLARE @P_ERR_MSG NVARCHAR(400)  -- ERROR MESSAGE  
  DECLARE @P_RETURN  INT
 
  SET NOCOUNT ON  
 
  EXEC @P_RETURN = DBO.USP_GET_HELPCODE_COMMON @LANGKIND, @P_HELP_TY, @P_CO_CD, @P_CODE, @P_CODE2, @P_CODE3, @P_USE_YN, @P_NAME, @P_STD_DT, @P_WHERE
 
  IF( @P_RETURN = 2 )
      EXEC @P_RETURN = DBO.USP_GET_HELPCODE_ACCOUNT @LANGKIND, @P_HELP_TY, @P_CO_CD, @P_CODE, @P_CODE2, @P_CODE3, @P_USE_YN, @P_NAME, @P_STD_DT, @P_WHERE 
 
  IF( @P_RETURN = 2 )
      EXEC @P_RETURN = DBO.USP_GET_HELPCODE_HUMAN @LANGKIND, @P_HELP_TY, @P_CO_CD, @P_CODE, @P_CODE2, @P_CODE3, @P_USE_YN, @P_NAME, @P_STD_DT, @P_WHERE 
 
  IF( @P_RETURN = 2 )
      EXEC @P_RETURN = DBO.USP_GET_HELPCODE_BPM @LANGKIND, @P_HELP_TY, @P_CO_CD, @P_CODE, @P_CODE2, @P_CODE3, @P_USE_YN, @P_NAME, @P_STD_DT, @P_WHERE 
 
  IF( @P_RETURN = 2 )
      EXEC @P_RETURN = DBO.USP_GET_HELPCODE_MCORE @LANGKIND, @P_HELP_TY, @P_CO_CD, @P_CODE, @P_CODE2, @P_CODE3, @P_USE_YN, @P_NAME, @P_STD_DT, @P_WHERE 
 
  IF( @P_RETURN = 2 )
  BEGIN
    SET @P_ERR_MSG = DBO.UFN_GET_STRING_BY_LANGKIND( @LANGKIND, 'HELP ID�� �������� �ʽ��ϴ�.' ) + CHAR(10) + 'HELP ID : ' + ISNULL(@P_HELP_TY, 'NULL')  
    GOTO ERROR  
  END  
 
  SET NOCOUNT OFF  
  
  RETURN  
  
ERROR:  
  SET NOCOUNT OFF  
  RAISERROR(@P_ERR_MSG, 16, 1)  
  RETURN  
 
END


GO


