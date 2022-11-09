package common.vo.ex;

import java.util.ArrayList;
import java.util.List;


public class ExConfigItemListVO {

	private List<ExConfigItemVO> tVEX2_CONFIG_BASIC_ITEM;
	private List<ExConfigItemVO> tVEX2_CONFIG_SELECT_ITEM;

	public ExConfigItemListVO ( ) {
		tVEX2_CONFIG_BASIC_ITEM = new ArrayList<ExConfigItemVO>( );
		tVEX2_CONFIG_SELECT_ITEM = new ArrayList<ExConfigItemVO>( );
	}

	public void setConfigBasicItem ( List<ExConfigItemVO> mvex2ConfigBasicItem ) {
		this.tVEX2_CONFIG_BASIC_ITEM = mvex2ConfigBasicItem;
	}

	public List<ExConfigItemVO> getConfigBasicItem ( ) {
		return this.tVEX2_CONFIG_BASIC_ITEM;
	}

	public void setConfigSelectItem ( List<ExConfigItemVO> mvex2ConfigSelectItem ) {
		this.tVEX2_CONFIG_SELECT_ITEM = mvex2ConfigSelectItem;
	}

	public List<ExConfigItemVO> getConfigSelectItem ( ) {
		return this.tVEX2_CONFIG_SELECT_ITEM;
	}
}
