/**
 * Runs a a job every day at 6 AM that fetches all Country Codes data and updates the Country_Code__mdt custom metadata.
 */
global with sharing class RetrieveCountryCodesSchedulable implements Schedulable {

    private static final String JOB_NAME = 'Country Codes update job';
    private static final String CRON_EXP = '0 0 6 * * ?';

    global void execute(SchedulableContext sc) {
        CountryCodesUpdateHandler.runScheduledUpdate();
    }

    public static String startJob() {
        return System.schedule(JOB_NAME, CRON_EXP, new RetrieveCountryCodesSchedulable());
    }
}