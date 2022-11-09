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
	SELECT  CARD_NO AS cardNo /* 카드번호 */
	        , APPR_DATE AS apprDate /* 승인일자 */
	        , APPR_NO AS apprNo /* 승인번호 */
	        , APPR_AMT AS apprAmt /* 승인금액 */
	        , APPR_SEQ AS apprSeq /* 일련번호 */
	        
	        /* card_aq_tmp data */
	        , CARD_NO AS cardNum /* 카드번호 */
	        , APPR_NO AS authNum /* 승인번호 */
	        , APPR_DATE AS authDate /* 승인일자 */
	        , APPR_TIME AS authTime /* 승인시간 */
	        , REPLACE ( CARD_NO + APPR_DATE + APPR_NO + APPR_SEQ, ' ', '' ) AS georaeColl /* 거래번호 */
	        , CANCEL_YN AS georaeStat /* 거래상태 */
	        , ( CASE WHEN CANCEL_YN = 'y' THEN APPR_DATE ELSE '' END ) AS georaeCand /* 승인취소일자 */
	        , CAST(ROUND((ISNULL(APPR_AMT,0) + ISNULL(APPR_TAX,0)), 0, 1) AS INT) AS requestAmount /* 총금액 */
	        , CAST(ROUND(ISNULL(APPR_AMT,0), 0, 1) AS INT) AS amtAmount /* 공급가액 */
	        , CAST(ROUND(ISNULL(APPR_TAX,0), 0, 1) AS INT) AS vatAmount /* 부가세액 */
	        , CAST(ROUND(ISNULL(SERVICE_AM,0), 0, 1) AS INT) AS serAmount /* 서비스금액 */
	        , '0.0' AS freAmount
	        , CAST(ROUND(ISNULL(APPR_AMT,0), 0, 1) AS INT) AS amtMdAmount /* 공급가액 */
	        , CAST(ROUND(ISNULL(APPR_TAX,0), 0, 1) AS INT) AS vatMdAmount /* 부가세액 */
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
	        , DEDUCT_YN AS gongjeNoChk
	        , 'A' AS abroad /* 해외사용구분 */
	        , '' AS editedAction
	FROM    VA_ZA_HANACMSCARDAPPR
 	WHERE   APPR_DATE >= ( CASE WHEN @cmsBaseDate > CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) THEN @cmsBaseDate ELSE CONVERT ( NVARCHAR, DATEADD ( DAY, @cmsBaseDay * -1, GETDATE() ), 112 ) END )

END