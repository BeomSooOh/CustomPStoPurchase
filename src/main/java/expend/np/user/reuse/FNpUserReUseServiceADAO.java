package expend.np.user.reuse;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpUserReUseServiceADAO")
public class FNpUserReUseServiceADAO extends EgovComAbstractDAO {

	/* ## 품의서 ## */
	/* ## ################################################## ## */

	// SELECT
	public Object ConsDocSelect(Map<String, Object> p) throws Exception {
		// 품의서 정보 조회 ( t_exnp_consdoc )
		// parameters : consDocSeq
		return select("NpUserReUseA.ConsDocSelect", p);
	}

	public Object ConsGisuSelect(Map<String, Object> p) throws Exception {
		// 품의서 기수 정보 조회
		// parameters : consDocSeq
		return select("NpUserReUseA.ConsGisuSelect", p);
	}
	
	public Object ConsReUseFormInfoSelect(Map<String, Object> p) throws Exception {
		// 재기안 품의서 양식 정보 조회
		// parameters : oriApproKey, oriDocId, form_gb, copyApprovalLine, copyAttachFile, eaType
		return select("NpUserReUseA.ConsReUseFormInfoSelect", p);
	}

	// SELECT LIST
	public Object ConsHeadSelectList(Map<String, Object> p) throws Exception {
		// 품의서 헤더 정보 조회 ( t_exnp_conshead )
		// parameters : consDocSeq
		return list("NpUserReUseA.ConsHeadSelectList", p);
	}

	public Object ConsBudgetSelectList(Map<String, Object> p) throws Exception {
		// 품의서 예산 정보 조회 ( t_exnp_consbudget )
		// parameters : consDocSeq
		return list("NpUserReUseA.ConsBudgetSelectList", p);
	}

	public Object ConsTradeSelectList(Map<String, Object> p) throws Exception {
		// 품의서 채주 정보 조회 ( t_exnp_constrade )
		// parameters : consDocSeq
		return list("NpUserReUseA.ConsTradeSelectList", p);
	}
	
	public Object ConsItemSpecSelectList(Map<String, Object> p) throws Exception {
		// 품의서 물품명세 정보 조회 ( t_exnp_consitem )
		// parameters : consDocSeq
		return list("NpUserReUseA.ConsItemSpecSelectList", p);
	}

	// INSERT

	// UPDATE

	// DELETE

	/* ## 결의서 ## */
	/* ## ################################################## ## */

	// SELECT
	public Object ResDocSelect(Map<String, Object> p) throws Exception {
		// 결의서 정보 조회 ( t_exnp_resdoc )
		// parameters : resDocSeq
		return select("NpUserReUseA.ResDocSelect", p);
	}

	public Object ResGisuSelect(Map<String, Object> p) throws Exception {
		// 결의서 기수 정보 조회
		// parameters : resDocSeq
		return select("NpUserReUseA.ResGisuSelect", p);
	}

	// SELECT LIST
	public Object ResHeadSelectList(Map<String, Object> p) throws Exception {
		// 결의서 헤더 정보 조회 ( t_exnp_reshead )
		// parameters : resDocSeq
		return list("NpUserReUseA.ResHeadSelectList", p);
	}

	public Object ResBudgetSelectList(Map<String, Object> p) throws Exception {
		// 결의서 예산 정보 조회 ( t_exnp_resbudget )
		// parameters : resDocSeq
		return list("NpUserReUseA.ResBudgetSelectList", p);
	}

	public Object ResTradeSelectList(Map<String, Object> p) throws Exception {
		// 결의서 채주 정보 조회 ( t_exnp_restrade )
		// parameters : resDocSeq
		return list("NpUserReUseA.ResTradeSelectList", p);
	}

	public Object ResItemSpecSelectList(Map<String, Object> p) throws Exception {
		// 결의서 물품명세 정보 조회 ( t_exnp_resitem )
		// parameters : resDocSeq
		return list("NpUserReUseA.ResItemSpecSelectList", p);
	}
	// INSERT
	// UPDATE
	// DELETE

	/* ## 카드 ## */
	/* ## ################################################## ## */

	// SELECT
	public Object CardTmpSelect(Map<String, Object> p) throws Exception {
		// 카드 상신 여부 판단을 위한 카드 정보 조회
		return select("NpUserReUseA.CardTmpSelect", p);
	}

	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE

	/* ## 계산서 ## */
	/* ## ################################################## ## */

	// SELECT
	public Object ETaxTmpSelect(Map<String, Object> p) throws Exception {
		// 매입전자세금계산서 상신 여부 판단을 위한 계산서 정보 조회
		return select("NpUserReUseA.ETaxTmpSelect", p);
	}
	// SELECT LIST
	// INSERT
	// UPDATE
	// DELETE
}