trigger OpportunityTrigger on Opportunity (before delete) {

    OpportunityTriggerHandler handler = new OpportunityTriggerHandler(Trigger.old);
    
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            handler.beforeDelete();
        }
    }
}