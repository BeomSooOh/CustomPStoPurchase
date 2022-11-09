USE [DZICUBE]
GO

/****** Object:  UserDefinedFunction [dbo].[F_GWG20_COMMON_BY_BUDGET_INFO]    Script Date: 12/06/2016 17:30:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*************************************************************************/        
-- 설    명 : 자산관리 - 예산조회 - 함수        
-- 수 정 자 : 이혜영        
-- 수정일자 : 2014/05/13
-- 수정내역 : F_GWG20_COMMON_BY_BUDGET_INFO 예산단계 변경으로 새로만듬
/*         
SELECT * FROM F_GWG20_COMMON_BY_BUDGET_INFO ('2000','1000','2101','100090206','20100823', 0)        
*/        
/*************************************************************************/        
        
        
CREATE FUNCTION [dbo].[F_GWG20_COMMON_BY_BUDGET_INFO]        
(        
   @CO_CD      NVARCHAR(4)  -- 회사코드 (필수 PK)        
    , @DIV_CD     NVARCHAR(4)  -- 회계단위 (필수 PK)            
    , @MGT_CD     NVARCHAR(10) -- 예산통제방법에 따른 부서코드 또는 프로젝트코드             
    , @BGT_CD     NVARCHAR(10) -- 예산과목         
    , @GISU_DT NVARCHAR(16)        
 , @SUM_CT_AM NUMERIC(21,4) -- 금회 요청금액          
 , @BOTTOM_CD NVARCHAR(10)    
 , @LANGKIND  NVARCHAR(10) = 'KR'    
)         
RETURNS  @result TABLE         
(        
 CTL_FG    NVARCHAR(1),        
 FR_DT    NVARCHAR(16),        
 TO_DT    NVARCHAR(16),        
 BGT01_CD   NVARCHAR(20),        
 BGT01_NM   NVARCHAR(60),                               
 BGT02_CD   NVARCHAR(20),           
 BGT02_NM   NVARCHAR(60),                               
 BGT03_CD   NVARCHAR(20),           
 BGT03_NM   NVARCHAR(60),                               
 BGT04_CD   NVARCHAR(20),          
 BGT04_NM   NVARCHAR(60),     
 BGT_CD   NVARCHAR(20),          
 BGT_NM   NVARCHAR(60),                           
 SUNGIN_AM   NUMERIC(38,0),                               
 SUNGIN_DELAY_AM  NUMERIC(38,0),                          
 SUM_CT_AM   NUMERIC(38,0),                        
 LEFT_AM2            NUMERIC(38,0),        
 OPEN_AM             NUMERIC(38,0),                            
 ACCEPT_AM           NUMERIC(38,0),        
 APPLY_AM            NUMERIC(38,0),        
 LEFT_AM    NUMERIC(38,0)   ,      
 GR_FG   NVARCHAR(2),
 LEVEL01_CD NVARCHAR(10),  
 LEVEL02_CD NVARCHAR(10),  
 LEVEL03_CD NVARCHAR(10), 
 LEVEL04_CD NVARCHAR(10), 
 LEVEL05_CD NVARCHAR(10), 
 LEVEL06_CD NVARCHAR(10), 
 LEVEL01_NM NVARCHAR(30), 
 LEVEL02_NM NVARCHAR(30), 
 LEVEL03_NM NVARCHAR(30), 
 LEVEL04_NM NVARCHAR(30),
 LEVEL05_NM NVARCHAR(30), 
 LEVEL06_NM NVARCHAR(30)     
)        
        
        
         
AS        
BEGIN        
          
  DECLARE @CTL_FG  NVARCHAR(2)        
  DECLARE @ISU_YM_FR NVARCHAR(16)        
  DECLARE @ISU_YM_TO NVARCHAR(16)        
  DECLARE @GISU_YEAR NVARCHAR(8)        
  DECLARE @GISU_MON  NVARCHAR(12)      
  DECLARE @GISU INT    
  DECLARE @GISU_FR_DT NVARCHAR(8)    
  DECLARE @GISU_TO_DT NVARCHAR(8)  
  DECLARE @YEAR_FR  NVARCHAR(6)
  DECLARE @YEAR_TO  NVARCHAR(6)
      
  SET @GISU = dbo.F_GWG20_COMMON_GET_GISU(@CO_CD, @GISU_DT)    
      
  SELECT @GISU_FR_DT = SUBSTRING(FR_DT, 1, 6), @GISU_TO_DT = SUBSTRING(TO_DT, 1, 6)    
  FROM SCO    
  WHERE CO_CD = @CO_CD    
  AND GISU = @GISU    
  
  SELECT @YEAR_FR = CONVERT(nvarchar(6),DATEADD(yy, @GISU-GISU ,CONVERT(datetime,FR_DT)),112),@YEAR_TO = CONVERT(nvarchar(6),DATEADD(yy, @GISU-GISU ,CONVERT(datetime,TO_DT)),112)
  FROM SCO    
  WHERE CO_CD = @CO_CD
          
  SELECT @CTL_FG = CTL_FG         
  FROM SBGTCD (NOLOCK)         
  WHERE CO_CD = @CO_CD AND BGT_CD = @BGT_CD        
      
  SET @GISU_YEAR = SUBSTRING(@GISU_DT, 1, 4)        
  SET @GISU_MON  = SUBSTRING(@GISU_DT, 1, 6)        
      
  IF (@GISU_FR_DT IS NULL)    
  BEGIN    
 SET @GISU_FR_DT = @YEAR_FR 
  END    
      
  IF (@GISU_TO_DT IS NULL)    
  BEGIN    
 SET @GISU_TO_DT = @YEAR_TO    
  END    
          
  IF @CTL_FG = '1'        
    BEGIN        
  --SET @ISU_YM_FR = @GISU_YEAR + '01'        
  --SET @ISU_YM_TO = @GISU_YEAR + '12'        
  SET @ISU_YM_FR = @GISU_FR_DT    
  SET @ISU_YM_TO = @GISU_TO_DT    
    END        
  ELSE IF @CTL_FG = '2' OR @CTL_FG = '5'        
    BEGIN        
  SET @ISU_YM_FR = @GISU_MON        
  SET @ISU_YM_TO = @GISU_MON        
    END        
  ELSE IF @CTL_FG = '3' OR @CTL_FG = '6'        
    BEGIN        
          
  DECLARE @MON INT        
 SET @MON = CAST(SUBSTRING(@GISU_MON, 5, 2)  AS INT)             
  --SET @MON = CAST(@GISU_MON AS INT)        
            
  IF @MON >= 1 AND @MON <= 3        
    BEGIN        
   SET @ISU_YM_FR = @GISU_YEAR + '01'        
   SET @ISU_YM_TO = @GISU_YEAR + '03'        
    END         
  ELSE IF @MON >= 4 AND @MON <= 6        
    BEGIN        
   SET @ISU_YM_FR = @GISU_YEAR + '04'        
   SET @ISU_YM_TO = @GISU_YEAR + '06'        
    END           
  ELSE IF @MON >= 7 AND @MON <= 9        
    BEGIN        
   SET @ISU_YM_FR = @GISU_YEAR + '07'        
   SET @ISU_YM_TO = @GISU_YEAR + '09'        
    END            
  ELSE IF @MON >= 10 AND @MON <= 12        
    BEGIN        
   SET @ISU_YM_FR = @GISU_YEAR + '10'        
   SET @ISU_YM_TO = @GISU_YEAR + '12'        
    END         
 END            
 ELSE IF @CTL_FG = '4' OR @CTL_FG = '7'        
    BEGIN        
        -- 년누적        
  --SET @ISU_YM_FR = @GISU_YEAR + '01'        
  --SET @ISU_YM_TO = @GISU_YEAR + '12'        
  SET @ISU_YM_FR = @GISU_FR_DT    
  SET @ISU_YM_TO = @GISU_TO_DT    
    END         
 ELSE IF @CTL_FG = '8'        
    BEGIN        
        -- 월누적        
  --SET @ISU_YM_FR = @GISU_YEAR + '01'        
  SET @ISU_YM_FR = @GISU_FR_DT    
  SET @ISU_YM_TO = @GISU_MON        
    END             
 ELSE IF @CTL_FG = '9'        
    BEGIN        
        -- 월누적        
  --SET @ISU_YM_FR = @GISU_YEAR + '01'        
  --SET @ISU_YM_TO = @GISU_YEAR + '12'        
  SET @ISU_YM_FR = @GISU_FR_DT    
  SET @ISU_YM_TO = @GISU_TO_DT    
    END              
            
  DECLARE @BJ_YN     NVARCHAR(1),                     
          @BGT01_CD  NVARCHAR(10),        
          @BGT02_CD  NVARCHAR(10),        
          @BGT03_CD  NVARCHAR(10),        
          @BGT04_CD  NVARCHAR(10),        
          @BGT01_NM  NVARCHAR(30),        
          @BGT02_NM  NVARCHAR(30),        
          @BGT03_NM  NVARCHAR(30),        
          @BGT04_NM  NVARCHAR(30),  
          @BGT_NM    NVARCHAR(30),        
          @SUM_AM    NUMERIC(21,4),         
          @CONTROL_FG  NVARCHAR(1),        
          @BOTTOM_YN   NVARCHAR(1),        
          @BULYONG_YN  NVARCHAR(1),   
          @SYSCFG_4_63   NVARCHAR(1),               
          @GR_FG     NVARCHAR(2), 
          @LEVEL01_CD NVARCHAR(10),
          @LEVEL02_CD NVARCHAR(10),
          @LEVEL03_CD NVARCHAR(10),
          @LEVEL04_CD NVARCHAR(10),
          @LEVEL05_CD NVARCHAR(10),
          @LEVEL06_CD NVARCHAR(10),
          @LEVEL01_NM NVARCHAR(30),  
          @LEVEL02_NM NVARCHAR(30),  
          @LEVEL03_NM NVARCHAR(30),  
          @LEVEL04_NM NVARCHAR(30),  
          @LEVEL05_NM NVARCHAR(30),  
          @LEVEL06_NM NVARCHAR(30),                  
          @P_ERR_MSG   NVARCHAR(255) --에러메시지         
         
  SELECT @BJ_YN  = USE_YN FROM SYSCFG WHERE CO_CD=@CO_CD AND MODULE_CD='4' AND CTR_CD='10'      -- 배정사용여부 0.배정미사용 1.배정사용                   
  SELECT @CONTROL_FG = USE_YN FROM SYSCFG WHERE CO_CD=@CO_CD AND MODULE_CD='4' AND CTR_CD='12' -- 예산통제 사용여부         
  SELECT @BOTTOM_YN = USE_YN FROM SYSCFG WHERE CO_CD=@CO_CD AND MODULE_CD='4' AND CTR_CD='14'   -- 하위사업 사용여부 0.미사용 1.사용         
  SELECT @BULYONG_YN = USE_YN FROM SYSCFG WHERE CO_CD=@CO_CD AND MODULE_CD='4' AND CTR_CD='11'  -- 불용금액 사용여부 0.미사용 1.사용
  SELECT @SYSCFG_4_63 = ISNULL( USE_YN, '0' ) FROM SYSCFG WHERE CO_CD = @CO_CD AND MODULE_CD = '4' AND CTR_CD = '63'         
          
  -- 금회 승인 요청액 위해 따로 계산         
          
  -- 품의 예산 통제 여부        
  IF ( @CONTROL_FG = '0' )        
  BEGIN         
    SET @SUM_AM = 0        
  END         
  ELSE         
  BEGIN           
     -- 해당 기간 전체전송인 데이터의 금액 SUM        
             
     SELECT @SUM_AM = ISNULL(SUM(D.CT_AM),0)        
       FROM ABIN AS H        
            LEFT OUTER JOIN ABIND AS D        
                         ON H.CO_CD = D.CO_CD        
                        AND H.DIV_CD = D.DIV_CD        
                        AND H.GET_NO = D.GET_NO        
      WHERE H.CO_CD = @CO_CD        
        AND H.DIV_CD = @DIV_CD        
        AND H.MGT_CD = @MGT_CD        
        AND ( CASE WHEN @BOTTOM_YN = '0' THEN 1        
                   WHEN @BOTTOM_YN = '1' AND H.BOTTOM_CD = @BOTTOM_CD THEN 1        
                   ELSE 0 END ) = 1        
        AND H.BGT_CD = @BGT_CD        
        AND SUBSTRING(H.GET_DT, 1, 6) >= @ISU_YM_FR AND SUBSTRING(H.GET_DT, 1, 6) <= @ISU_YM_TO        
        AND ISNULL(H.GISU_DT, '') = ''        
        AND H.ADMIT_YN = '1'        
         
     -- 해당 기간 부분 전송 결의전송된 데이터의 금액 SUM 빼기         
     SELECT @SUM_AM = ISNULL(@SUM_AM, 0) - ISNULL(SUM(D.TR_PART_AM),0)        
       FROM ABIN AS T        
            INNER JOIN ABIN_PART_H AS H        
                         ON H.CO_CD = T.CO_CD        
                        AND H.DIV_CD = T.DIV_CD        
                        AND H.GET_NO = T.GET_NO                               
                        AND ISNULL(H.GISU_DT, '') <> ''        
            LEFT OUTER JOIN ABIN_PART_D AS D        
                         ON H.CO_CD = D.CO_CD        
                        AND H.DIV_CD = D.DIV_CD        
                        AND H.GET_NO = D.GET_NO        
                        AND H.PART_DT = D.PART_DT        
                        AND H.PART_SQ = D.PART_SQ        
      WHERE T.CO_CD = @CO_CD        
        AND T.DIV_CD = @DIV_CD        
        AND T.MGT_CD = @MGT_CD        
        AND ( CASE WHEN @BOTTOM_YN = '0' THEN 1        
                 WHEN @BOTTOM_YN = '1' AND T.BOTTOM_CD = @BOTTOM_CD THEN 1        
                   ELSE 0 END ) = 1        
        AND T.BGT_CD = @BGT_CD        
        AND SUBSTRING(T.GET_DT, 1, 6) >= @ISU_YM_FR AND SUBSTRING(T.GET_DT, 1, 6) <= @ISU_YM_TO        
        AND ISNULL(T.GISU_DT, '') = ''        
        AND T.ADMIT_YN = '1'        
        AND T.PART_YN = '2'           
  END             
         
    -- 예산 과목명 조회        
    SELECT @BGT01_CD = CASE WHEN B.DIV_FG = 1 THEN B.BGT_CD  ELSE B1.BGT_CD   END,       
           @BGT01_NM = CASE WHEN B.DIV_FG = 1 THEN B.BGT_NM  ELSE B1.BGT_NM   END,  
           @BGT02_CD = CASE WHEN B.DIV_FG = 2 THEN B.BGT_CD  ELSE B2.BGT_CD   END,        
           @BGT02_NM = CASE WHEN B.DIV_FG = 2 THEN B.BGT_NM  ELSE B2.BGT_NM   END,
           @BGT03_CD = CASE WHEN B.DIV_FG = 3 THEN B.BGT_CD  ELSE B3.BGT_CD   END,        
           @BGT03_NM = CASE WHEN B.DIV_FG = 3 THEN B.BGT_NM  ELSE B3.BGT_NM   END,
           @BGT04_CD = CASE WHEN B.DIV_FG = 4 THEN B.BGT_CD  ELSE NULL END,         
           @BGT04_NM = CASE WHEN B.DIV_FG = 4 THEN B.BGT_NM  ELSE NULL END,  
           --@BGT_CD = B.BGT_CD,  
           @BGT_NM = B.BGT_NM,      
           @GR_FG = B.GR_FG,
           @LEVEL01_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '1' THEN LM.LEVEL_CD ELSE L1.LEVEL_CD END,  
           @LEVEL02_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '2' THEN LM.LEVEL_CD ELSE L2.LEVEL_CD END,  
           @LEVEL03_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '3' THEN LM.LEVEL_CD ELSE L3.LEVEL_CD END,  
           @LEVEL04_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '4' THEN LM.LEVEL_CD ELSE L4.LEVEL_CD END,  
           @LEVEL05_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '5' THEN LM.LEVEL_CD ELSE L5.LEVEL_CD END,  
           @LEVEL06_CD = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '6' THEN LM.LEVEL_CD ELSE NULL END,  
           @LEVEL01_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '1' THEN LM.LEVEL_NM ELSE L1.LEVEL_NM END,  
           @LEVEL02_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '2' THEN LM.LEVEL_NM ELSE L2.LEVEL_NM END,  
           @LEVEL03_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '3' THEN LM.LEVEL_NM ELSE L3.LEVEL_NM END,  
           @LEVEL04_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '4' THEN LM.LEVEL_NM ELSE L4.LEVEL_NM END,  
           @LEVEL05_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '5' THEN LM.LEVEL_NM ELSE L5.LEVEL_NM END,  
           @LEVEL06_NM = CASE WHEN ISNULL( LM.DIV_FG, '' ) = '6' THEN LM.LEVEL_NM ELSE NULL END
    FROM   SBGTCD B        
           LEFT OUTER JOIN SBGTCD B1        
           ON  B.CO_CD    = B1.CO_CD        
           AND B.HBGT_CD1 = B1.BGT_CD        
           LEFT OUTER JOIN SBGTCD B2        
           ON  B.CO_CD    = B2.CO_CD        
           AND B.HBGT_CD2 = B2.BGT_CD        
           LEFT OUTER JOIN SBGTCD B3        
           ON  B.CO_CD    = B3.CO_CD        
           AND B.HBGT_CD3 = B3.BGT_CD
           LEFT OUTER JOIN ZN_SBGTLEVEL_D LD  
           ON  @SYSCFG_4_63 = '1'  
           AND B.CO_CD = LD.CO_CD  
           AND LD.GISU = @GISU  
           AND ( B.BGT_CD = LD.BGT_CD OR  
           B.HBGT_CD1 = LD.BGT_CD )  
           LEFT OUTER JOIN ZN_SBGTLEVEL LM  
           ON  LD.CO_CD = LM.CO_CD  
           AND LD.GISU = LM.GISU  
           AND LD.LEVEL_CD = LM.LEVEL_CD  
           LEFT OUTER JOIN ZN_SBGTLEVEL L1  
           ON  ISNULL( LM.HLEVEL_CD1, '' ) <> ''  
           AND LM.CO_CD = L1.CO_CD  
           AND LM.GISU = L1.GISU  
           AND LM.HLEVEL_CD1 = L1.LEVEL_CD  
           LEFT OUTER JOIN ZN_SBGTLEVEL L2  
           ON  ISNULL( LM.HLEVEL_CD2, '' ) <> ''  
           AND LM.CO_CD = L2.CO_CD  
           AND LM.GISU = L2.GISU  
           AND LM.HLEVEL_CD2 = L2.LEVEL_CD  
           LEFT OUTER JOIN ZN_SBGTLEVEL L3  
           ON  ISNULL( LM.HLEVEL_CD3, '' ) <> ''  
           AND LM.CO_CD = L3.CO_CD  
           AND LM.GISU = L3.GISU  
           AND LM.HLEVEL_CD3 = L3.LEVEL_CD  
           LEFT OUTER JOIN ZN_SBGTLEVEL L4  
           ON  ISNULL( LM.HLEVEL_CD4, '' ) <> ''  
           AND LM.CO_CD = L4.CO_CD  
           AND LM.GISU = L4.GISU  
           AND LM.HLEVEL_CD4 = L4.LEVEL_CD  
           LEFT OUTER JOIN ZN_SBGTLEVEL L5  
           ON  ISNULL( LM.HLEVEL_CD5, '' ) <> ''  
           AND LM.CO_CD = L5.CO_CD  
           AND LM.GISU = L5.GISU  
           AND LM.HLEVEL_CD5 = L5.LEVEL_CD                   
    WHERE  B.CO_CD = @CO_CD        
      AND  B.BGT_CD = @BGT_CD        
          
  -- 카드연동 예산 조회    
  SELECT @SUM_AM = @SUM_AM + ISNULL(SUM(A.SUNGIN_AM), 0)    
  FROM ACARD_SUNGIN A    
  INNER JOIN (    
 SELECT AH.CO_CD, AH.BANK_DT, AH.BANK_SQ    
 FROM ABDOCU_CMS_H AH    
 INNER JOIN ABDOCU_CMS_B AB ON (AH.CO_CD = AB.CO_CD AND AH.BANK_DT = AB.BANK_DT AND AH.BANK_SQ = AB.BANK_SQ AND AH.TRAN_CD = AB.TRAN_CD)    
 WHERE AH.CO_CD = @CO_CD    
 AND AH.MGT_CD = @MGT_CD    
 AND AB.ABGT_CD = @BGT_CD    
 AND AH.TRAN_CD = '301'    
 AND SUBSTRING(AH.GISU_DT, 1, 6) >= @ISU_YM_FR AND SUBSTRING(AH.GISU_DT, 1, 6) <= @ISU_YM_TO        
  ) B ON (A.CO_CD = B.CO_CD AND A.ISS_DT = B.BANK_DT AND A.ISS_SQ = B.BANK_SQ)    
  WHERE A.GW_STATE IS NOT NULL AND A.GW_STATE <> ''    
  AND A.GW_ID IS NOT NULL AND A.GW_ID <> ''    
  AND (A.GISU_DT IS NULL OR A.GISU_DT = '')    
  AND (A.GISU_SQ IS NULL OR A.GISU_DT = 0)    
      
  SELECT @SUM_AM = @SUM_AM + ISNULL(SUM(A.DR_AM), 0)    
  FROM SACBANKH A    
  INNER JOIN (    
 SELECT AH.CO_CD, AH.BANK_DT, AH.BANK_SQ    
 FROM ABDOCU_CMS_H AH    
 INNER JOIN ABDOCU_CMS_B AB ON (AH.CO_CD = AB.CO_CD AND AH.BANK_DT = AB.BANK_DT AND AH.BANK_SQ = AB.BANK_SQ AND AH.TRAN_CD = AB.TRAN_CD)    
 WHERE AH.CO_CD = @CO_CD    
 AND AH.MGT_CD = @MGT_CD    
 AND AB.ABGT_CD = @BGT_CD    
 AND AH.TRAN_CD = '000'    
 AND SUBSTRING(AH.GISU_DT, 1, 6) >= @ISU_YM_FR AND SUBSTRING(AH.GISU_DT, 1, 6) <= @ISU_YM_TO        
  ) B ON (A.CO_CD = B.CO_CD AND A.BANK_DT = B.BANK_DT AND A.BANK_SQ = B.BANK_SQ)    
  WHERE A.GW_STATE IS NOT NULL AND A.GW_STATE <> ''    
  AND A.GW_ID IS NOT NULL AND A.GW_ID <> ''    
  AND (A.GISU_DT IS NULL OR A.GISU_DT = '')    
  AND (A.GISU_SQ IS NULL OR A.GISU_DT = 0)         
  AND (A.GISU_SQ IS NULL OR A.GISU_DT = 0)         
         
  -- 실제 예산액 조회        
  INSERT INTO @RESULT (CTL_FG, FR_DT, TO_DT, BGT01_CD,BGT01_NM, BGT02_CD, BGT02_NM, BGT03_CD, BGT03_NM, BGT04_CD, BGT04_NM, BGT_CD, BGT_NM, SUNGIN_AM, SUNGIN_DELAY_AM, SUM_CT_AM, LEFT_AM2, OPEN_AM, ACCEPT_AM, APPLY_AM, LEFT_AM, GR_FG, 
  LEVEL01_CD, LEVEL02_CD, LEVEL03_CD, LEVEL04_CD, LEVEL05_CD, LEVEL06_CD, LEVEL01_NM, LEVEL02_NM, LEVEL03_NM, LEVEL04_NM, LEVEL05_NM, LEVEL06_NM)        
      SELECT @CTL_FG, @ISU_YM_FR, @ISU_YM_TO, @BGT01_CD, @BGT01_NM, @BGT02_CD, @BGT02_NM, @BGT03_CD, @BGT03_NM, @BGT04_CD, @BGT04_NM, @BGT_CD, @BGT_NM ,      
            SUM(ISNULL(ACCT_AM4,0)) - CASE WHEN @BULYONG_YN='0' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
                                    + CASE WHEN @BULYONG_YN='1' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END        
             AS SUNGIN_AM, -- 기집행액        
            SUM(ISNULL(ACCT_AM1,0)) + SUM(ISNULL(ACCT_AM2,0)) + SUM(ISNULL(ACCT_AM3,0)) , --AS SUNGIN_DELAY_AM, -- 승인대기액        
            ISNULL(@SUM_CT_AM, 0), -- AS SUM_CT_AM, -- 금회승인요청액        
            SUM(ISNULL(A.CARR_AM,0)) +  SUM(ISNULL(A.BUD_AM,0))        
             - (SUM(ISNULL(ACCT_AM4,0)) - CASE WHEN @BULYONG_YN='0' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
                                        + CASE WHEN @BULYONG_YN='1' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END)        
             - (SUM(ISNULL(ACCT_AM1,0)) + SUM(ISNULL(ACCT_AM2,0)) + SUM(ISNULL(ACCT_AM3,0)))        
             - ISNULL(@SUM_CT_AM, 0)        
             , --AS LEFT_AM2,  -- 예산잔액2        
         
            SUM(ISNULL(A.CARR_AM,0)) +  SUM(ISNULL(A.BUD_AM,0)), -- AS OPEN_AM,            -- 예산액 ( 이월예산 + 편성예산 )         
   SUM(CASE WHEN @BJ_YN='0' THEN 0 ELSE  ISNULL(ALLOC_AM,0) END ) ACCEPT_AM , -- 배정액                
      SUM(ISNULL(ACCT_AM1,0)) + SUM(ISNULL(ACCT_AM2,0)) + SUM(ISNULL(ACCT_AM3,0)) + SUM(ISNULL(ACCT_AM4,0))         
             - CASE WHEN @BULYONG_YN='0' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
             + CASE WHEN @BULYONG_YN='1' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
             + ISNULL(@SUM_AM,0), -- AS APPLY_AM,  -- 집행액 ( 지출 + 원인 + 미결 + 승인 +(-) 불용 + 품의총금액)        
   SUM(CASE WHEN @BJ_YN='0' THEN ISNULL(A.CARR_AM,0) + ISNULL(A.BUD_AM,0) ELSE ISNULL(ALLOC_AM,0) END )         
             - ( SUM(ISNULL(ACCT_AM1,0)) + SUM(ISNULL(ACCT_AM2,0)) + SUM(ISNULL(ACCT_AM3,0)) + SUM(ISNULL(ACCT_AM4,0))         
                  - CASE WHEN @BULYONG_YN='0' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
                  + CASE WHEN @BULYONG_YN='1' THEN SUM(ISNULL(ACCT_AM6,0)) ELSE 0 END         
                  + ISNULL(@SUM_AM,0) ) -- AS LEFT_AM -- 예산잔액 ( 예산액 OR 배정액 - 집행액 )                
                  , @GR_FG , @LEVEL01_CD, @LEVEL02_CD, @LEVEL03_CD, @LEVEL04_CD, @LEVEL05_CD, @LEVEL06_CD, @LEVEL01_NM, @LEVEL02_NM, @LEVEL03_NM, @LEVEL04_NM, @LEVEL05_NM, @LEVEL06_NM     
    FROM ( SELECT SUM(V.CARR_AM) CARR_AM,         
            SUM( CASE WHEN @BJ_YN ='0' THEN CASE WHEN V.BJ_YN='0' THEN (V.CF_AM    + V.ADD_AM0 + V.ADD_AM1 + V.ADD_AM2 + V.ADD_AM3) ELSE 0 END         
                ELSE CASE WHEN V.BJ_YN='1' THEN (V.REQCF_AM + V.ADD_AM0 + V.ADD_AM1 + V.ADD_AM2 + V.ADD_AM3) ELSE 0 END END  ) BUD_AM,         
            SUM( CASE WHEN V.BJ_YN='1' THEN  V.CF_AM  ELSE 0 END ) AS ALLOC_AM,              
            SUM((CASE WHEN V.ACCT_GB IN ( '23' ) AND V.FILL_DT <> ''  THEN  CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM1,            
            SUM((CASE WHEN V.ACCT_GB IN ( '24' ) AND V.FILL_DT <> ''  THEN  CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM2,         
            SUM((CASE WHEN V.ACCT_GB IN ( '22' ) AND V.FILL_DT <> ''  THEN  CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM3,         
            SUM((CASE WHEN V.ACCT_GB IN ('21','31' ) THEN  CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM4 ,        
            SUM((CASE WHEN V.ACCT_GB IN ('31') THEN CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM6,        
            SUM((CASE WHEN V.ACCT_GB IN ('31') THEN CASE WHEN D.IN_TAX = '0' THEN V.ACCT_AM ELSE V.ACCT_AM-V.VAT_AM END  ELSE 0 END)) ACCT_AM7         
          FROM BUDGETSUM V          
            INNER JOIN SDIV D ON V.CO_CD = D.CO_CD AND V.DIV_CD = D.DIV_CD          
         WHERE V.CO_CD = @CO_CD         
        AND V.DIV_CD = @DIV_CD        
        AND V.MGT_CD = @MGT_CD           
        AND V.ISU_YM >= @ISU_YM_FR        
                 AND V.ISU_YM <= @ISU_YM_TO         
        AND V.BGT_CD IN ( SELECT DISTINCT CASE WHEN SB.DIV_FG <= AB.CTR_FG THEN SB.BGT_CD         
                    WHEN AB.CTR_FG ='1' THEN SB.HBGT_CD1         
                    WHEN AB.CTR_FG ='2' THEN SB.HBGT_CD2         
                    WHEN AB.CTR_FG ='3' THEN SB.HBGT_CD3        
                    ELSE SB.BGT_CD END         
                FROM SBGTCD SB         
                                          INNER JOIN SCO SC ON SB.CO_CD = SC.CO_CD         
                  LEFT OUTER JOIN ABSDOCU AB ON SB.CO_CD = AB.CO_CD AND AB.ACCTDEF_FG = SC.ACCT_FG        
              WHERE SB.CO_CD =@CO_CD AND SB.BGT_CD =@BGT_CD )            
        AND ( CASE WHEN @BOTTOM_YN = '1' AND V.BOTTOM_CD <> @BOTTOM_CD THEN '0'         
             ELSE '1' END ) = '1'           
        ) A        
         
                 
         
  RETURN        
         
END        

GO