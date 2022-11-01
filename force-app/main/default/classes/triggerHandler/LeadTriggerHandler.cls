public with sharing class LeadTriggerHandler {
    private LeadTriggerHandler() {}

    public static void execute(final List<Lead> newValues, final Map<Id, Lead> oldMap) {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                LeadTriggerHandler.assignCountryCodes(newValues);
            }
            when BEFORE_UPDATE {
		        LeadTriggerHandler.assignCountryCodes(newValues);
            }
        }
    }

    /**
     * Assigns values to specific fields from the associated Country_Code__mdt custom metadata based on its Country value.
     */
    public static void assignCountryCodes(final List<Lead> newValues) {
        final List<Country_Code__mdt> countryCodeMdtList = Country_Code__mdt.getAll().values();
        final Map<String, Country_Code__mdt> codeToCountryCodeMap = prepareCodeToCountryCodeMap(countryCodeMdtList);
        
        for (Lead leadRecord : newValues) {
            final Country_Code__mdt countryCode = codeToCountryCodeMap.get(leadRecord.Country);
            if (countryCode != null) {
                leadRecord.ISO_Code_2__c = countryCode.Alpha2Code__c;
                leadRecord.ISO_Code_3__c = countryCode.Alpha3Code__c;
                leadRecord.Capital__c = countryCode.Capital__c;
                leadRecord.Region__c = countryCode.Region__c;
            }
        }
    }

    /**
     * Extracts ISO-Code-2 values from a list of Country Code mdt records and returns a map of codes and records.
     */
    private static Map<String, Country_Code__mdt> prepareCodeToCountryCodeMap(final List<Country_Code__mdt> countryCodeMdtList) {
        final Map<String, Country_Code__mdt> result = new Map<String, Country_Code__mdt>();
        for (Country_Code__mdt countryCodeMdt : countryCodeMdtList) {
            result.put(countryCodeMdt.Name__c, countryCodeMdt);
        }

        return result;
    }
}