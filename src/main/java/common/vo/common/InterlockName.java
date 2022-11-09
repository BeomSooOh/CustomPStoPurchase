package common.vo.common;

import common.helper.convert.CommonConvert;

public enum InterlockName {
    PREVIOUSBUTTONKR("이전단계"), PREVIOUSBUTTONEN("previous step"), PREVIOUSBUTTONJP("以前段階"), PREVIOUSBUTTONCN("以前阶段"), EDITINFOBUTTONKR("정보수정"), EDITINFOBUTTONEN("Edit information"), EDITINFOBUTTONJP("情報修正"), EDITINFOBUTTONCN("信息修改");

    private String interlockName;

    InterlockName(String name) {
        this.interlockName = name;
    }

    @Override
    public String toString() {
        return CommonConvert.CommonGetStr(this.interlockName);
    }

}


