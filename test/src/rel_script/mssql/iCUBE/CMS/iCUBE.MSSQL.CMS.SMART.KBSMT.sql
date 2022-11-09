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
	SELECT	BANK_CODE /* 금융기관코드(KEY) */
			, CARD_NO /* 카드번호(KEY) */
			, APPR_DATE /* 승인일자(KEY) */
			, APPR_SEQ /* 승인일자별순번(KEY) */
			
			/* card_aq_tmp data */
			, CARD_NO AS cardNum /* 카드번호(KEY) */
			, ISNULL(APPR_NO, '') AS authNum /* 승인번호 */
			, APPR_DATE AS authDate /* 승인일자(KEY) */
			, ISNULL(APPR_TIME, '000000') AS authTime /* 승인시간 */
			, REPLACE ( CONVERT(NVARCHAR, BANK_CODE) + CONVERT(NVARCHAR, CARD_NO) + CONVERT(NVARCHAR, APPR_DATE) + CONVERT(NVARCHAR, APPR_SEQ), ' ', '' ) AS georaeColl /* 거래번호 */
			, ISNULL(CANCEL_YN, '') AS georaeStat /* 승인/취소구분 */
			, ( CASE WHEN CANCEL_YN = 'Y' THEN APPR_DATE ELSE '' END ) AS georaeCand /* 승인취소일자 */
			, ISNULL(APPR_AMT, '0') AS requestAmount /* 승인금액 */
			, ISNULL(APPR_SUP, '0') AS amtAmount /* 공급가 */
			, ISNULL(APPR_TAX, '0') AS vatAmount /* 부가세 */
			, '0.00' AS serAmount /* 서비스금액 */
			, '0.0' AS freAmount
			, ISNULL(APPR_SUP, '0') AS amtMdAmount /* 공급가 */
			, ISNULL(APPR_TAX, '0') AS vatMdAmount /* 부가세 */
			, 'KRW' AS georaeGukga /* 거래국가 */
			, '0.0' AS forAmount
			, '0.0' AS usdAmount
			, REPLACE(ISNULL(CHAIN_NAME, ''), '''', '''''') AS mercName /* 가맹점명 */
			, ISNULL(CHAIN_REG_NB, '') AS mercSaupNo /* 가맹점사업자번호 */
			, ISNULL(CHAIN_ADDR, '') AS mercAddr /* 가맹점사업자주소 */
			, '' AS mercRepr /* 거래처대표자명 */
			, ISNULL(CHAIN_TEL, '') AS mercTel /* 가맹점사업장전화번호 */
			, '' AS mercZip /* 거래처우편번호 */
			, '' AS mccName
	        , '' AS mccCode
	        , '' AS mccStat
	        , '' AS vatStat
	        , CASE
				WHEN DEDUCT_YN = '0' THEN 'Y' /* 불공제 */
				WHEN DEDUCT_YN = '1' THEN 'N' /* 공제 */
				WHEN DEDUCT_YN = '2' THEN 'N' /* 미확인 > 공제 */
			END AS gongjeNoChk /* 공제여부 */
	FROM	VA_ZA_SMARTCMSCARDAPPR
	WHERE   APPR_DATE >= ( CASE WHEN '${cmsBaseDate}' > CONVERT ( NVARCHAR, DATEADD ( DAY, '${cmsBaseDay}' * -1, GETDATE() ), 112 ) THEN '${cmsBaseDate}' ELSE CONVERT ( NVARCHAR, DATEADD ( DAY, '${cmsBaseDay}' * -1, GETDATE() ), 112 ) END )
END