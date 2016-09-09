public class OpportunitySelector {
    private final static String Query_Raw = 'select Id, Name, PriceBook2Id from Opportunity ';
    
    public static List<Opportunity> getOpportunitiesById(Id opportunityId){
        String query = Query_Raw + 'where Id =: opportunityId';
        return Database.query(query);
    }

}