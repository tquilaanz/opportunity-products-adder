public class OpportunityService {
    public Opportunity getOpportunity(Id recordId){
        List<Opportunity> opportunities = OpportunitySelector.getOpportunitiesById(recordId);
        Opportunity opportunity = new Opportunity();
        
        if(!opportunities.isEmpty()){
            opportunity = opportunities.get(0);
        }
        
        return opportunity;
    }

}