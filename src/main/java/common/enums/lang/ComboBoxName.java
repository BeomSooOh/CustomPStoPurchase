package common.enums.lang;

public enum ComboBoxName {
   COMBOBOXALLKR("전체"), COMBOBOXALLEN("전체"), COMBOBOXALLJP("전체"), COMBOBOXALLCN("전체");

    private String ComboBoxName;

    ComboBoxName(String name) {
        this.ComboBoxName = name;
    }

    @Override
    public String toString() {
        return this.ComboBoxName;
    }
}
