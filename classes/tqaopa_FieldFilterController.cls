public class tqaopa_FieldFilterController {
    public class OptionList{
        public OptionList(String label, String value, String type){
            this.label = label;
            this.value = value;
            this.type = type;
            this.selected = false;
        }
        @AuraEnabled
        public Boolean selected{set; get;}
        @AuraEnabled
        public String type {private set;get;}
        @AuraEnabled
        public String label {private set;get;}
        @AuraEnabled
        public String value {private set;get;}
    }
    
    
        
    @AuraEnabled
    public static OptionList[] getFieldOptions(String sobjectName){
        
        List<Schema.DescribeFieldResult> fieldList = tqaopa_GlobalUtility.getFieldApiNames(sobjectName);
        
        List<OptionList> options = new List<OptionList>();
        for(Schema.DescribeFieldResult fieldResult : fieldList){
            options.add(new OptionList( fieldResult.getLabel(), fieldResult.getName(), fieldResult.getType().name()));
        }
        return options;
    }

}