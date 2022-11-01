/**
 * A deployer class that is used to construct and deploy Country Code custom metadata records.
 */
public with sharing class MetadataDeployer {

    final private String metadataName;
    final private List<Map<String, Object>> customMetadataFields;
    private Boolean isDeployable = false;
    
    public MetadataDeployer(final String metadataName, final List<Map<String, Object>> customMetadataFields) {
        this.metadataName = metadataName;
        this.customMetadataFields = customMetadataFields;
    }

    /**
     * Builds and deploys the Country Code custom metadata. The DeveloperName field is mandatory. If not provided, an error is thrown.
     */
    public Metadata.DeployContainer updateAndDeploy() {
        final Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

        for (Map<String, Object> customMetadataMap : customMetadataFields) {
            final String recordDeveloperName = (String) customMetadataMap.get('DeveloperName');
            if (recordDeveloperName == null) {
                throw new MetadataDeployerException('DeveloperName field must be populated.');
            }

            final Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
            customMetadata.fullName = String.format('{0}.{1}', new List<String> {this.metadataName, recordDeveloperName});
            customMetadata.label = recordDeveloperName;

            for (String fieldName : customMetadataMap.keySet()) {
                if (fieldName == 'DeveloperName') {
                    continue;
                }
                final Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
                customField.field = fieldName;
                customField.value = customMetadataMap.get(fieldName);
                customMetadata.values.add(customField);
            }
            mdContainer.addMetadata(customMetadata);
            this.isDeployable = true;
        }

        if (this.isDeployable && !Test.isRunningTest()) {
            Metadata.Operations.enqueueDeployment(mdContainer, new MetadataDeployCallback());
        }

        return mdContainer;
    }

    public class MetadataDeployerException extends Exception {}
}