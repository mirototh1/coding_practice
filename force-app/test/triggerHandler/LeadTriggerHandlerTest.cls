@IsTest
public with sharing class LeadTriggerHandlerTest {

    @TestSetup
    private static void init() {
        insert LeadDataFactory.createLead();
    }
    
    @IsTest
    private static void assignCountryCodeTest() {
        Lead testLead = [SELECT ISO_Code_2__c, ISO_Code_3__c, Region__c, Capital__c FROM Lead LIMIT 1];

        System.assertEquals('CZ', testLead.ISO_Code_2__c);
        System.assertEquals('CZE', testLead.ISO_Code_3__c);
        System.assertEquals('Europe', testLead.Region__c);
        System.assertEquals('Prague', testLead.Capital__c);

        testLead.Country = 'Slovakia';
        update testLead;
        testLead = [SELECT ISO_Code_2__c, ISO_Code_3__c, Region__c, Capital__c FROM Lead LIMIT 1];

        System.assertEquals('SK', testLead.ISO_Code_2__c);
        System.assertEquals('SVK', testLead.ISO_Code_3__c);
        System.assertEquals('Europe', testLead.Region__c);
        System.assertEquals('Bratislava', testLead.Capital__c);
    }
}
