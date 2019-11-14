@isTest
public class OpportunityTriggerServicesTest {
    
    @testSetup static void createData(){
        
        Account account1 = new Account(Name = 'Test Account 1');
        insert account1;
        Opportunity opportunity1 = new Opportunity(AccountId = account1.Id, Name= 'Test Opportunity 1', CloseDate = date.newInstance(2020, 11, 21),
                                                   StageName = 'Proposal');
        insert opportunity1;
        Profile p = [SELECT Id FROM Profile WHERE Name='Custom: Sales Profile']; //make sure the profile has 'modify all' permission on opportunity
        User nonAdmin = new User(Alias = 'nonadmin', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', 
                          LastName='User', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles',UserName='NonAdminUser' + DateTime.now().getTime() + '@amazontest.com');
        insert nonAdmin;
    }
    
    @isTest static void preventDeletion(){
        string systemErrorMessage;
        String validationErrorMessage;
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE AccountId = :acc.Id LIMIT 1];
        
        User nonAdmin = [SELECT Id FROM User WHERE Alias = 'nonadmin' Limit 1];
        
        try{
           validationErrorMessage = 'FIELD_CUSTOM_VALIDATION_EXCEPTION, Opportunity cannot be deleted by non administrator users when Opporunity probablity is greater than 75%';
           System.runAs(nonAdmin){
                opp.StageName = 'Negotiation/Review';
       			opp.Probability = 90.0;
            	update opp;
            	delete opp;
            } 
        }catch(System.DmlException ex){
            systemErrorMessage = ex.getMessage();
        }
        
        System.assertEquals(true,systemErrorMessage.contains(validationErrorMessage),'Check preventDeletion() method' );
    }
}