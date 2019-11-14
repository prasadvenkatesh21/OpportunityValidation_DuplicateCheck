public class OpportunityTriggerServices {
    
    public static void preventDeletion(list<Opportunity> oldOpportunity){
        String SYSADMINNAME = 'System Administrator';
        String profileName = [SELECT Id, Name FROM Profile where Id =:UserInfo.getProfileId()].Name;
        for(Opportunity opp: oldOpportunity){
            if( profileName != SYSADMINNAME && opp.Probability >= 75.0){
                opp.addError('Opportunity cannot be deleted by non administrator users when Opporunity probablity is greater than 75%');
            } 
        }
    }

}