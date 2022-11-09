USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_ACARD_SUNGIN_SELECT]    Script Date: 11/28/2016 11:38:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[P_GWG20_ACARD_SUNGIN_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[P_GWG20_ACARD_SUNGIN_SELECT]
GO

USE [DZICUBE]
GO

/****** Object:  StoredProcedure [dbo].[P_GWG20_ACARD_SUNGIN_SELECT]    Script Date: 11/28/2016 11:38:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[P_GWG20_ACARD_SUNGIN_SELECT]   
(
	@CO_CD			NVARCHAR(8), -- 회사코드
	@EMP_NO			NVARCHAR(50), -- 아이디
	@CARD_NB		NVARCHAR(50),
	@ISS_DT_FROM	NVARCHAR(8), -- 승인일자 FROM
	@ISS_DT_TO		NVARCHAR(8), -- 승인일자 TO
	@LANGKIND		NVARCHAR(10) = 'KR',
	@GW_STATE		NVARCHAR(2) = NULL,  -- 전표처리구분,
	@TR_CD		NVARCHAR(10) = NULL,  -- 카드코드,
	@TR_NM		NVARCHAR(60) = NULL -- 카드명
)
AS
BEGIN    
    SELECT  
		H.ISS_DT + '_' + CAST(ISS_SQ AS VARCHAR) + '_' + H.CO_CD AS PKEY,  
		H.CARD_NB					AS CARD_NB,             -- 카드번호  
        H.ISS_DT                    AS ISS_DT,              -- 승인일자  
        H.ISS_SQ                    AS ISS_SQ,              -- 번호  
        H.USER_DETAIL               AS USER_DETAIL,         -- 카드사용내역  
        H.CHAIN_NAME                AS CHAIN_NAME,          -- 가맹점명  
        H.CHAIN_REGNB                AS CHAIN_REGNB,          -- 가맹점등록번호
        H.SUNGIN_NB                 AS SUNGIN_NB,           -- 승인번호  
        H.ACCT_CD                   AS ACCT_CD,             -- 상대계정코드  
        ISNULL( H.SUNGIN_AM, 0 )    AS SUNGIN_AM,           -- 승인금액  
        ISNULL( H.VAT_AM, 0 )       AS VAT_AM,              -- 부가세  
        H.USER_TYPE                 AS USER_TYPE,           -- 할부개월수  
        CASE WHEN ( H.ISU_DT = '' OR ISNULL( H.ISU_DT, '00000000' ) = '00000000' )  
                    AND ISNULL( H.ISU_SQ, 0 ) = 0 THEN '0'  
             ELSE '1' END           AS SEND_YN,             -- 처리구분  
        H.ISU_DT                    AS ISU_DT,              -- 결의일자  
        H.ISU_SQ                    AS ISU_SQ,              -- 결의번호  
        ISNULL( H.DATA_FG, '0' )    AS DATA_FG,  
        CASE WHEN ISNULL( H.DATA_FG, '0' ) = '0' THEN 'CMS' ELSE 'EXCEL' END       AS DATA_FG_NM,  
        H.INSERT_ID, H.INSERT_DT, H.INSERT_IP,  
        H.MODIFY_ID, H.MODIFY_DT, H.MODIFY_IP,  
        ISNULL( H.SUNGIN_AM, 0 ) + ISNULL( H.VAT_AM, 0 ) AS TOT_AM,  
        H.MEMO_CD, H.CHECK_PEN,  
        H.GISU_DT,  
		H.GISU_SQ,  
        ISNULL(H.GW_STATE, '') GW_STATE,
        CASE 
			WHEN H.GW_STATE = '1' THEN CASE WHEN @LANGKIND = 'EN' THEN 'Approval is ongoing' WHEN @LANGKIND = 'JP' THEN '決裁中' ELSE '결재중' END
			WHEN H.GW_STATE = '2' THEN CASE WHEN @LANGKIND = 'EN' THEN 'Approval is compelted' WHEN @LANGKIND = 'JP' THEN '決裁完了' ELSE '결재완료' END
			ELSE CASE WHEN @LANGKIND = 'EN' THEN 'Not submitted' WHEN @LANGKIND = 'JP' THEN '未上申' ELSE '미상신' END END AS GW_STATE_HAN,
		@TR_CD AS CARD_CD,	
		@TR_NM AS CARD_NM
    FROM      
		ACARD_SUNGIN H (NOLOCK)  
    WHERE     
			H.CO_CD = @CO_CD  
		AND H.CARD_NB = @CARD_NB  
        AND H.ISS_DT BETWEEN REPLACE(@ISS_DT_FROM, '-', '') AND REPLACE(@ISS_DT_TO, '-', '')   
        --AND @GW_STATE IS NULL OR (H.GW_STATE = @GW_STATE)  
    ORDER BY   
		H.ISS_DT, H.ISS_SQ  

END


GO


