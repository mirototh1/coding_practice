@IsTest
public with sharing class CountryLayerExceptionResponseMock implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody('');
        res.setStatusCode(400);
        return res;
    }
}
