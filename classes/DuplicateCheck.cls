public class DuplicateCheck {
    
    List<Lead> newleads = getNewLeads();
    Map<Boolean, List<Lead>> leadResults = leadDuplicateCheck(newLeads);
    
    List<Lead> getNewLeads(){
        return new List<Lead>();
    } 
    
    private Map<Boolean, List<Lead>> leadDuplicateCheck(List<Lead> leads){
        List<Lead> existingLead = new  List<Lead>();
        Map<Boolean, List<Lead>> output = new Map<Boolean, List<Lead>>();
        output.put(True,new List<Lead>());
        output.put(False,new List<Lead>());
        
        Set<String> email = new Set<String>();
        Set<String> region = new Set<String>();
        Set<String> company = new Set<String>();
        
        for(Lead l: leads){
            email.add(l.Email);
            region.add(l.Territory__r.Region__c);
            company.add(l.Company);
        }
        
        email.remove(null);
        region.remove(null);
        company.remove(null);
        
        for(Lead exisiting:[Select Id,Email, Territory__r.Region__c, Company From Lead Where Email in :email OR company in :company OR Territory__r.Region__c in :region]){
            Territory__c territory = new Territory__c(Id = exisiting.Territory__c, Region__c = exisiting.Territory__r.Region__c.toLowerCase());
            existingLead.add(new Lead(Email = exisiting.Email.toLowerCase(),company = exisiting.Company.toLowerCase(),Territory__c = territory.Id));
        }
        
        for(Lead newLead: leads){
            Territory__c territory = new Territory__c(Id = newLead.Territory__c, Region__c = newLead.Territory__r.Region__c.toLowerCase());
            Lead l = new Lead(Email = newLead.Email.toLowerCase(), company = newLead.Company.toLowerCase(),Territory__c = territory.Id);
            output.get(!existingLead.contains(l)).add(newLead);
            existingLead.add(l);
        }
        
        return output;
    }
}