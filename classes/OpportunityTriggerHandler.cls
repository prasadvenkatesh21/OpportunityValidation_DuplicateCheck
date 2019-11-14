public class OpportunityTriggerHandler {
    private final list<Opportunity> oldOpportunity;
    //constructor
    public OpportunityTriggerHandler (list<Opportunity> oldOpportunity){
        this.oldOpportunity = oldOpportunity;
    }
    
    public void beforeDelete(){
        OpportunityTriggerServices.preventDeletion(oldOpportunity);
    }

}