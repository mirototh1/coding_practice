public with sharing class CountryCodesUpdateHandler {

    /**
     * This method allows running the service from a scheduler
     */
    @Future(callout=true)
    public static void runScheduledUpdate() {
        runUpdate();
    }

    /**
     * Runs a service that fetches the country codes and related data from a external endpoint, 
     * resolves changes and updates the metadata records.
     */
    public static Metadata.DeployContainer runUpdate() {
        final ICountryCodeService countryCodeService = new CountryLayerImpl();
        final List<CountryCodeDao> countryCodes = countryCodeService.fetchData();
        final List<CountryCodeDao> countryCodesToUpdate = getCountryCodesToUpdate(countryCodes);
        return upsertMetadata(countryCodesToUpdate);
    }

    /**
     * Finds those country code records that has changed since the last download. The data are being selected
     * by comparing the hashcodes of existing and newly fetched data.
     */
    private static List<CountryCodeDao> getCountryCodesToUpdate(List<CountryCodeDao> newCountryCodes) {
        final List<CountryCodeDao> result = new List<CountryCodeDao>();
        final Map<String, Country_Code__mdt> countryCodeMdtMap = Country_Code__mdt.getAll();
        
        for (CountryCodeDao daoObject : newCountryCodes) {
            final Country_Code__mdt countryCodeMdt = countryCodeMdtMap.get(daoObject.getAlpha2Code());
            if (countryCodeMdt == null || daoObject.hashCode() != countryCodeMdt.HashCode__c) {
                result.add(daoObject);
            }
        }
        
        return result;
    }

    /**
     * Invokes the metadata deployer and passes the country code data that need to be updated.
     */
    public static Metadata.DeployContainer upsertMetadata(List<CountryCodeDao> countryCodesToUpdate) {
        final MetadataDeployer deployer = new MetadataDeployer('Country_Code__mdt', getRawData(countryCodesToUpdate));
        return deployer.updateAndDeploy();
    }

    /**
     * Converts the list of country code DAO objects into a deployer-readable format.
     */
    private static List<Map<String, Object>> getRawData(List<CountryCodeDao> countryCodes) {
        final List<Map<String, Object>> result = new List<Map<String, Object>>();
        for (CountryCodeDao daoObject : countryCodes) {
            final Map<String, Object> daoFieldMap = new Map<String, Object>();
            daoFieldMap.put('DeveloperName', daoObject.getAlpha2Code());
            daoFieldMap.put('Name__c', daoObject.getName());
            daoFieldMap.put('Alpha2Code__c', daoObject.getAlpha2Code());
            daoFieldMap.put('Alpha3Code__c', daoObject.getAlpha3Code());
            daoFieldMap.put('Capital__c', daoObject.getCapital());
            daoFieldMap.put('Region__c', daoObject.getRegion());
            daoFieldMap.put('HashCode__c', daoObject.hashCode());
            result.add(daoFieldMap);
        }

        return result;
    }
}