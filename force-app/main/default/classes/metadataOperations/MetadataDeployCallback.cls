public with sharing class MetadataDeployCallback implements Metadata.DeployCallback {

    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            // log successfull deployment
        } else {
            System.debug('result.erroerrorStatusCoderMessage :' + result.errorStatusCode);
            // log failed deployment
        }
    }
}