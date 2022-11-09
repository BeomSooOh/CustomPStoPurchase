-- =============================================
-- Author:  <Author,,Name>
-- Create date: <Create Date,,>
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Z_GWA_EXPCMS_S_iCUBE]
 -- Add the parameters for the stored procedure here
 @cmsBaseDate NVARCHAR(8),  -- 연동시작 기준일
 @cmsBaseDay NVARCHAR(2) -- 연동시작 기준일자
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT	CARD_NO AS cardNo /* 카드번호 */
		, '' AS bankCode /* 금융기관코드 */
		, base.AUTH_DD AS apprDate /* 승인일자 */
		/* card_aq_tmp data */
		, CARD_NO AS cardNum /* 카드번호 */
		, base.AUTH_NO AS authNum /* 승인번호 */
		, base.AUTH_DD AS authDate /* 승인일자 */
		, AUTH_HH AS authTime /* 승인시간 */
		, REPLACE ( ( '' + ISNULL(CARD_NO,'') + ISNULL(base.AUTH_DD,'') + ISNULL(base.AUTH_NO,'') + ISNULL(CAST(APPR_SEQ as varchar(10)),'') ), ' ', '' ) AS georaeColl /* 거래번호(카드번호 + 승인일자 + 승인번호 + 승인일자별순번)*/
		/* 거래번호(카드번호 + 승인일자 + 승인번호 + 승인일자별순번)*/
		, CASE 
			WHEN BUY_STS ='01' THEN '1'
			ELSE '0' 
		END AS georaeStat /* 거래상태 */
		, ( CASE WHEN BUY_STS = '02' THEN base.AUTH_DD ELSE '' END ) AS georaeCand /* 승인취소일자 */
		, CAST(ROUND(AUTH_AMT, 0, 1) AS INT) AS requestAmount /* 총금액 */
		, CAST(ROUND(ISNULl(SUPP_PRICE, 0), 0, 1) AS INT) AS amtAmount /* 공급가액 */
		, CAST(ROUND(ISNULL(SURTAX, 0), 0, 1) AS INT) AS vatAmount /* 부가세액 */
		, '0.00' AS serAmount /* 서비스금액 */
		, '0.0' AS freAmount
		, CAST(ROUND(ISNULl(SUPP_PRICE, 0), 0 , 1) AS INT) AS amtMdAmount /* 공급가액 */
		, CAST(ROUND(ISNULL(SURTAX, 0), 0 , 1) AS INT) AS vatMdAmount /* 부가세액 */
		, 'KRW' AS georaeGukga /* 거래국가 */
		, '0.0' AS forAmount
		, '0.0' AS usdAmount
		, MER_NM AS mercName /* 거래처명 */
		, MER_BIZNO AS mercSaupNo /* 거래처사업자등록번호 */
		, '' AS mercAddr /* 거래처주소 */
		, '' AS mercRepr /* 거래처대표자명 */
		, '' AS mercTel /* 거래처연락처 */
		, '' AS mercZip /* 거래처우편번호 */
		, '' AS mccName
		, '' AS mccCode
		, '' AS mccStat
		, '' AS vatStat
		, CASE
			WHEN MER_CLOSE = '1' AND ISNULL(SURTAX, 0) > 0 THEN 'Y'
			ELSE 'N'
		END AS gongjeNoChk
		, 'A' AS abroad /* 해외사용구분 */
		, '' AS editedAction
 FROM	DZICUBE.dbo.HIST_CORPCD_USE base
 INNER JOIN (
	SELECT	AUTH_NO
			, AUTH_DD
			, BUY_CLT_NO
			, COUNT(*) AS APPR_SEQ
	from	DZICUBE.dbo.HIST_CORPCD_USE
	group by AUTH_NO, AUTH_DD, BUY_CLT_NO 
 ) APPR ON base.AUTH_NO = APPR.AUTH_NO AND base.AUTH_DD = APPR.AUTH_DD AND base.BUY_CLT_NO = APPR.BUY_CLT_NO
 WHERE   base.AUTH_DD >= ( CASE WHEN @cmsBaseDate > CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) THEN @cmsBaseDate ELSE CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) END )

UNION

 SELECT	CARD_NO AS cardNo /* 카드번호 */
		, '' AS bankCode /* 금융기관코드 */
		, base.AUTH_DD AS apprDate /* 승인일자 */
		/* card_aq_tmp data */
		, CARD_NO AS cardNum /* 카드번호 */
		, base.AUTH_NO AS authNum /* 승인번호 */
		, base.AUTH_DD AS authDate /* 승인일자 */
		, AUTH_HH AS authTime /* 승인시간 */
		, REPLACE ( ( '' + ISNULL(CARD_NO,'') + ISNULL(base.AUTH_DD,'') + ISNULL(base.AUTH_NO,'') + ISNULL(CAST(APPR_SEQ as varchar(10)),'') ), ' ', '' ) AS georaeColl /* 거래번호(카드번호 + 승인일자 + 승인번호 + 승인일자별순번)*/
		/* 거래번호(카드번호 + 승인일자 + 승인번호 + 승인일자별순번)*/
		, CASE 
			WHEN BUY_STS ='01' THEN '1'
			ELSE '0' 
		END AS georaeStat /* 거래상태 */
		, ( CASE WHEN BUY_STS = '02' THEN base.AUTH_DD ELSE '' END ) AS georaeCand /* 승인취소일자 */
		, CAST(ROUND(AUTH_AMT, 0, 1) AS INT) AS requestAmount /* 총금액 */
		, CAST(ROUND(ISNULl(SUPP_PRICE, 0), 0, 1) AS INT) AS amtAmount /* 공급가액 */
		, CAST(ROUND(ISNULL(SURTAX, 0), 0, 1) AS INT) AS vatAmount /* 부가세액 */
		, '0.00' AS serAmount /* 서비스금액 */
		, '0.0' AS freAmount
		, CAST(ROUND(ISNULl(SUPP_PRICE, 0), 0 , 1) AS INT) AS amtMdAmount /* 공급가액 */
		, CAST(ROUND(ISNULL(SURTAX, 0), 0 , 1) AS INT) AS vatMdAmount /* 부가세액 */
		, 'KRW' AS georaeGukga /* 거래국가 */
		, '0.0' AS forAmount
		, '0.0' AS usdAmount
		, MER_NM AS mercName /* 거래처명 */
		, MER_BIZNO AS mercSaupNo /* 거래처사업자등록번호 */
		, '' AS mercAddr /* 거래처주소 */
		, '' AS mercRepr /* 거래처대표자명 */
		, '' AS mercTel /* 거래처연락처 */
		, '' AS mercZip /* 거래처우편번호 */
		, '' AS mccName
		, '' AS mccCode
		, '' AS mccStat
		, '' AS vatStat
		, CASE
			WHEN MER_CLOSE = '1' AND ISNULL(SURTAX, 0) > 0 THEN 'Y'
			ELSE 'N'
		END AS gongjeNoChk
		, 'A' AS abroad /* 해외사용구분 */
		, '' AS editedAction
 FROM	DZICUBE.dbo.HIST_CORPCD_BUY base
 INNER JOIN (
	SELECT	AUTH_NO
			, AUTH_DD
			, BUY_CLT_NO
			, COUNT(*) AS APPR_SEQ
	from	DZICUBE.dbo.HIST_CORPCD_BUY
	group by AUTH_NO, AUTH_DD, BUY_CLT_NO 
 ) APPR ON base.AUTH_NO = APPR.AUTH_NO AND base.AUTH_DD = APPR.AUTH_DD AND base.BUY_CLT_NO = APPR.BUY_CLT_NO
 WHERE   base.AUTH_DD >= ( CASE WHEN @cmsBaseDate > CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) THEN @cmsBaseDate ELSE CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) END )

END
