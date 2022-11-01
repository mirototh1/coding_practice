@IsTest
public with sharing class LeadDataFactory {

    public static Lead createLead() {
        return new Lead(FirstName = 'FirstName', LastName = 'LastName', Company = 'Test Company', Country = 'Czech Republic');
    }
}
