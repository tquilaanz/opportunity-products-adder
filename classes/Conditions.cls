public class Conditions {
    public String keyword {set;get;}
    public Map<String, Filter> criteriaMap {set;get;}
    
    public class Filter{
        public String fieldName {set;get;}
        public String fieldValue {set;get;}
        public String operator {set;get;} 
    }

}