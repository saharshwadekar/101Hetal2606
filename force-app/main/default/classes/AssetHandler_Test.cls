@isTest
public with sharing class AssetHandler_Test {
    @TestSetup
    static void createRequiredData(){
        dmpl__AccountGroup__c accountGroup=TestDataHelpers.createAccountGroup();
        Account customerAccount = TestDataHelpers.createCustomerAccount();
        Account account=TestDataHelpers.createAccount(accountGroup);
        Account partnerAccount=TestDataHelpers.createPartnerAccount();
        Account supplierAccount=TestDataHelpers.createSupplierAccount();
        dmpl__Branch__c branch=TestDataHelpers.createBranch(partnerAccount);
        dmpl__Item__c item = TestDataHelpers.createItem();
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.createTaxGroup(partnerAccount, branch);
        dmpl__Resource__c resource = TestDataHelpers.createResource(partnerAccount, branch);
        dmpl__StorageLocation__c storageLocation = TestDataHelpers.createStorageLocation(branch);
        dmpl__SKU__c sku = TestDataHelpers.createSKU(item);
        dmpl__ItemLot__c itemLot = TestDataHelpers.createItemLot(branch,item,sku,storageLocation);
        dmpl__ItemLotType__c itemLotType = TestDataHelpers.CreateItemLotType(item);
        dmpl__PriceList__c priceList = TestDataHelpers.createPriceList(partnerAccount, branch);
 
        Asset asset=AssetTestDataHelpers.CreateAsset(
            account, 
            branch, 
            item, 
            itemLot, 
            sku
        );
        dmpl__Quote__c serviceEstimate = QuoteTestDataHelpers.CreateServiceEstimate(
            branch,
            customerAccount,
            priceList,
            asset,
            null,
            item
        );
 
        dmpl__RepairOrder__c repairOrder=RepairOrderTestDataHelpers.createRepairOrder(
            item,
            branch,
            asset,
            serviceEstimate,
            customerAccount,
            resource
        );
 
        dmpl__ServiceLead__c ServiceLead=ServiceLeadTestDataHelpers.createServiceLead(
            branch,
            customerAccount,
            resource
        );
 
        dmpl__ItemServiceContract__c ItemServiceContract=AssetTestDataHelpers.createItemServiceContract(
            item,
            sku
        );
 
        dmpl__ServiceCampaign__c serviceCampaign=CampaignTestDataHelpers.CreateServiceCompaign(
            ItemServiceContract,
            ServiceLead,
            item
        );
        dmpl__AssetServiceContract__c assetServiceContract = AssetTestDataHelpers.createAssetServiceContract(
            asset, 
            item
        );
        dmpl__AssetServiceContractLine__c assetServiceContractLine = AssetTestDataHelpers.createAssetServiceContractLine(
            assetServiceContract, 
            item
        );
        dmpl__AssetMaintenance__c assetMaintenance = AssetTestDataHelpers.createAssetMaintenance(
            asset,
            partnerAccount,
            branch,
            repairOrder,
            serviceCampaign,
            itemServiceContract,
            item
        );
 
        dmpl__AssetDiagnosticData__c assetDiagnosticData = AssetTestDataHelpers.createAssetDiagnosticData(
            asset, 
            item
        );
 
        dmpl__PurchaseOrder__c purchaseOrder=PurchaseOrderTestDataHelpers.createPurchaseOrder(
            branch,
            supplierAccount
        );
 
        dmpl__PurchaseRequisition__c PurchaseRequisition=PurchaseOrderTestDataHelpers.createPurchaseRequisition(
            branch, 
            supplierAccount
        );
 
        dmpl__PurchaseOrderLine__c purchaseOrderLine=PurchaseOrderTestDataHelpers.createPurchaseOrderLine(
            item,
            sku, 
            purchaseOrder, 
            taxGroup
        );
        dmpl__Shipment__c shipment = ShipmentTestDataHelper.createShipment(
            supplierAccount, 
            branch, 
            purchaseOrder
        );
        dmpl__ShipmentLine__c shipmentLine = ShipmentTestDataHelper.createShipmentLine(
            item, 
            shipment, 
            sku, 
            purchaseOrderLine
        );
 
        dmpl__ShippingAssetLine__c shippingAssetLine = AssetTestDataHelpers.createShippingAssetLine(
            asset,
            item,
            itemLot,
            itemLotType,
            sku,
            branch,
            partnerAccount,
            shipment,
            shipmentLine
        );


        //New Data
        Account partnerAccount1 = TestDataHelpers.createPartnerAccount(
            'Partner 1',
            true,
            true,
            false,
            true,
            '123 Billing Street',
            'Pune',
            'Maharashtra',
            'India',
            '411001',
            '456 Shipping Street',
            'Pune',
            'Maharashtra',
            'India',
            '411001',
            '9876543210'
        );
        dmpl__Branch__c branch1 = TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        Account customerAccount1 = TestDataHelpers.createCustomerAccount(
            'Customer 1',
            true,
            false,
            false,
            true,
            'MG Road',
            'Pune',
            'Maharashtra',
            'India',
            '411001',
            'Ring Rd',
            'Nagpur',
            'Maharashtra',
            'India',
            '440001',
            '9876543210',
            'Created'
        );
    }
 
    @isTest
    static void createAssetPositive() {
        Asset asset = AssetTestDataHelpers.getAsset();
        if(asset != null){
            System.assertNotEquals(asset, null, 'Expected asset to be created.');
        }
        System.assertNotEquals(asset.name, null, 'Name should not be null');
        System.assertEquals(asset.IsPDIDone__c,true,'IsPDIDone__c should be true');
    }
 
    @isTest
    static void updateAssetPositive() {
        Asset asset= AssetTestDataHelpers.getAsset();
        if(asset!=null){
            System.assertNotEquals(asset, null, 'Expected asset to be created before update.');
            asset.IsPDIDone__c = false;
            asset.dmpl__LastServiceBranchId__c = null;
            asset.RegistrationNumber__c = 'Axb300';
            update asset;
        }
        Asset updatedAsset=AssetTestDataHelpers.getAsset(asset.Id);
        if(updatedAsset != null){
            System.assertNotEquals(updatedAsset, null, 'Expected asset to be updated.');
            System.assertEquals(updatedAsset.IsPDIDone__c, false, 'Expected asset.IsPDIDone__c to be false');
            System.assertEquals(updatedAsset.RegistrationNumber__c, 'Axb300', 'Expected asset.RegistrationNumber__c to be Axb300');
        }
    }
 
    @isTest
    static void deleteAssetPositive() {
        Asset asset = AssetTestDataHelpers.getAsset();
        System.assertNotEquals(asset, null, 'Expected asset to be created before delete.');
        Asset deletedAsset=null;
        delete asset;
        try{
            deletedAsset=AssetTestDataHelpers.getAsset(asset.Id);
        }
        catch(Exception e) {
            deletedAsset=null;
        }
        System.assertEquals(null, deletedAsset, 'Expected asset to be deleted.');
    }
 
    @isTest
    static void createAssetServiceContractPositive() {
        dmpl__AssetServiceContract__c assetServiceContract = AssetTestDataHelpers.getAssetServiceContract();
        if(assetServiceContract != null){
            System.assertNotEquals(assetServiceContract, null, 'Expected assetServiceContract to be created.');
        }
        System.assertNotEquals(assetServiceContract.name, null, 'Name should not be null');
    }
 
    @isTest
    static void updateAssetServiceContractPositive() {
        dmpl__AssetServiceContract__c assetServiceContract = AssetTestDataHelpers.getAssetServiceContract();
        if(assetServiceContract != null){
            System.assertNotEquals(assetServiceContract, null, 'Expected assetServiceContract to be created before update.');
            assetServiceContract.dmpl__ActivatedDate__c = Datetime.now().addDays(30).Date();
            assetServiceContract.dmpl__ValidtillDate__c = Datetime.now().addDays(365).Date();
            assetServiceContract.dmpl__DueDate__c = Datetime.now().addDays(365).Date();
            update assetServiceContract;
        }
 
        dmpl__AssetServiceContract__c updatedAssetServiceContract=AssetTestDataHelpers.getAssetServiceContract(assetServiceContract.Id);
        if(updatedAssetServiceContract != null){
            System.assertNotEquals(updatedAssetServiceContract, null, 'Expected assetServiceContract to be updated.');
        }
        System.assertEquals(Datetime.now().addDays(30).Date(), updatedAssetServiceContract.dmpl__ActivatedDate__c, 'ActivatedDate should be updated');
        System.assertEquals(Datetime.now().addDays(365).Date(), updatedAssetServiceContract.dmpl__ValidtillDate__c, 'ValidtillDate should be updated');
        System.assertEquals(Datetime.now().addDays(365).Date(), updatedAssetServiceContract.dmpl__DueDate__c, 'DueDate should be updated');
    }
 
    @isTest
    static void deleteAssetServiceContractPositive() {
        dmpl__AssetServiceContract__c assetServiceContract = AssetTestDataHelpers.getAssetServiceContract();
        System.assertNotEquals(assetServiceContract, null, 'Expected assetServiceContract to be created before deleted.');
        dmpl__AssetServiceContract__c deletedAssetServiceContract=null;
        delete assetServiceContract;
        try{
            deletedAssetServiceContract=AssetTestDataHelpers.getAssetServiceContract(assetServiceContract.Id);
        }
        catch(Exception e){
            deletedAssetServiceContract=null;
        }
        System.assertEquals(null, deletedAssetServiceContract, 'Expected assetServiceContract to be deleted.');
    }
 
    @isTest
    static void createAssetServiceContractLinePositive() {
        dmpl__AssetServiceContractLine__c assetServiceContractLine = AssetTestDataHelpers.getAssetServiceContractLine();
        if(assetServiceContractLine != null){
            System.assertNotEquals(assetServiceContractLine, null, 'Expected assetServiceContractLine to be created.');
        }
        System.assertNotEquals(assetServiceContractLine.name, null, 'Name should not be null');
        System.assertNotEquals(assetServiceContractLine.dmpl__AssetServiceContractId__c, null, 'Expected dmpl__AssetServiceContractId__c to be set.');
        System.assertNotEquals(assetServiceContractLine.dmpl__ComponentItemId__c, null, 'Expected dmpl__ItemId__c to be set.');
        System.assertEquals(10, assetServiceContractLine.dmpl__Quantity__c, 'Expected dmpl__Quantity__c to be 10');
        System.assertEquals(5, assetServiceContractLine.dmpl__UtilizedQuantity__c, 'Expected dmpl__UtilizedQuantity__c to be 5');
        System.assertEquals(5, assetServiceContractLine.dmpl__PendingQuantity__c, 'Expected dmpl__PendingQuantity__c to be 5');
    }
 
    @isTest
    static void updateAssetServiceContractLinePositive() {
        dmpl__AssetServiceContractLine__c assetServiceContractLine = AssetTestDataHelpers.getAssetServiceContractLine();
        if(assetServiceContractLine != null){
            System.assertNotEquals(assetServiceContractLine, null, 'Expected assetServiceContractLine to be created before update.');
            assetServiceContractLine.dmpl__Quantity__c = 20;
            assetServiceContractLine.dmpl__UtilizedQuantity__c = 10;
            update assetServiceContractLine;
        }
 
        dmpl__AssetServiceContractLine__c updatedAssetServiceContractLine=AssetTestDataHelpers.getAssetServiceContractLine(assetServiceContractLine.Id);
        if(updatedAssetServiceContractLine != null){
            System.assertNotEquals(updatedAssetServiceContractLine, null, 'Expected assetServiceContractLine to be updated.');
        }
        System.assertEquals(20, updatedAssetServiceContractLine.dmpl__Quantity__c, 'Expected dmpl__Quantity__c to be updated to 20');
        System.assertEquals(10, updatedAssetServiceContractLine.dmpl__UtilizedQuantity__c, 'Expected dmpl__UtilizedQuantity__c to be updated to 10');
        System.assertEquals(10, updatedAssetServiceContractLine.dmpl__PendingQuantity__c, 'Expected dmpl__PendingQuantity__c to be updated to 10');
    }
 
    @isTest
    static void deleteAssetServiceContractLinePositive() {
        dmpl__AssetServiceContractLine__c assetServiceContractLine = AssetTestDataHelpers.getAssetServiceContractLine();
        System.assertNotEquals(assetServiceContractLine, null, 'Expected assetServiceContractLine to be created before delete.');
        dmpl__AssetServiceContractLine__c deletedAssetServiceContractLine=null;
        delete assetServiceContractLine;
        try{
            deletedAssetServiceContractLine=AssetTestDataHelpers.getAssetServiceContractLine(assetServiceContractLine.Id);
        }
        catch(Exception e) {
            deletedAssetServiceContractLine=null;
        }
        System.assertEquals(null, deletedAssetServiceContractLine, 'Expected assetServiceContractLine to be deleted.');
    }
 
    @isTest
    static void createAssetMaintenancePositive() {
        dmpl__AssetMaintenance__c assetMaintenance = AssetTestDataHelpers.getAssetMaintenance();
        if(assetMaintenance != null){
            System.assertNotEquals(assetMaintenance, null, 'Expected assetMaintenance to be created.');
        }
        System.assertEquals(false, assetMaintenance.dmpl__isExecuted__c, 'Expected dmpl__isExecuted__c to be false');
        System.assertEquals(false, assetMaintenance.dmpl__isMandatory__c, 'Expected dmpl__isMandatory__c to be false');
        System.assertNotEquals(assetMaintenance.dmpl__AssetId__c, null, 'Expected dmpl__Asset__c to be set.');
        System.assertNotEquals(assetMaintenance.dmpl__BranchId__c, null, 'Expected dmpl__Branch__c to be set.');
        System.assertNotEquals(assetMaintenance.dmpl__PartnerAccountId__c, null, 'Expected dmpl__PartnerAccount__c to be set.');
        System.assertNotEquals(assetMaintenance.dmpl__RepairOrderId__c, null, 'Expected dmpl__RepairOrder__c to be set.');
        System.assertNotEquals(assetMaintenance.dmpl__ServiceCampaignId__c, null, 'Expected dmpl__ServiceCampaign__c to be set.');
        System.assertNotEquals(assetMaintenance.dmpl__ItemServiceContractId__c, null, 'Expected dmpl__ItemServiceContract__c to be set.');
    }
 
    @isTest
    static void updateAssetMaintenancePositive() {
        dmpl__AssetMaintenance__c assetMaintenance = AssetTestDataHelpers.getAssetMaintenance();
        if(assetMaintenance != null){
            System.assertNotEquals(assetMaintenance, null, 'Expected assetMaintenance to be created before update.');
            assetMaintenance.dmpl__isExecuted__c = true;
            assetMaintenance.dmpl__isMandatory__c = true;
            update assetMaintenance;
        }
 
        dmpl__AssetMaintenance__c updatedAssetMaintenance = AssetTestDataHelpers.getAssetMaintenance(assetMaintenance.Id);
        if(updatedAssetMaintenance != null){
            System.assertNotEquals(updatedAssetMaintenance, null, 'Expected assetMaintenance to be updated.');
        }
        System.assertEquals(true, updatedAssetMaintenance.dmpl__isExecuted__c, 'Expected dmpl__isExecuted__c to be true');
        System.assertEquals(true, updatedAssetMaintenance.dmpl__isMandatory__c, 'Expected dmpl__isMandatory__c to be true');
    }
 
    @isTest
    static void deleteAssetMaintenancePositive() {
        dmpl__AssetMaintenance__c assetMaintenance = AssetTestDataHelpers.getAssetMaintenance();
        System.assertNotEquals(assetMaintenance, null, 'Expected asset to be created before delete.');
        dmpl__AssetMaintenance__c deletedAssetMaintenance = null;
        delete assetMaintenance;
        try{
            deletedAssetMaintenance = AssetTestDataHelpers.getAssetMaintenance(assetMaintenance.Id);
        }
        catch(Exception e) {
            deletedAssetMaintenance = null;
        }
        System.assertEquals(null, deletedAssetMaintenance, 'Expected assetMaintenance to be deleted.');
    }
 
    @isTest
    static void createShippingAssetLinePositive(){
        dmpl__ShippingAssetLine__c shippingAssetLine=AssetTestDataHelpers.getShippingAssetLine();
        if(shippingAssetLine != null){
            System.assertNotEquals(shippingAssetLine, null, 'Expected shippingAssetLine to be created.');
        }
        System.assertNotEquals(shippingAssetLine.name, null, 'Name should not be null');
        System.assertNotEquals(shippingAssetLine.dmpl__AssetId__c, null, 'Expected dmpl__AssetId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__ItemId__c, null, 'Expected dmpl__ItemId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__ItemLotId__c, null, 'Expected dmpl__ItemLotId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__ItemLotTypeId__c, null, 'Expected dmpl__ItemLotTypeId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__SKUId__c, null, 'Expected dmpl__SKUId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__SellingBranchId__c, null, 'Expected dmpl__SellingBranchId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__SellingPartnerAccountId__c, null, 'Expected dmpl__SellingPartnerAccountId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__ShipmentId__c, null, 'Expected dmpl__ShipmentId__c to be set.');
        System.assertNotEquals(shippingAssetLine.dmpl__ShipmentLineId__c, null, 'Expected dmpl__ShipmentLineId__c to be set.');
        System.assertEquals(10, shippingAssetLine.dmpl__Quantity__c, 'Expected dmpl__Quantity__c to be 10');
        System.assertEquals('Lot123', shippingAssetLine.dmpl__LotNumber__c, 'Expected dmpl__LotNumber__c to be Lot123');
        System.assertEquals('SN1234', shippingAssetLine.dmpl__SerialNumber__c, 'Expected dmpl__SerialNumber__c to be SN1234');
        System.assertEquals('Shipped', shippingAssetLine.dmpl__Status__c, 'Expected dmpl__Status__c to be Shipped');
        System.assertEquals('Plant A', shippingAssetLine.dmpl__PlantName__c, 'Expected dmpl__PlantName__c to be Plant A');
        System.assertEquals('ENG12345', shippingAssetLine.dmpl__EngineNumber__c, 'Expected dmpl__EngineNumber__c to be ENG12345');
    }
 
    @isTest
    static void updateShippingAssetLinePositive(){
        dmpl__ShippingAssetLine__c shippingAssetLine=AssetTestDataHelpers.getShippingAssetLine();
        if(shippingAssetLine != null){
            System.assertNotEquals(shippingAssetLine, null, 'Expected shippingAssetLine to be created before update.');
            shippingAssetLine.dmpl__Quantity__c = 20;
            shippingAssetLine.dmpl__LotNumber__c = 'UpdatedLot123';
            shippingAssetLine.dmpl__SerialNumber__c = 'UpdatedSN1234';
            shippingAssetLine.dmpl__Status__c = 'Installed';
            shippingAssetLine.dmpl__PlantName__c = 'UpdatedPlant A';
            shippingAssetLine.dmpl__EngineNumber__c = 'UpdatedENG12345';
            update shippingAssetLine;
        }
 
        dmpl__ShippingAssetLine__c updatedShippingAssetLine=AssetTestDataHelpers.getShippingAssetLine(shippingAssetLine.Id);
        if(updatedShippingAssetLine != null){
            System.assertNotEquals(updatedShippingAssetLine, null, 'Expected shippingAssetLine to be updated.');
        }
        System.assertEquals(20, updatedShippingAssetLine.dmpl__Quantity__c, 'Expected dmpl__Quantity__c to be updated to 20');
        System.assertEquals('UpdatedLot123', updatedShippingAssetLine.dmpl__LotNumber__c, 'Expected dmpl__LotNumber__c to be UpdatedLot123');
        System.assertEquals('UpdatedSN1234', updatedShippingAssetLine.dmpl__SerialNumber__c, 'Expected dmpl__SerialNumber__c to be UpdatedSN1234');
        System.assertEquals('Installed', updatedShippingAssetLine.dmpl__Status__c, 'Expected dmpl__Status__c to be Installed');
        System.assertEquals('UpdatedPlant A', updatedShippingAssetLine.dmpl__PlantName__c, 'Expected dmpl__PlantName__c to be UpdatedPlant A');
        System.assertEquals('UpdatedENG12345', updatedShippingAssetLine.dmpl__EngineNumber__c, 'Expected dmpl__EngineNumber__c to be UpdatedENG12345');
    }
 
    @isTest
    static void deleteShippingAssetLinePositive(){
        dmpl__ShippingAssetLine__c shippingAssetLine=AssetTestDataHelpers.getShippingAssetLine();
        System.assertNotEquals(shippingAssetLine, null, 'Expected shippingAssetLine to be created before delete.');
        dmpl__ShippingAssetLine__c deletedShippingAssetLine=null;
        delete shippingAssetLine;
        try{
            deletedShippingAssetLine=AssetTestDataHelpers.getShippingAssetLine(shippingAssetLine.Id);
        }
        catch(Exception e) {
            deletedShippingAssetLine=null;
        }
        System.assertEquals(null, deletedShippingAssetLine, 'Expected shippingAssetLine to be deleted.');
    }
 
    @isTest
    static void createAssetDiagnosticDataPositive() {
        dmpl__AssetDiagnosticData__c assetDiagnosticData = AssetTestDataHelpers.getAssetDiagnosticData();
        if(assetDiagnosticData != null){
            System.assertNotEquals(assetDiagnosticData, null, 'Expected assetDiagnosticData to be created.');
        }
        System.assertNotEquals(assetDiagnosticData.name, null, 'Name should not be null');
        System.assertNotEquals(assetDiagnosticData.dmpl__AssetId__c, null, 'Expected dmpl__AssetId__c to be set.');
        System.assertNotEquals(assetDiagnosticData.dmpl__ItemId__c, null, 'Expected dmpl__ItemId__c to be set.');
        System.assertEquals('StandardValue', assetDiagnosticData.dmpl__StandardValue__c, 'Expected dmpl__StandardValue__c to be StandardValue');
        System.assertEquals('Remark', assetDiagnosticData.dmpl__Remarks__c, 'Expected dmpl__Remarks__c to be Remark');
        System.assertEquals(10.0, assetDiagnosticData.dmpl__MinValue__c, 'Expected dmpl__MinValue__c to be 10.0');
        System.assertEquals(100.0, assetDiagnosticData.dmpl__MaxValue__c, 'Expected dmpl__MaxValue__c to be 100.0');
    }
 
    @isTest
    static void updateAssetDiagnosticDataPositive() {
        dmpl__AssetDiagnosticData__c assetDiagnosticData = AssetTestDataHelpers.getAssetDiagnosticData();
        if(assetDiagnosticData != null){
            System.assertNotEquals(assetDiagnosticData, null, 'Expected assetDiagnosticData to be created before update.');
            assetDiagnosticData.dmpl__StandardValue__c = 'UpdatedStandardValue';
            assetDiagnosticData.dmpl__Remarks__c = 'UpdatedRemark';
            assetDiagnosticData.dmpl__MinValue__c = 20.0;
            assetDiagnosticData.dmpl__MaxValue__c = 200.0;
            update assetDiagnosticData;
        }
 
        dmpl__AssetDiagnosticData__c updatedAssetDiagnosticData=AssetTestDataHelpers.getAssetDiagnosticData(assetDiagnosticData.Id);
        if(updatedAssetDiagnosticData != null){
            System.assertNotEquals(updatedAssetDiagnosticData, null, 'Expected assetDiagnosticData to be updated.');
        }
        System.assertEquals('UpdatedStandardValue', updatedAssetDiagnosticData.dmpl__StandardValue__c, 'Expected dmpl__StandardValue__c to be UpdatedStandardValue');
        System.assertEquals('UpdatedRemark', updatedAssetDiagnosticData.dmpl__Remarks__c, 'Expected dmpl__Remarks__c to be UpdatedRemark');
        System.assertEquals(20.0, updatedAssetDiagnosticData.dmpl__MinValue__c, 'Expected dmpl__MinValue__c to be updated to 20.0');
        System.assertEquals(200.0, updatedAssetDiagnosticData.dmpl__MaxValue__c, 'Expected dmpl__MaxValue__c to be updated to 200.0');
    }
 
    @isTest
    static void deleteAssetDiagnosticDataPositive() {
        dmpl__AssetDiagnosticData__c assetDiagnosticData = AssetTestDataHelpers.getAssetDiagnosticData();
        System.assertNotEquals(assetDiagnosticData, null, 'Expected assetDiagnosticData to be created before delete.');
        dmpl__AssetDiagnosticData__c deletedAssetDiagnosticData=null;
        delete assetDiagnosticData;
        try{
            deletedAssetDiagnosticData=AssetTestDataHelpers.getAssetDiagnosticData(assetDiagnosticData.Id);
        }
        catch(Exception e) {
            deletedAssetDiagnosticData=null;
        }
        System.assertEquals(null, deletedAssetDiagnosticData, 'Expected assetDiagnosticData to be deleted.');
    }







    //New Method
    // // Account History
   @isTest
    public static void createAssetAccountHistoryWithAssetPositive() {
        Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

        Test.startTest();
        Asset asset = AssetTestDataHelpers.createAsset(
            'Asset 2',
            partner1,
            null,                  
            Date.today(),          
            null, null             
        );
        dmpl__AssetAccountHistory__c assetHistory = AssetTestDataHelpers.createAssetAccountHistory(
            asset,
            null,                 
            null, null, null,     
            null, null, null      
        );
        Test.stopTest();

        dmpl__AssetAccountHistory__c fetchedHistory = [
            SELECT Id, Name, dmpl__InstallbaseId__c
            FROM dmpl__AssetAccountHistory__c
            WHERE Id = :assetHistory.Id
        ];

        System.assertNotEquals(null, fetchedHistory, 'Asset Account History record should be fetched.');
        System.assertEquals(asset.Id, fetchedHistory.dmpl__InstallbaseId__c, 'Asset should be linked to the Account History correctly.');
    }

@isTest
public static void updateAssetAccountHistoryFieldsPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    Test.startTest();
    Asset asset = AssetTestDataHelpers.createAsset('Asset 1', partner1, null, Date.today(), null, null);
    
    // Create history with asset
    dmpl__AssetAccountHistory__c history = AssetTestDataHelpers.createAssetAccountHistory(
        asset, customer1, 'EXT-H123', 100, 10, Date.today().addDays(-5), Date.today(), 'Test Address'
    );

    // Now perform a valid update (change usage reading and ownership end date)
    history.dmpl__AtUsageReading__c = 150;
    history.dmpl__OwnershipEnddate__c = Date.today().addDays(10);
    update history;
    Test.stopTest();

    // Verify updated fields
    dmpl__AssetAccountHistory__c updatedHistory = [
        SELECT Id, dmpl__InstallbaseId__c, dmpl__AtUsageReading__c, dmpl__OwnershipEnddate__c
        FROM dmpl__AssetAccountHistory__c
        WHERE Id = :history.Id
    ];

    System.assertNotEquals(null, updatedHistory.Id, 'Asset Account History should exist');
    System.assertEquals(asset.Id, updatedHistory.dmpl__InstallbaseId__c, 'Asset should remain unchanged');
    System.assertEquals(150, updatedHistory.dmpl__AtUsageReading__c, 'Usage Reading should be updated');
    System.assertEquals(Date.today().addDays(10), updatedHistory.dmpl__OwnershipEnddate__c, 'Ownership end date should be updated');
}


    
    
    
    
    // @isTest
    // public static void createAssetAccountHistoryWithStartDateGreaterThanEndDateNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     Boolean creationFailed = false;
    //     try {
    //         Date startDate = Date.newInstance(2025, 6, 31); 
    //         Date endDate = Date.newInstance(2025, 6, 1);
    //         startDate = Date.newInstance(2025, 7, 1); 
    //         dmpl__AssetAccountHistory__c history = AssetTestDataHelper.createAssetAccountHistory(
    //             'HA25060000',
    //             asset,
    //             customer1,
    //             startDate,
    //             endDate,
    //             null,
    //             null
    //         );
    //         System.debug('Asset Account History should not be created with invalid date range.');
    //     } catch (Exception e) {
    //         creationFailed = true;
    //         System.debug('Expected failure: Ownership Start Date > End Date: ' + e.getMessage());
    //     }
    //     Test.stopTest();

    //     System.assertEquals(true, creationFailed, 'Asset Account History creation should fail if start date > end date.');
    // }

    // @isTest
    // public static void updateAssetAccountHistoryWithAtUsageReadingAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetAccountHistory__c history = AssetTestDataHelper.createAssetAccountHistory(
    //         'HA25060000',
    //         asset,
    //         customer1,
    //         null, 
    //         null, 
    //         null, 
    //         null   
    //     );
    //     Boolean updateFailed = false;
    //     try {
    //         history.dmpl__AtUsageReading__c = -1;
    //         update history;
    //         System.debug('Update should fail when setting AtUsageReading to -1.');
    //     } catch (Exception e) {
    //         updateFailed = true;
    //         System.debug('Expected update failure: ' + e.getMessage());
    //     }
    //     Test.stopTest();
        
    //     System.assertNotEquals(null, asset.Id, 'Asset should be created successfully.');
    //     System.assertEquals(partner1.Id, asset.AccountId, 'Asset must be linked to correct Partner.');

    //     System.assertNotEquals(null, history.Id, 'Asset Account History should be created.');

    //     System.assertEquals(true, updateFailed, 'Update must fail if AtUsageReading is set to -1.');
    // }

    // @isTest
    // public static void updateAssetAccountHistoryWithAtUsageHourAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetAccountHistory__c history = AssetTestDataHelper.createAssetAccountHistory(
    //         'HA25060000',
    //         asset,
    //         customer1,
    //         null,  
    //         null,  
    //         null,  
    //         null   
    //     );
    //     Boolean updateFailed = false;
    //     try {
    //         history.dmpl__AtUsageHour__c = -1;
    //         update history;
    //     } catch (Exception e) {
    //         updateFailed = true;
    //         System.debug('Expected exception: ' + e.getMessage());
    //     }
    //     Test.stopTest();

        
    //     System.assertNotEquals(null, asset.Id, 'Asset should be created');
    //     System.assertEquals(partner1.Id, asset.AccountId, 'Asset must be linked to correct Partner');
    //     System.assertNotEquals(null, history.Id, 'Asset Account History should be created');
    //     System.assertEquals(true, updateFailed, 'Update must fail when AtUsageHour is set to -1');
    // }

    // @isTest
    // public static void updateAssetAccountHistoryWithInactiveCustomerNegative() {
    //     Account partner1  = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     Account customer7 = TestDataHelpers.getCustomerAccount('Customer 7');

    //     Test.startTest();
    //     customer7.IsActive = false;
    //     update customer7;
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetAccountHistory__c history = AssetTestDataHelper.createAssetAccountHistory(
    //         'HA25060000',
    //         asset,
    //         customer1,
    //         null, 
    //         null, 
    //         null, 
    //         null  
    //     );
    //     Boolean updateFailed = false;
    //     try {
    //         history.dmpl__AccountId__c = inactiveCustomer.Id;
    //         update history;
    //     } catch (Exception e) {
    //         updateFailed = true;
    //         System.debug('Expected exception on update with inactive customer: ' + e.getMessage());
    //     }
    //     Test.stopTest();

    //     System.assertNotEquals(null, asset.Id, 'Asset should be created');
    //     System.assertEquals(partner1.Id, asset.AccountId, 'Asset should be linked to correct partner');

    //     System.assertNotEquals(null, history.Id, 'Asset Account History should be created');
    //     System.assertEquals(customer1.Id, history.dmpl__AccountId__c, 'History should be linked to active customer');

    //     System.assertEquals(true, updateFailed, 'Update should fail when using an inactive customer');
    // }

    // //Account Diagnostic
    // @isTest
    // public static void createAssetDiagnosticDataWithAssetPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1'); 
    //     Date saleDate = Date.today();
    //     dmpl__Asset__c asset = AssetDataHelper.createAsset('Asset 2', partner1, saleDate, branch1, item1);

    //     Test.startTest();
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetDataHelper.createAssetDiagnosticDataBasic('HCD25060000', asset);
    //     Test.stopTest();

    //     dmpl__Asset__c insertedAsset = AssetDataHelper.getAsset('Asset 2');
    //     System.assertNotEquals(null, insertedAsset, 'Asset should be created');
    //     System.assertEquals('Partner 1', insertedAsset.Account.Name, 'Account should match');
    //     System.assertEquals(branch.Id, insertedAsset.dmpl__BranchId__c, 'Branch should match');

    //     dmpl__AssetDiagnosticData__c insertedDiagnostic = AssetDataHelper.getAssetDiagnosticData('HCD25060000');
    //     System.assertNotEquals(null, insertedDiagnostic, 'Asset Diagnostic Data should be created');
    //     System.assertEquals(insertedAsset.Id, insertedDiagnostic.dmpl__AssetId__c, 'Diagnostic should link to Asset');
    //     System.assertEquals('HCD25060000', insertedDiagnostic.Name, 'Diagnostic Name should match');
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithNewItemPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic(
    //         'HCD25060000',
    //         asset
    //     );
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');
    //     diagnostic.dmpl__ItemId__c = item.Id;
    //     update diagnostic;
    //     Test.stopTest();
        
    //     dmpl__AssetDiagnosticData__c updatedDiagnostic = [
    //         SELECT Id, Name, dmpl__AssetId__c, dmpl__ItemId__c
    //         FROM dmpl__AssetDiagnosticData__c
    //         WHERE Id = :diagnostic.Id
    //     ];

    //     System.assertEquals(asset.Id, updatedDiagnostic.dmpl__AssetId__c, 'Asset should remain Asset 2');
    //     System.assertEquals(item.Id, updatedDiagnostic.dmpl__ItemId__c, 'Item should be updated to Item 1');
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithItemHealthCheckPositive() {}

    // @isTest
    // public static void updateAssetDiagnosticDataWithValueTypeRAGPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic(
    //         'HCD25060000',
    //         asset
    //     );
    //     diagnostic.dmpl__ValueType__c = 'RAG';
    //     update diagnostic;
    //     Test.stopTest();

    //     dmpl__AssetDiagnosticData__c updatedDiagnostic = [
    //         SELECT Id, Name, dmpl__AssetId__c, dmpl__ValueType__c
    //         FROM dmpl__AssetDiagnosticData__c
    //         WHERE Id = :diagnostic.Id
    //     ];

    //     System.assertEquals(asset.Id, updatedDiagnostic.dmpl__AssetId__c, 'Asset should remain Asset 2');
    //     System.assertEquals('RAG', updatedDiagnostic.dmpl__ValueType__c, 'Value Type should be updated to RAG');
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithStandardValueAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic(
    //         'HCD25060000',
    //         asset
    //     );
    //     diagnostic.dmpl__StandardValue__c = -1;
    //     try {
    //         update diagnostic;
    //         System.assert(false, 'Update should fail due to Standard Value = -1');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('Standard Value'), 'Expected failure on Standard Value');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithMinValueGreaterThanMaxValueNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset('Asset 2', partner1, Date.today(), branch1, null);
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic('HCD25060000', asset);
    //     diagnostic.dmpl__MinValue__c = 90;
    //     diagnostic.dmpl__MaxValue__c = 10;
    //     try {
    //         update diagnostic;
    //         System.assert(false, 'Update should fail due to Min Value > Max Value');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('Min Value'), 'Expected failure on Min > Max');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithLastValueAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset('Asset 2', partner1, Date.today(), branch1, null);
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic('HCD25060000', asset);
    //     diagnostic.dmpl__LastValue__c = -1;
    //     try {
    //         update diagnostic;
    //         System.assert(false, 'Update should fail due to Last Value as -1');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('Last Value'), 'Expected failure on Last Value = -1');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetDiagnosticDataWithMinValueAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset('Asset 2', partner1, Date.today(), branch1, null);
    //     dmpl__AssetDiagnosticData__c diagnostic = AssetTestDataHelper.createAssetDiagnosticDataBasic('HCD25060000', asset);
    //     diagnostic.dmpl__MinValue__c = -1;
    //     try {
    //         update diagnostic;
    //         System.assert(false, 'Update should fail due to Min Value as -1');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('Min Value'), 'Expected failure on Min Value = -1');
    //     }
    //     Test.stopTest();
    // }

    // //Asset Maintainance
    // @isTest
    // public static void createAssetMaintenanceWithAssetPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetMaintenance__c maintenance = AssetTestDataHelper.createBasicAssetMaintenance(
    //         'AM-000000',
    //         asset
    //     );
    //     Test.stopTest();

    //     dmpl__AssetMaintenance__c fetched = AssetTestDataHelper.getAssetMaintenance('AM-000000');
    //     System.assertEquals(asset.Id, fetched.dmpl__AssetId__c, 'Asset should be correctly linked in maintenance record');
    //     System.assertEquals('AM-000000', fetched.Name, 'Asset Maintenance name should match');
    // }

    // @isTest
    // public static void updateAssetMaintenanceWithServiceCampaignPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetMaintenance__c maintenance = AssetTestDataHelper.createBasicAssetMaintenance(
    //         'AM-000000',
    //         asset
    //     );
    //     dmpl__ServiceCampaign__c campaign = TestDataHelpers.createServiceCampaign('Campaign 1');
    //     maintenance.dmpl__ServiceCampaignId__c = campaign.Id;
    //     update maintenance;
    //     Test.stopTest();

    //     dmpl__AssetMaintenance__c updated = AssetTestDataHelper.getAssetMaintenance('AM-000000');
    //     System.assertEquals(campaign.Id, updated.dmpl__ServiceCampaignId__c, 'Service Campaign should be updated in Asset Maintenance');
    //     System.assertEquals(asset.Id, updated.dmpl__AssetId__c, 'Asset should remain linked');
    // }

    // @isTest
    // public static void updateAssetMaintenanceWithServiceCampaignItemPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
        
    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetMaintenance__c maintenance = AssetTestDataHelper.createBasicAssetMaintenance(
    //         'AM-000000',
    //         asset
    //     );
    //     dmpl__ServiceCampaign__c campaign = TestDataHelpers.createServiceCampaign('Campaign 1');
    //     dmpl__ServiceCampaignItem__c item = TestDataHelpers.createServiceCampaignItem('SCI0002', campaign);

    //     maintenance.dmpl__ServiceCampaignItemId__c = item.Id;
    //     update maintenance;
    //     Test.stopTest();

    //     dmpl__AssetMaintenance__c updated = AssetTestDataHelper.getAssetMaintenance('AM-000000');
    //     System.assertEquals(item.Id, updated.dmpl__ServiceCampaignItemId__c, 'Service Campaign Item should be updated in Asset Maintenance');
    //     System.assertEquals(asset.Id, updated.dmpl__AssetId__c, 'Asset should remain linked');
    // }

    // @isTest
    // public static void updateAssetMaintenanceWithServiceCampaignMemberPositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
        
    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetMaintenance__c maintenance = AssetTestDataHelper.createBasicAssetMaintenance(
    //         'AM-000000',
    //         asset
    //     );
    //     dmpl__ServiceCampaign__c campaign = TestDataHelpers.createServiceCampaign('Campaign 1');
    //     dmpl__ServiceCampaignMember__c member = TestDataHelpers.createServiceCampaignMember('SCM-0001', campaign);

    //     maintenance.dmpl__ServiceCampaignMemberId__c = member.Id;
    //     update maintenance;
    //     Test.stopTest();

    //     dmpl__AssetMaintenance__c updated = AssetTestDataHelper.getAssetMaintenance('AM-000000');
    //     System.assertEquals(member.Id, updated.dmpl__ServiceCampaignMemberId__c, 'Service Campaign Member should be updated in Asset Maintenance');
    //     System.assertEquals(asset.Id, updated.dmpl__AssetId__c, 'Asset should remain linked');
    // }

    // @isTest
    // public static void updateAssetMaintenanceWithIsMandatoryAsTruePositive() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     dmpl__AssetMaintenance__c maintenance = AssetTestDataHelper.createBasicAssetMaintenance(
    //         'AM-000000',
    //         asset
    //     );
    //     maintenance.dmpl__IsMandatory__c = true;
    //     update maintenance;
    //     Test.stopTest();

    //     dmpl__AssetMaintenance__c updated = AssetTestDataHelper.getAssetMaintenance('AM-000000');
    //     System.assertEquals(true, updated.dmpl__IsMandatory__c, 'IsMandatory should be true');
    //     System.assertEquals(asset.Id, updated.dmpl__AssetId__c, 'Asset should remain linked');
    // }

    // @isTest
    // public static void createAssetMaintenanceWithQuantityAsMinusOneNegative() {
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    //     Test.startTest();
    //     dmpl__Asset__c asset = AssetTestDataHelper.createAsset(
    //         'Asset 2',
    //         partner1,
    //         Date.today(),
    //         branch1,
    //         null
    //     );
    //     Boolean exceptionThrown = false;
    //     try {
    //         AssetTestDataHelper.createAssetMaintenance(
    //             'AM-000000',
    //             asset,
    //             null,
    //             null,
    //             null,
    //             false,
    //             -1
    //         );
    //     } catch (Exception e) {
    //         exceptionThrown = true;
    //     }
    //     Test.stopTest();

    //     System.assertEquals(true, exceptionThrown, 'Creation should fail when Quantity is -1');
    // }

    // //Asset Service Contract
    // @isTest
    // public static void createAssetServiceContractWithServiceContractPositive() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );
    //     Test.stopTest();

    //     dmpl__AssetServiceContract__c inserted = AssetTestDataHelper.getAssetServiceContract('SC25060002');
    //     System.assertNotEquals(null, inserted.Id, 'Asset Service Contract should be created');
    //     System.assertEquals(item1.Id, inserted.dmpl__ItemId__c, 'Item should match');
    //     System.assertEquals(contract.Id, inserted.dmpl__ItemServiceContractId__c, 'Service Contract should match');
    // }

    // @isTest
    // public static void updateAssetServiceContractWithServiceContractAndNewItemPositive() {
    //     Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');
    //     dmpl__Item__c item2 = TestDataHelpers.getItem('Item 2');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__ItemId__c = item2.Id;
    //     update asc;
    //     Test.stopTest();

    //     dmpl__AssetServiceContract__c updated = AssetTestDataHelper.getAssetServiceContract('SC25060002');
    //     System.assertEquals(item2.Id, updated.dmpl__ItemId__c, 'Item should be updated to new item');
    //     System.assertEquals(contract.Id, updated.dmpl__ItemServiceContractId__c, 'Service Contract should remain linked');
    // }

    // @isTest
    // public static void updateAssetServiceContractWithBillingAccountPositive() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    //     dmpl__Item__c item1  = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__BillingAccountId__c = partner1.Id;
    //     update asc;
    //     Test.stopTest();

    //     dmpl__AssetServiceContract__c updated = AssetTestDataHelper.getAssetServiceContract('SC25060002');
    //     System.assertEquals(partner1.Id, updated.dmpl__BillingAccountId__c, 'Billing Account should be updated');
    //     System.assertEquals(item1.Id, updated.dmpl__ItemId__c, 'Item should remain unchanged');
    //     System.assertEquals(contract1.Id, updated.dmpl__ItemServiceContractId__c, 'Service Contract should remain unchanged');
    // }

    // @isTest
    // public static void updateAssetServiceContractWithDueDateEarlierThanCurrentDateNegative() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__DueDate__c = Date.newInstance(2024, 1, 1);
    //     try {
    //         update asc;
    //         System.assert(false, 'Update should have failed due to due date being in the past');
    //     } catch (Exception e) {
    //         System.assert(e.getMessage().contains(''), 'Expected error for past due date'); 
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetServiceContractWithDueInHoursAsMinusOneNegative() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__DueInHours__c = -1;
    //     try {
    //         update asc;
    //         System.assert(false, 'Update should have failed due to negative Due In Hours');
    //     } catch (Exception e) {
    //         System.assert(e.getMessage().contains(''), 'Expected error for negative Due In Hours');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetServiceContractWithGraceUsageHoursAsMinusOneNegative() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__GraceUsageHours__c = -1;
    //     try {
    //         update asc;
    //         System.assert(false, 'Update should have failed due to negative Grace Usage Hours');
    //     } catch (Exception e) {
    //         System.assert(e.getMessage().contains(''), 'Expected error for negative Grace Usage Hours');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetServiceContractWithValidTillHoursAsMinusOneNegative() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__ValidTillHours__c = -1;
    //     try {
    //         update asc;
    //         System.assert(false, 'Update should have failed due to negative Valid Till Hours');
    //     } catch (Exception e) {
    //         System.assert(e.getMessage().contains(''), 'Expected error for negative Valid Till Hours');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetServiceContractWithActivatedDateLessThanCurrentDatePositive() {
    //     Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__ActivatedDate__c = Date.today().addDays(-1);
    //     update asc;
    //     Test.stopTest();

    //     dmpl__AssetServiceContract__c updated = AssetTestDataHelper.getAssetServiceContract('SC25060002');
    //     System.assertEquals(Date.today().addDays(-1), updated.dmpl__ActivatedDate__c, 'Activated Date should be updated to a past date');
    // }

    // @isTest
    // public static void updateAssetServiceContractWithGraceUsageDaysAsMinusOneNegative() {
    //     Account custome1r = TestDataHelpers.getCustomerAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    //     Test.startTest();
    //     dmpl__ServiceContract__c contract = ServiceContractTestDataHelper.createServiceContract(
    //         'Contract 1',
    //         customer1
    //     );
    //     dmpl__AssetServiceContract__c asc = AssetTestDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         contract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     asc.dmpl__GraceUsageDays__c = -1;
    //     try {
    //         update asc;
    //         System.assert(false, 'Update should have failed due to negative Grace Usage Days');
    //     } catch (Exception e) {
    //         System.assert(e.getMessage().contains(''), 'Expected failure due to invalid Grace Usage Days');
    //     }
    //     Test.stopTest();
    // }

    // //Asset Service Contract Line
    // @isTest
    // public static void createAssetServiceContractLineWithAssetServiceContractPositive() {
    //     Account customer1 = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer1);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     Test.startTest();
    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item1,
    //         null,
    //         2,
    //         0
    //     );
    //     Test.stopTest();

    //     System.assertNotEquals(null, ascLine.Id);
    //     System.assertEquals(assetServiceContract.Id, ascLine.dmpl__AssetServiceContractId__c);
    //     System.assertEquals(item1.Id, ascLine.dmpl__ItemId__c);
    //     System.assertEquals(2, ascLine.dmpl__Quantity__c);
    //     System.assertEquals(0, ascLine.dmpl__UtilizedQuantity__c);
    // }

    // @isTest
    // public static void updateAssetServiceContractLineWithNoAssetServiceContractNegative() {
    //     Account customer1 = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer1);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item1,
    //         null,
    //         2,
    //         0
    //     );

    //     Test.startTest();
    //     ascLine.dmpl__AssetServiceContractId__c = null;
    //     try {
    //         update ascLine;
    //         System.assert(false, 'Update should have failed due to missing Asset Service Contract');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('Asset Service Contract'), 'Expected validation error on missing Asset Service Contract');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void createAssetServiceContractLineWithComponentItemPositive() {
    //     Account customer1 = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer1);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     Test.startTest();
    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item1,
    //         item1,
    //         1,
    //         0
    //     );
    //     Test.stopTest();

    //     System.assertNotEquals(null, ascLine.Id);
    //     System.assertEquals(assetServiceContract.Id, ascLine.dmpl__AssetServiceContractId__c);
    //     System.assertEquals(item.Id, ascLine.dmpl__ComponentItemId__c);
    // }

    // @isTest
    // public static void createAssetServiceContractLineWithComponentItemPositive() {
    //     Account customer = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );

    //     Test.startTest();
    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item,
    //         item,
    //         1,
    //         0
    //     );
    //     Test.stopTest();

    //     System.assertNotEquals(null, ascLine.Id);
    //     System.assertEquals(assetServiceContract.Id, ascLine.dmpl__AssetServiceContractId__c);
    //     System.assertEquals(item.Id, ascLine.dmpl__ComponentItemId__c);
    // }

    // @isTest
    // public static void updateAssetServiceContractLineWithQuantityAsMinusOneNegative() {
    //     Account customer1 = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer1);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );
    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item1,
    //         item1,
    //         2,
    //         0
    //     );

    //     Test.startTest();
    //     ascLine.dmpl__Quantity__c = -1;
    //     try {
    //         update ascLine;
    //         System.assert(false, 'Update should have failed due to negative quantity.');
    //     } catch (DmlException e) {
    //         System.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')
    //             || e.getMessage().contains('Quantity'), 'Expected validation exception not thrown.');
    //     }
    //     Test.stopTest();
    // }

    // @isTest
    // public static void updateAssetServiceContractLineWithUtilizedQuantityAsMinusOneNegative() {
    //     Account customer1 = TestDataHelpers.createAccount('Customer 1');
    //     dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1');
    //     dmpl__ServiceContract__c serviceContract = AssetDataHelper.createServiceContract('Contract 1', customer1);
    //     dmpl__AssetServiceContract__c assetServiceContract = AssetDataHelper.createAssetServiceContract(
    //         'SC25060002',
    //         item1,
    //         serviceContract,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
    //     );
    //     dmpl__AssetServiceContractLine__c ascLine = AssetDataHelper.createAssetServiceContractLine(
    //         'ASC25060000',
    //         assetServiceContract,
    //         item1,
    //         item1,
    //         2,
    //         1
    //     );

    //     Test.startTest();
    //     ascLine.dmpl__UtilizedQuantity__c = -1;
    //     try {
    //         update ascLine;
    //         System.assert(false, 'Update should have failed due to negative utilized quantity.');
    //     } catch (DmlException e) {
    //         System.assert(
    //             e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')
    //             || e.getMessage().contains('Utilized Quantity'),
    //             'Expected validation exception not thrown.'
    //         );
    //     }
    //     Test.stopTest();
    // }
}