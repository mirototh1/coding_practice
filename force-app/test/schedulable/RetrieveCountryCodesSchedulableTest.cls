@IsTest
public with sharing class RetrieveCountryCodesSchedulableTest {

    @IsTest
    private static void testSchedulable() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CountryLayerResponseMock());

        final String jobId = RetrieveCountryCodesSchedulable.startJob();
        final List<CronTrigger> cronList = [SELECT Id, CronExpression FROM CronTrigger WHERE Id =: jobId];
        System.assert(!cronList.isEmpty());
        Test.stopTest();
    }
}
