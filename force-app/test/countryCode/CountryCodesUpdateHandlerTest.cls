@IsTest
private with sharing class CountryCodesUpdateHandlerTest {

    @IsTest
    private static void runUpdateTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CountryLayerResponseMock());
        Metadata.DeployContainer container = CountryCodesUpdateHandler.runUpdate();
        Test.stopTest();

        final List<Metadata.Metadata> metadataList = container.getMetadata();
        final List<String> fullNames = new List<String> {
            metadataList.get(0).fullName,
            metadataList.get(1).fullName,
            metadataList.get(2).fullName
        };

        System.assertEquals(3, metadataList.size(), '3 custom metadata records are expected.');
        System.assert(fullNames.contains('Country_Code__mdt.SK'), 'Country_Code__mdt.SK should be created.');
        System.assert(fullNames.contains('Country_Code__mdt.CZ'), 'Country_Code__mdt.CZ should be created.');
        System.assert(fullNames.contains('Country_Code__mdt.AT'), 'Country_Code__mdt.AT should be created.');
    }

    @IsTest
    private static void runUpdateTest_exception() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CountryLayerExceptionResponseMock());

        CountryLayerImpl.ServerSideException e;
        try {
            CountryCodesUpdateHandler.runUpdate();
        } catch (CountryLayerImpl.ServerSideException ex) {
            e = ex;
        }
        Test.stopTest();

        System.assertNotEquals(null, e);
    }
}
