/**
 * An implementation class of the ICountryCodeService interface. Ensures callouts to the Country Layer service (countrylayer.com)
 */
public with sharing class CountryLayerImpl implements ICountryCodeService {

    /**
     * Retrieves the country code data from the Country Layer service and returns a list of DAO. 
     */
    public static List<CountryCodeDao> fetchData() {
        try {
            final String countryCodesString = sendRequest();
            final List<CountryCodeDao> countryCodeDaoList = (List<CountryCodeDao>) JSON.deserialize(countryCodesString, List<CountryCodeDao>.class);

            return countryCodeDaoList;
        } catch (Exception e) {
            // log error
            throw e;
        } finally {
            // save logs
        }
    }

    /**
     * Send request to the Country Layer api endpoint.
     */
    private static String sendRequest() {
        try {
            final Http http = new Http();
            final HttpRequest request = new HttpRequest();
            request.setEndpoint(String.format('callout:Country_Layer/v2/all?access_key={0}', new List<String> {getAccessKey()}));
            request.setMethod('GET');
        
            final HttpResponse response = http.send(request);
            final Integer statusCode = response.getStatusCode();
            
            if (statusCode == 200) {
                return response.getBody();
            } else {
                // Log error, etc...
                throw new ServerSideException(String.format(
                    'Failed to retrieve data from countrylayer.com. Status code {0}', 
                    new List<String> {String.valueOf(statusCode)}));
            }
        } catch (Exception e) {
            // log error
            throw e;
        } finally {
            // save logs
        }
    }

    /**
     * Retrieves the access key from the associated custom metadata that is used to authenticate our request.
     */
    private static String getAccessKey() {
        return Access_key__mdt.getAll().get('Country_Layer').Value__c;
    }

    public class ServerSideException extends Exception {}
}