@isTest
public with sharing class AssetTestDataHelpers {
    public static Asset CreateAsset(
        Account account,
        dmpl__Branch__c branch,
        dmpl__Item__c item,
        dmpl__ItemLot__c itemLot,
        dmpl__SKU__c sku
    ){
        return (Asset) TestFactory.createSObject(
            new Asset(
                Name = 'Test-Asset',
                AccountId = account.Id,
                dmpl__LastServiceBranchId__c = branch.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__ItemLotId__c = itemLot.Id,
                dmpl__SKUId__c = sku.Id,
                dmpl__IsPDIDone__c=true,
                dmpl__RegistrationNumber__c = 'Axb371',
                dmpl__SaleDate__c = date.today()
            ),
            'AssetDefaults',
            true
        );
    }

    public static Asset getAsset() {
        return [
            SELECT Id, Name,dmpl__IsPDIDone__c,
        dmpl__RegistrationNumber__c
            FROM Asset
            LIMIT 1
        ];
    }

    public static Asset getAsset(Id assetId) {
        return [
            SELECT Id, Name,dmpl__IsPDIDone__c,
        dmpl__RegistrationNumber__c
            FROM Asset 
            WHERE Id = :assetId
            LIMIT 1
        ];
    }

    public static dmpl__AssetServiceContract__c createAssetServiceContract(
        Asset asset,
        dmpl__Item__c item){
        return (dmpl__AssetServiceContract__c)TestFactory.createSObject(
            new dmpl__AssetServiceContract__c(
                dmpl__AssetId__c = asset.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__ServiceContractItemId__c = item.Id,
                dmpl__ActivatedDate__c = Datetime.now().Date(),
                dmpl__ValidtillDate__c = Datetime.now().addDays(365).Date(),
                dmpl__DueDate__c = Datetime.now().addDays(365).Date()),
            
                true
        );
    }

    public static dmpl__AssetServiceContract__c getAssetServiceContract(){
        return [SELECT
        Id,
        name,
        dmpl__ActivatedDate__c,
        dmpl__ValidtillDate__c,
        dmpl__DueDate__c
        FROM
        dmpl__AssetServiceContract__c LIMIT 1];
    }

    public static dmpl__AssetServiceContract__c getAssetServiceContract(id assetServiceContractId){
        return [SELECT
        Id,
        name,
        dmpl__ActivatedDate__c,
        dmpl__ValidtillDate__c,
        dmpl__DueDate__c
        FROM
        dmpl__AssetServiceContract__c where Id= :assetServiceContractId LIMIT 1];
    }

    public static dmpl__AssetServiceContractLine__c createAssetServiceContractLine(
        dmpl__AssetServiceContract__c assetServiceContract,
        dmpl__Item__c item){
        return (dmpl__AssetServiceContractLine__c)TestFactory.createSObject(
            new dmpl__AssetServiceContractLine__c(
                dmpl__AssetServiceContractId__c = assetServiceContract.Id,
                dmpl__ComponentItemId__c = item.Id,
                dmpl__Quantity__c = 10,
                dmpl__UtilizedQuantity__c = 5
                ),
                true
        );
    }

    public static dmpl__AssetServiceContractLine__c getAssetServiceContractLine(){
        return [SELECT
        Id,
        name,
        dmpl__ComponentItemId__c,
        dmpl__AssetServiceContractId__c,
        dmpl__Quantity__c,
        dmpl__UtilizedQuantity__c,
        dmpl__PendingQuantity__c
        FROM
        dmpl__AssetServiceContractLine__c LIMIT 1];
    }
    public static dmpl__AssetServiceContractLine__c getAssetServiceContractLine(id assetServiceContractLineId){
        return [SELECT
        Id,
        name,
        dmpl__ComponentItemId__c,
        dmpl__AssetServiceContractId__c,
        dmpl__Quantity__c,
        dmpl__UtilizedQuantity__c,
        dmpl__PendingQuantity__c
        FROM
        dmpl__AssetServiceContractLine__c where Id= :assetServiceContractLineId LIMIT 1];
    }

    public static dmpl__AssetMaintenance__c createAssetMaintenance(
        Asset asset,
        Account partnerAccount,
        dmpl__Branch__c branch,
        dmpl__RepairOrder__c repairOrder,
        dmpl__ServiceCampaign__c serviceCampaign,
        dmpl__ItemServiceContract__c itemServiceContract,
        dmpl__Item__c item){
        return (dmpl__AssetMaintenance__c)TestFactory.createSObject(
            new dmpl__AssetMaintenance__c(
                dmpl__AssetId__c = asset.Id,
                dmpl__PartnerAccountId__c = partnerAccount.Id,
                dmpl__BranchId__c = branch.Id,
                dmpl__RepairOrderId__c = repairOrder.Id,
                dmpl__ItemServiceContractId__c = itemServiceContract.Id,
                dmpl__ServiceCampaignId__c = serviceCampaign.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__isExecuted__c=false,
                dmpl__isMandatory__c=false
            ),
              
                true
        );
    }

    public static dmpl__AssetMaintenance__c getAssetMaintenance(){
        return [SELECT
        Id,
        name,
        dmpl__AssetId__c,
        dmpl__PartnerAccountId__c,
        dmpl__BranchId__c,
        dmpl__RepairOrderId__c,
        dmpl__ItemServiceContractId__c,
        dmpl__ServiceCampaignId__c,
        dmpl__ItemId__c,
        dmpl__isExecuted__c,
        dmpl__isMandatory__c
        FROM
        dmpl__AssetMaintenance__c LIMIT 1];
    }
    public static dmpl__AssetMaintenance__c getAssetMaintenance(id assetMaintenanceId){
        return [SELECT
        Id,
        name,
        dmpl__AssetId__c,
        dmpl__PartnerAccountId__c,
        dmpl__BranchId__c,
        dmpl__RepairOrderId__c,
        dmpl__ItemServiceContractId__c,
        dmpl__ServiceCampaignId__c,
        dmpl__ItemId__c,
        dmpl__isExecuted__c,
        dmpl__isMandatory__c
        FROM
        dmpl__AssetMaintenance__c where Id= :assetMaintenanceId LIMIT 1];
    }

    public static dmpl__AssetDiagnosticData__c createAssetDiagnosticData(
        Asset asset,
        dmpl__Item__c item){
        return (dmpl__AssetDiagnosticData__c)TestFactory.createSObject(
            new dmpl__AssetDiagnosticData__c(
                dmpl__AssetId__c = asset.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__StandardValue__c='StandardValue',
                dmpl__Remarks__c='Remark',
                dmpl__MinValue__c=10.0,
                dmpl__MaxValue__c=100.0
            ),
       
            true
        );
    }

    public static dmpl__AssetDiagnosticData__c getAssetDiagnosticData(){
        return [SELECT
        Id,
        name,
        dmpl__ItemId__c,
        dmpl__AssetId__c,
        dmpl__StandardValue__c,
        dmpl__Remarks__c,
        dmpl__MinValue__c,
        dmpl__MaxValue__c
        FROM
        dmpl__AssetDiagnosticData__c LIMIT 1];
    }

    public static dmpl__AssetDiagnosticData__c getAssetDiagnosticData(id assetDiagnosticDataId){
        return [SELECT
        Id,
        name,
        dmpl__ItemId__c,
        dmpl__AssetId__c,
        dmpl__StandardValue__c,
        dmpl__Remarks__c,
        dmpl__MinValue__c,
        dmpl__MaxValue__c
        FROM
        dmpl__AssetDiagnosticData__c where Id= :assetDiagnosticDataId LIMIT 1];
    }

    public static dmpl__ShippingAssetLine__c createShippingAssetLine(
        Asset asset,
        dmpl__Item__c item,
        dmpl__ItemLot__c itemLot,
        dmpl__ItemLotType__c itemLotType,
        dmpl__SKU__c sku,
        dmpl__Branch__c branch,
        Account partnerAccount,
        dmpl__Shipment__c shipment,
        dmpl__ShipmentLine__c shipmentLine
    ){
        return (dmpl__ShippingAssetLine__c)TestFactory.createSObject(
            new dmpl__ShippingAssetLine__c(
                dmpl__AssetId__c = asset.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__ItemLotId__c = itemLot.Id,
                dmpl__ItemLotTypeId__c = itemLotType.Id,
                dmpl__SKUId__c = sku.Id,
                dmpl__SellingBranchId__c = branch.Id,
                dmpl__SellingPartnerAccountId__c = partnerAccount.Id,
                dmpl__ShipmentId__c = shipment.Id,
                dmpl__ShipmentLineId__c = shipmentLine.Id,
                dmpl__DeliveryDate__c = Date.today(),
                dmpl__Quantity__c = 10,
                dmpl__LotNumber__c = 'Lot123',
                dmpl__ManufacturingMonth__c = Date.today().month(),
                dmpl__PlantName__c = 'Plant A',
                dmpl__EngineNumber__c = 'ENG12345',
                dmpl__SerialNumber__c = 'SN1234',
                dmpl__Status__c='Shipped'
            ),
            true
        );
    }

    public static dmpl__ShippingAssetLine__c getShippingAssetLine(){
        return [SELECT
        Id,
        name,
        dmpl__AssetId__c,
        dmpl__ItemId__c,
        dmpl__ItemLotId__c,
        dmpl__ItemLotTypeId__c,
        dmpl__SKUId__c,
        dmpl__SellingBranchId__c,
        dmpl__SellingPartnerAccountId__c,
        dmpl__ShipmentId__c,
        dmpl__ShipmentLineId__c,
        dmpl__Quantity__c,
        dmpl__LotNumber__c,
        dmpl__PlantName__c,
        dmpl__EngineNumber__c,
        dmpl__SerialNumber__c,
        dmpl__Status__c
        FROM
        dmpl__ShippingAssetLine__c LIMIT 1];
    }

    public static dmpl__ShippingAssetLine__c getShippingAssetLine(id shippingAssetLineId){
        return [SELECT
        Id,
        name,
        dmpl__AssetId__c,
        dmpl__ItemId__c,
        dmpl__ItemLotId__c,
        dmpl__ItemLotTypeId__c,
        dmpl__SKUId__c,
        dmpl__SellingBranchId__c,
        dmpl__SellingPartnerAccountId__c,
        dmpl__ShipmentId__c,
        dmpl__ShipmentLineId__c,
        dmpl__DeliveryDate__c,
        dmpl__Quantity__c,
        dmpl__LotNumber__c,
        dmpl__ManufacturingMonth__c,
        dmpl__PlantName__c,
        dmpl__EngineNumber__c,
        dmpl__SerialNumber__c,
        dmpl__Status__c
        FROM
        dmpl__ShippingAssetLine__c where Id= :shippingAssetLineId LIMIT 1];
    }

    public static dmpl__ItemServiceContract__c createItemServiceContract(
        dmpl__Item__c item,
        dmpl__SKU__c sku
    ){
        return (dmpl__ItemServiceContract__c) TestFactory.createSObject(
            new dmpl__ItemServiceContract__c(
                dmpl__DateEffectiveFrom__c = date.today(),
                dmpl__DateEffectiveTill__c = date.today() + 7,
                dmpl__ItemId__c = item.Id,
                dmpl__SKUId__c = sku.Id,
                dmpl__PopulateContractLines__c = true
            ),
            true
        );
    }

    public static dmpl__ItemServiceContract__c getItemServiceContract() {
        return [
            SELECT Id, Name,dmpl__GraceUsageDays__c,dmpl__ItemId__c,dmpl__GraceUsageReading__c,dmpl__GraceUsageHours__c,dmpl__MaximumUsageHours__c,dmpl__FromDays__c,dmpl__ToDays__c,dmpl__MinimumUsageHours__c,dmpl__MinimumUsageReading__c,dmpl__MaximumUsageReading__c,dmpl__RestrictAssetContractLinesGeneration__c,
            (select Id,Name,dmpl__ComponentItemId__c,dmpl__Quantity__c from dmpl__ItemServiceContractLines__r)
            FROM dmpl__ItemServiceContract__c
            LIMIT 1
        ];
    }









    //New Methods
    public static Asset createAsset(
        String assetName,
        Account account,
        dmpl__Item__c item,
        Date saleDate,
        String serialNumber,
        String componentNumber
    ) {
        return (Asset) TestFactory.createSObject(
            new Asset(
                Name = assetName,
                AccountId = account != null ? account.Id : null,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__SaleDate__c = saleDate,
                SerialNumber = serialNumber,
                dmpl__ComponentNumber__c = componentNumber
            ),
            //'AssetDefaults',
            true
        );
    }

    public static Asset getAssetBySerialNumber(String serialNumber) {
        return [
            SELECT Id, Name, AccountId, dmpl__ItemId__c, dmpl__SaleDate__c, SerialNumber, dmpl__ComponentNumber__c
            FROM Asset
            WHERE SerialNumber = :serialNumber
            LIMIT 1
        ];
    }

    public static Asset getAssetByComponentNumber(String componentNumber) {
        return [
            SELECT Id, Name, AccountId, dmpl__ItemId__c, dmpl__SaleDate__c, SerialNumber, dmpl__ComponentNumber__c
            FROM Asset
            WHERE dmpl__ComponentNumber__c = :componentNumber
            LIMIT 1
        ];
    }

    public static dmpl__AssetAccountHistory__c createAssetAccountHistory(
        Asset asset,
        Account account,
        String externalId,
        Decimal usageReading,
        Decimal usageHour,
        Date startDate,
        Date endDate,
        String address
    ) {
        return (dmpl__AssetAccountHistory__c) TestFactory.createSObject(
            new dmpl__AssetAccountHistory__c(
                dmpl__InstallbaseId__c = asset != null ? asset.Id : null,
                dmpl__AccountId__c = account != null ? account.Id : null,
                dmpl__ExternalId__c = externalId,
                dmpl__AtUsageReading__c = usageReading,
                dmpl__AtUsageHour__c = usageHour,
                dmpl__OwnershipStartDate__c = startDate,
                dmpl__OwnershipEnddate__c = endDate,
                dmpl__Address__c = address
            ),
            //'AssetAccountHistoryDefaults',
            true
        );
    }

    public static dmpl__AssetAccountHistory__c getAssetAccountHistoryByAsset(Id assetId) {
        return [
            SELECT Id, Name, dmpl__InstallbaseId__c, dmpl__AccountId__c,
                   dmpl__AtUsageReading__c, dmpl__AtUsageHour__c,
                   dmpl__OwnershipStartDate__c, dmpl__OwnershipEnddate__c, dmpl__ExternalId__c
            FROM dmpl__AssetAccountHistory__c
            WHERE dmpl__InstallbaseId__c = :assetId
            LIMIT 1
        ];
    }

    // Create method for Asset Diagnostic Data
    public static dmpl__AssetDiagnosticData__c createAssetDiagnosticData(
        Asset asset,
        dmpl__Item__c item,
        Id itemHealthCheckId,
        String externalId,
        String valueType,
        String condition,
        Decimal minValue,
        Decimal maxValue,
        Decimal lastValue,
        String standardValue,
        String remarks
    ) {
        return (dmpl__AssetDiagnosticData__c) TestFactory.createSObject(
            new dmpl__AssetDiagnosticData__c(
                dmpl__AssetId__c = asset != null ? asset.Id : null,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__ItemHealthCheckId__c = itemHealthCheckId,
                dmpl__ExternalId__c = externalId,
                dmpl__ValueType__c = valueType,
                dmpl__Condition__c = condition,
                dmpl__MinValue__c = minValue,
                dmpl__MaxValue__c = maxValue,
                dmpl__LastValue__c = lastValue,
                dmpl__StandardValue__c = standardValue,
                dmpl__Remarks__c = remarks
            ),
            //'AssetDiagnosticDataDefaults',
            true
        );
    }

    // Get method to retrieve Asset Diagnostic Data by Asset Id
    public static dmpl__AssetDiagnosticData__c getAssetDiagnosticDataByAsset(Id assetId) {
        return [
            SELECT Id, Name, dmpl__AssetId__c, dmpl__ItemId__c, dmpl__ValueType__c,
                   dmpl__Condition__c, dmpl__MinValue__c, dmpl__MaxValue__c,
                   dmpl__LastValue__c, dmpl__StandardValue__c, dmpl__Remarks__c,
                   dmpl__ExternalId__c
            FROM dmpl__AssetDiagnosticData__c
            WHERE dmpl__AssetId__c = :assetId
            LIMIT 1
        ];
    }

    // CREATE METHOD
    public static dmpl__AssetMaintenance__c createAssetMaintenance(
        Asset asset,
        Account partnerAccount,
        Id branchId,
        dmpl__Item__c item,
        Id repairOrderId,
        Id repairOrderLineId,
        Id itemServiceContractId,
        Id serviceCampaignId,
        Id serviceCampaignItemId,
        Id serviceCampaignMemberId,
        String campaignBatchInstanceId,
        Boolean isMandatory,
        Decimal quantity
    ) {
        return (dmpl__AssetMaintenance__c) TestFactory.createSObject(
            new dmpl__AssetMaintenance__c(
                dmpl__AssetId__c = asset != null ? asset.Id : null,
                dmpl__PartnerAccountId__c = partnerAccount != null ? partnerAccount.Id : null,
                dmpl__BranchId__c = branchId,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__RepairOrderId__c = repairOrderId,
                dmpl__RepairOrderLineId__c = repairOrderLineId,
                dmpl__ItemServiceContractId__c = itemServiceContractId,
                dmpl__ServiceCampaignId__c = serviceCampaignId,
                dmpl__ServiceCampaignItemId__c = serviceCampaignItemId,
                dmpl__ServiceCampaignMemberId__c = serviceCampaignMemberId,
                dmpl__ServiceCampaignBatchInstanceId__c = campaignBatchInstanceId,
                dmpl__IsMandatory__c = isMandatory,
                dmpl__Quantity__c = quantity
            ),
            //'AssetMaintenanceDefaults',
            true
        );
    }

    // GET METHOD BY ASSET
    public static dmpl__AssetMaintenance__c getAssetMaintenanceByAsset(Id assetId) {
        return [
            SELECT Id, Name, dmpl__AssetId__c, dmpl__ItemId__c, dmpl__PartnerAccountId__c,
                   dmpl__BranchId__c, dmpl__IsMandatory__c, dmpl__Quantity__c,
                   dmpl__ServiceCampaignId__c, dmpl__ServiceCampaignItemId__c,
                   dmpl__ServiceCampaignMemberId__c
            FROM dmpl__AssetMaintenance__c
            WHERE dmpl__AssetId__c = :assetId
            LIMIT 1
        ];
    }

    // GET METHOD BY SERVICE CAMPAIGN
    public static List<dmpl__AssetMaintenance__c> getByServiceCampaign(Id campaignId) {
        return [
            SELECT Id, Name, dmpl__ServiceCampaignId__c
            FROM dmpl__AssetMaintenance__c
            WHERE dmpl__ServiceCampaignId__c = :campaignId
        ];
    }

    // GET METHOD BY Service Campaign Member
    public static List<dmpl__AssetMaintenance__c> getByCampaignMember(Id campaignMemberId) {
        return [
            SELECT Id, Name, dmpl__ServiceCampaignMemberId__c
            FROM dmpl__AssetMaintenance__c
            WHERE dmpl__ServiceCampaignMemberId__c = :campaignMemberId
        ];
    }

    // CREATE
    public static dmpl__AssetServiceContract__c createAssetServiceContract(
        Asset asset,
        Account billingAccount,
        dmpl__Item__c item,
        Id serviceContractId,
        String externalId,
        Date dueDate,
        Decimal dueInHours,
        Decimal graceUsageDays,
        Decimal graceUsageHours,
        Decimal graceUsageReading,
        Date activatedDate,
        Date validTillDate,
        Decimal validTillHours,
        Decimal validTillUsageReading,
        Boolean isUtilized
    ) {
        return (dmpl__AssetServiceContract__c) TestFactory.createSObject(
            new dmpl__AssetServiceContract__c(
                dmpl__AssetId__c = asset != null ? asset.Id : null,
                dmpl__BillingAccountId__c = billingAccount != null ? billingAccount.Id : null,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__ItemServiceContractId__c = serviceContractId,
                dmpl__ExternalId__c = externalId,
                dmpl__DueDate__c = dueDate,
                dmpl__DueInHours__c = dueInHours,
                dmpl__GraceUsageDays__c = graceUsageDays,
                dmpl__GraceUsageHours__c = graceUsageHours,
                dmpl__GraceUsageReading__c = graceUsageReading,
                dmpl__ActivatedDate__c = activatedDate,
                dmpl__ValidTillDate__c = validTillDate,
                dmpl__ValidTillHours__c = validTillHours,
                dmpl__ValidTillUsageReading__c = validTillUsageReading,
                dmpl__IsUtilized__c = isUtilized
            ),
            //'AssetServiceContractDefaults',
            true
        );
    }

    // GET BY SERVICE CONTRACT
    public static List<dmpl__AssetServiceContract__c> getAssetServiceContractByServiceContract(Id serviceContractId) {
        return [
            SELECT Id, Name, dmpl__ItemServiceContractId__c, dmpl__ItemId__c, dmpl__AssetId__c
            FROM dmpl__AssetServiceContract__c
            WHERE dmpl__ItemServiceContractId__c = :serviceContractId
        ];
    }

    // GET BY ITEM
    public static List<dmpl__AssetServiceContract__c> getAssetServiceContractByItem(Id itemId) {
        return [
            SELECT Id, Name, dmpl__ItemId__c, dmpl__AssetId__c, dmpl__ItemServiceContractId__c
            FROM dmpl__AssetServiceContract__c
            WHERE dmpl__ItemId__c = :itemId
        ];
    }

    // GET BY EXTERNAL ID
    public static dmpl__AssetServiceContract__c getByExternalId(String externalId) {
        return [
            SELECT Id, Name, dmpl__ExternalId__c
            FROM dmpl__AssetServiceContract__c
            WHERE dmpl__ExternalId__c = :externalId
            LIMIT 1
        ];
    }

    public static ServiceContract createServiceContract(
        Account account,
        String contractName,
        Date startDate,
        Date endDate,
        String status
    ) {
        return (ServiceContract) TestFactory.createSObject(
            new ServiceContract(
                Name = contractName,
                AccountId = account != null ? account.Id : null,
                StartDate = startDate != null ? startDate : Date.today(),
                EndDate = endDate != null ? endDate : Date.today().addMonths(6)
                //Status = status != null ? status : 'Draft'
            ),
            true // insert record
        );
    }

    public static ServiceContract getServiceContractByName(String name) {
        return [
            SELECT Id, Name, AccountId, StartDate, EndDate, Status
            FROM ServiceContract
            WHERE Name = :name
            LIMIT 1
            ALL ROWS
        ];
    }

    public static List<ServiceContract> getServiceContractsByAccount(Id accountId) {
        return [
            SELECT Id, Name, Status, StartDate, EndDate
            FROM ServiceContract
            WHERE AccountId = :accountId
            ALL ROWS
        ];
    }
}





    // public static dmpl__Asset__c createAsset(
    //     String name,
    //     Account account,
    //     Date saleDate,
    //     dmpl__Branch__c branch,
    //     dmpl__Item__c item
    // ) {
    //     return (dmpl__Asset__c) TestFactory.createSObject(
    //         new dmpl__Asset__c(
    //             Name = name,
    //             AccountId = account != null ? account.Id : null,
    //             dmpl__SaleDate__c = saleDate,
    //             dmpl__BranchId__c = branch != null ? branch.Id : null,
    //             dmpl__ItemId__c = item != null ? item.Id : null
    //         ),
    //         //'AssetDefaults',
    //         true
    //     );
    // }

    // public static dmpl__Asset__c getAsset(String name) {
    //     return [
    //         SELECT Id, Name, AccountId, dmpl__SaleDate__c, dmpl__BranchId__c, dmpl__ItemId__c
    //         FROM dmpl__Asset__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }

    // public static dmpl__AssetAccountHistory__c createAssetAccountHistory(
    //     String name,
    //     dmpl__Asset__c asset,
    //     Account account,
    //     Date ownershipStartDate,
    //     Date ownershipEndDate,
    //     Decimal atUsageReading,
    //     Decimal atUsageHour
    // ) {
    //     return (dmpl__AssetAccountHistory__c) TestFactory.createSObject(
    //         new dmpl__AssetAccountHistory__c(
    //             Name = name,
    //             dmpl__InstallbaseId__c = asset != null ? asset.Id : null,
    //             dmpl__AccountId__c = account != null ? account.Id : null,
    //             dmpl__OwnershipStartDate__c = ownershipStartDate,
    //             dmpl__OwnershipEndDate__c = ownershipEndDate,
    //             dmpl__AtUsageReading__c = atUsageReading,
    //             dmpl__AtUsageHour__c = atUsageHour
    //         ),
    //         //'AssetAccountHistoryDefaults',
    //         true
    //     );
    // }

    // public static dmpl__AssetAccountHistory__c getAssetAccountHistory(String name) {
    //     return [
    //         SELECT Id, Name, dmpl__InstallbaseId__c, dmpl__AccountId__c,
    //             dmpl__OwnershipStartDate__c, dmpl__OwnershipEndDate__c,
    //             dmpl__AtUsageReading__c, dmpl__AtUsageHour__c
    //         FROM dmpl__AssetAccountHistory__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }
    
    // public static dmpl__AssetDiagnosticData__c createAssetDiagnosticData(
    //     String name,
    //     dmpl__Asset__c asset,
    //     dmpl__Item__c item,
    //     String valueType,
    //     Decimal standardValue,
    //     Decimal minValue,
    //     Decimal maxValue,
    //     Decimal lastValue
    // ) {
    //     return (dmpl__AssetDiagnosticData__c) TestFactory.createSObject(
    //         new dmpl__AssetDiagnosticData__c(
    //             Name = name,
    //             dmpl__AssetId__c = asset != null ? asset.Id : null,
    //             dmpl__ItemId__c = item != null ? item.Id : null,
    //             dmpl__ValueType__c = valueType,
    //             dmpl__StandardValue__c = standardValue,
    //             dmpl__MinValue__c = minValue,
    //             dmpl__MaxValue__c = maxValue,
    //             dmpl__LastValue__c = lastValue
    //         ),
    //         //'AssetDiagnosticDataDefaults',
    //         true
    //     );
    // }

    // public static dmpl__AssetDiagnosticData__c getAssetDiagnosticData(String name) {
    //     return [
    //         SELECT Id, Name, dmpl__AssetId__c, dmpl__ItemId__c, dmpl__ValueType__c,
    //                dmpl__StandardValue__c, dmpl__MinValue__c, dmpl__MaxValue__c, dmpl__LastValue__c
    //         FROM dmpl__AssetDiagnosticData__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }

    // public static dmpl__AssetDiagnosticData__c createAssetDiagnosticDataBasic(String name, dmpl__Asset__c asset) {
    //     return createAssetDiagnosticData(name, asset, null, null, null, null, null, null);
    // }

    // public static dmpl__AssetMaintenance__c createAssetMaintenance(
    //     String name,
    //     dmpl__Asset__c asset,
    //     dmpl__ServiceCampaign__c campaign,
    //     dmpl__ServiceCampaignItem__c campaignItem,
    //     dmpl__ServiceCampaignMember__c campaignMember,
    //     Boolean isMandatory,
    //     Decimal quantity
    // ) {
    //     return (dmpl__AssetMaintenance__c) TestFactory.createSObject(
    //         new dmpl__AssetMaintenance__c(
    //             Name = name,
    //             dmpl__AssetId__c = asset != null ? asset.Id : null,
    //             dmpl__ServiceCampaignId__c = campaign != null ? campaign.Id : null,
    //             dmpl__ServiceCampaignItemId__c = campaignItem != null ? campaignItem.Id : null,
    //             dmpl__ServiceCampaignMemberId__c = campaignMember != null ? campaignMember.Id : null,
    //             dmpl__IsMandatory__c = isMandatory,
    //             dmpl__Quantity__c = quantity
    //         ),
    //         true
    //     );
    // }

    // public static dmpl__AssetMaintenance__c getAssetMaintenance(String name) {
    //     return [
    //         SELECT Id, Name, dmpl__AssetId__c, dmpl__ServiceCampaignId__c,
    //                dmpl__ServiceCampaignItemId__c, dmpl__ServiceCampaignMemberId__c,
    //                dmpl__IsMandatory__c, dmpl__Quantity__c
    //         FROM dmpl__AssetMaintenance__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }

    // public static dmpl__AssetMaintenance__c createBasicAssetMaintenance(String name, dmpl__Asset__c asset) {
    //     return createAssetMaintenance(name, asset, null, null, null, false, 1);
    // }

    // public static dmpl__AssetServiceContract__c createAssetServiceContract(
    //     String name,
    //     dmpl__Item__c item,
    //     dmpl__ServiceContract__c serviceContract,
    //     Account billingAccount,
    //     Date dueDate,
    //     Integer dueInHours,
    //     Integer graceUsageHours,
    //     Integer validTillHours,
    //     Date activatedDate,
    //     Date validTillDate,
    //     Integer graceUsageDays
    // ) {
    //     return (dmpl__AssetServiceContract__c) TestFactory.createSObject(
    //         new dmpl__AssetServiceContract__c(
    //             Name = name,
    //             dmpl__ItemId__c = item != null ? item.Id : null,
    //             dmpl__ItemServiceContractId__c = serviceContract != null ? serviceContract.Id : null,
    //             dmpl__BillingAccountId__c = billingAccount != null ? billingAccount.Id : null,
    //             dmpl__DueDate__c = dueDate,
    //             dmpl__DueInHours__c = dueInHours,
    //             dmpl__GraceUsageHours__c = graceUsageHours,
    //             dmpl__ValidTillHours__c = validTillHours,
    //             dmpl__ActivatedDate__c = activatedDate,
    //             dmpl__ValidTillDate__c = validTillDate,
    //             dmpl__GraceUsageDays__c = graceUsageDays
    //         ),
    //         true
    //     );
    // }

    // public static dmpl__AssetServiceContract__c getAssetServiceContract(String name) {
    //     return [
    //         SELECT Id, Name, dmpl__ItemId__c, dmpl__ItemServiceContractId__c, dmpl__BillingAccountId__c,
    //             dmpl__DueDate__c, dmpl__DueInHours__c, dmpl__GraceUsageHours__c,
    //             dmpl__ValidTillHours__c, dmpl__ActivatedDate__c, dmpl__ValidTillDate__c, dmpl__GraceUsageDays__c
    //         FROM dmpl__AssetServiceContract__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }

    // public static dmpl__ServiceContract__c createServiceContract(String name, Account account) {
    //     return (dmpl__ServiceContract__c) TestFactory.createSObject(
    //         new dmpl__ServiceContract__c(
    //             Name = name,
    //             AccountId = account != null ? account.Id : null,
    //             ContractNumber = '00000001'
    //         ),
    //         true
    //     );
    // }

    // public static dmpl__ServiceContract__c getServiceContract(String name) {
    //     return [
    //         SELECT Id, Name, AccountId, ContractNumber
    //         FROM dmpl__ServiceContract__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }

    // public static dmpl__AssetServiceContractLine__c createAssetServiceContractLine(
    //     String name,
    //     dmpl__AssetServiceContract__c assetServiceContract,
    //     dmpl__Item__c item,
    //     dmpl__Item__c componentItem,
    //     Decimal quantity,
    //     Decimal utilizedQuantity
    // ) {
    //     return (dmpl__AssetServiceContractLine__c) TestFactory.createSObject(
    //         new dmpl__AssetServiceContractLine__c(
    //             Name = name,
    //             dmpl__AssetServiceContractId__c = assetServiceContract != null ? assetServiceContract.Id : null,
    //             dmpl__ItemId__c = item != null ? item.Id : null,
    //             dmpl__ComponentItemId__c = componentItem != null ? componentItem.Id : null,
    //             dmpl__Quantity__c = quantity,
    //             dmpl__UtilizedQuantity__c = utilizedQuantity
    //         ),
    //         true
    //     );
    // }

    // public static dmpl__AssetServiceContractLine__c getAssetServiceContractLine(String name) {
    //     return [
    //         SELECT Id, Name,
    //             dmpl__AssetServiceContractId__c,
    //             dmpl__ItemId__c,
    //             dmpl__ComponentItemId__c,
    //             dmpl__Quantity__c,
    //             dmpl__UtilizedQuantity__c
    //         FROM dmpl__AssetServiceContractLine__c
    //         WHERE Name = :name
    //         LIMIT 1
    //     ];
    // }