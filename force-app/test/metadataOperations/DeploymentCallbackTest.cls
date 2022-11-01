@IsTest
public with sharing class DeploymentCallbackTest {
    
    @IsTest
    private static void callbackTest() {
        final Metadata.DeployCallback callback = new MetadataDeployCallback();
        final Metadata.DeployResult result = new Metadata.DeployResult();
        result.numberComponentErrors = 1;
        final Metadata.DeployCallbackContext context = new Metadata.DeployCallbackContext();
        
        callback.handleResult(result, context);
    }
}
