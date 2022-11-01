@IsTest
public with sharing class CountryLayerResponseMock implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody(getResponseBody());
        res.setStatusCode(200);
        return res;
    }

    private static String getResponseBody() {
        final CountryCodeDao dao1 = new CountryCodeDao()
                .setName('Slovakia-test')
                .setAlpha2Code('SK')
                .setAlpha3Code('SVK')
                .setCapital('Bratislava')
                .setRegion('Europe');

        final CountryCodeDao dao2 = new CountryCodeDao()
                .setName('Czechia-test')
                .setAlpha2Code('CZ')
                .setAlpha3Code('CZE')
                .setCapital('Prague')
                .setRegion('Europe');

        final CountryCodeDao dao3 = new CountryCodeDao()
                .setName('Austria-test')
                .setAlpha2Code('AT')
                .setAlpha3Code('AUT')
                .setCapital('Vienna')
                .setRegion('Europe');
                
        return JSON.serialize(new List<CountryCodeDao> {dao1, dao2, dao3});
    }
}
