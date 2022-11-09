-- =============================================
-- Author: <Author,,Name>
-- Create date: <Create Date,,>
-- Description: <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Z_GWA_EXPCMS_S_iCUBE]
	@cmsBaseDate date ,
	@cmsBaseDay int
AS
BEGIN
	SELECT	CARD_NO AS cardNum /* 카드번호 */
	        , APPR_NO AS authNum /* 승인번호 */
	        , APPR_DATE AS authDate /* 승인일자 */
	        , REPLACE(APPR_TIME, ':', '') AS authTime /* 승인시간 */
	        , REPLACE ( CARD_NO + APPR_DATE + APPR_NO + CAST(APPR_SEQ AS NVARCHAR), ' ', '' ) AS georaeColl /* 거래번호 */
	        , CANCEL_YN AS georaeStat /* 거래상태 */
	        , ( CASE WHEN UPPER(CANCEL_YN) = N'Y' THEN APPR_DATE ELSE '' END ) AS georaeCand /* 승인취소일자 */
	        , ISNULL(APPR_AMT,0) AS requestAmount /* 총금액 */
	        , (ISNULL(APPR_AMT,0) - ISNULL(APPR_TAX,0)) AS amtAmount /* 공급가액 */
	        , ISNULL(APPR_TAX,0) AS vatAmount /* 부가세액 */
	        , '0.00' AS serAmount /* 서비스금액 */
	        , '0.0' AS freAmount
	        , (ISNULL(APPR_AMT,0) - ISNULL(APPR_TAX,0)) AS amtMdAmount /* 공급가액 */
	        , ISNULL(APPR_TAX,0) AS vatMdAmount /* 부가세액 */
	        , 'KRW' AS georaeGukga /* 거래국가 */
	        , '0.0' AS forAmount
	        , '0.0' AS usdAmount
	        , CHAIN_NAME AS mercName /* 거래처명 */
	        , CHAIN_REG_NB AS mercSaupNo /* 거래처사업자등록번호 */
	        , '' AS mercAddr /* 거래처주소 */
	        , '' AS mercRepr /* 거래처대표자명 */
	        , '' AS mercTel /* 거래처연락처 */
	        , '' AS mercZip /* 거래처우편번호 */
	        , '' AS mccName
	        , '' AS mccCode
	        , '' AS mccStat
	        , '' AS vatStat
	        , '' AS gongjeNoChk
	        , 'A' AS abroad /* 해외사용구분 */
	        , '' AS editedAction
	FROM	DZICUBE.dbo.VA_ZA_NHCMSCARDAPPR
	WHERE	APPR_DATE >= ( CASE WHEN @cmsBaseDate > CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) THEN @cmsBaseDate ELSE CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) END )
END