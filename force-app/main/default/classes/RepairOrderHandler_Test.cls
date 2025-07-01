@isTest
private class RepairOrderHandler_Test {
   
    @TestSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        Account customerAccount = TestDataHelpers.createCustomerAccount();
        dmpl__Branch__c branch = TestDataHelpers.createBranch(partnerAccount);
        dmpl__Item__c item = TestDataHelpers.createItem();
        dmpl__SKU__c sku = TestDataHelpers.createSKU(item);
        dmpl__Resource__c resource = TestDataHelpers.createResource(partnerAccount, branch);
        dmpl__StorageLocation__c storageLocation = TestDataHelpers.createStorageLocation(branch);
        dmpl__ItemLot__c itemLot = TestDataHelpers.createItemLot(branch, item, sku, storageLocation);
        dmpl__PriceList__c priceList = TestDataHelpers.createPriceList(partnerAccount, branch);
        Asset asset = AssetTestDataHelpers.CreateAsset(customerAccount,branch,item,itemLot,sku);
        dmpl__Quote__c serviceEstimate = QuoteTestDataHelpers.CreateServiceEstimate(branch,customerAccount,priceList,asset,null,item);
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrder(item,branch,asset,serviceEstimate,customerAccount,resource);
        dmpl__RepairOrderTax__c tax = RepairOrderTestDataHelpers.createRepairOrderTax(repairOrder);
     
        dmpl__RepairOrderTimeSheet__c timeSheet = RepairOrderTestDataHelpers.createTimeSheet(repairOrder);
        RepairOrderTestDataHelpers.createTimeSheetLine(timeSheet);


         Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, true, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount3 = TestDataHelpers.createPartnerAccount('Partner 3', false, true, false, true, '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '91-9123456789');
        Account partnerAccount4 = TestDataHelpers.createPartnerAccount('Partner 4', false, true, false, true, '12 Industrial Zone', 'Hyderabad','Telangana', 'India', '500032', '12 Industrial Zone', 'Hyderabad', 'Telangana', 'India','500032','9876012345');
        Account partnerAccount6 = TestDataHelpers.createPartnerAccount('Partner 6', false, true, false, true, 'MS Road', 'Bengaluru','Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India','560095','9845543210');

        Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        Account customerAccount2 = TestDataHelpers.createCustomerAccount('Customer 2', true, false, false, true, 'Park St', 'Kolkata', 'West Bengal', 'India', '700016', 'Lake Rd', 'Kolkata', 'West Bengal', 'India', '700029','9876543210', 'Created');
        Account customerAccount3 = TestDataHelpers.createCustomerAccount('Customer 3', true, false, false, true, 'Anna Salai', 'Chennai', 'Tamil Nadu', 'India', '600002', 'T Nagar', 'Chennai', 'Tamil Nadu', 'India', '600017','9012345678', 'Created');
        Account customerAccount6=TestDataHelpers.createCustomerAccount('Customer 6', true, false, false, true, 'Sector 18', 'Noida', 'Uttar Pradesh', 'India', '201301', 'Sector 62', 'Noida', 'Uttar Pradesh', 'India', '201309','9876501234', 'Created');
        Account customerAccount7=TestDataHelpers.createCustomerAccount('Customer 7', true, false, false, false, 'Mission Road', 'Bengaluru', 'Karnataka', 'India', '560027', 'Indiranagar', 'Bengaluru', 'Karnataka', 'India', '560038','9811122233', 'Created');

        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        dmpl__Branch__c branch4 =TestDataHelpers.createBranch('Branch 4',partnerAccount4.Id,true,true,false,false);
        dmpl__Branch__c branch3 = TestDataHelpers.createBranch('Branch 3', partnerAccount1.Id, false, true, true, false);
        dmpl__Branch__c branch6 =TestDataHelpers.createBranch('Branch 6',partnerAccount6.Id,true,true,false,true);

        dmpl__ContactAddress__c address1 = TestDataHelpers.createContactAddress('Address 1', 'Ring Rd', 'Pune', 'Maharashtra', customerAccount1.Id, 'Billing Address', '440001', false);
        dmpl__ContactAddress__c address2 = TestDataHelpers.createContactAddress('Address 2', 'Ring Rd', 'Pune', 'Maharashtra', customerAccount1.Id, 'Billing Address', '440001',false);
        dmpl__ContactAddress__c Address3 = TestDataHelpers.CreateContactAddress('Address 3', 'Lake Road', 'Kolkata', 'West Bengal', customerAccount1.Id,'Billing Address','440022',false);
        dmpl__ContactAddress__c address4 = TestDataHelpers.createContactAddress('Address 1', 'Ring Rd', 'Pune', 'Maharashtra', customerAccount2.Id, 'Billing Address', '440001', false);
        dmpl__ContactAddress__c address5 = TestDataHelpers.createContactAddress('Address 2', 'Ring Rd', 'Pune', 'Maharashtra', customerAccount2.Id, 'Shipping Address', '440001', false);

        dmpl__PriceList__c priceList1 = TestDataHelpers.createPriceList('Price List 1', partnerAccount1.Id, branch1.Id, null, null, true, false, 'Sale Price');
        dmpl__PriceList__c priceList2 = TestDataHelpers.createPriceList('Price List 2', partnerAccount1.Id, branch1.Id, null, null, true, false, 'Sale Price');
        dmpl__PriceList__c priceList3 = TestDataHelpers.createPriceList('Price List 3',partnerAccount4.Id,branch4.Id,null,null,true,false,'Sale Price');
        dmpl__PriceList__c priceList5=TestDataHelpers.createPriceList('Price List 5', partnerAccount6.Id, branch6.Id, null, null, false, false, 'Sales');
        dmpl__PriceList__c priceList7 = TestDataHelpers.createPriceList('Price List 7',null,null, null, null, true, false, 'Sales');

        dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        dmpl__Item__c item2 = TestDataHelpers.createItem('Item 2','Product',false,false,false,'654345',false);
        dmpl__Item__c item3 = TestDataHelpers.createItem('Item 3','Charge Item',true, false, false ,'765434',true);
        dmpl__Item__c item4 = TestDataHelpers.createItem('Item 4','Product',true, false, false ,'765676',true);
        dmpl__Item__c item5 = TestDataHelpers.createItem('Item 5', 'Product', true, false, false, '876543', false);


        Asset asset1 = AssetDataHelper.createAsset('Asset 1', customerAccount1.Id, item1.Id);
        Asset asset3 = AssetDataHelper.createAsset('Asset 3', customerAccount3.Id, item5.Id);

        dmpl__TaxGroup__c taxGroupGST28partner1 = TestDataHelpers.createTaxGroup('GST 28', true, 'Line Level', partnerAccount1.Id, branch1.Id, null);
        dmpl__TaxGroup__c taxGroupGST28partner4= TestDataHelpers.createTaxGroup('GST 288', true, 'Line Level', partnerAccount4.Id, branch4.Id, null);
        dmpl__TaxGroup__c taxGroupGST12Global = TestDataHelpers.createTaxGroup('GST 12', true, 'Line Level', null, null, null);
        dmpl__TaxGroup__c taxGroupIGST18 = TestDataHelpers.createTaxGroup('IGST 18', true, 'Line Level', null, null, null);
        
        
 
       
    }
 
    @isTest
    static void createRepairOrderPositive() {
        Account customerAccount = TestDataHelpers.getCustomerAccount();
        dmpl__Branch__c branch = TestDataHelpers.getBranch();
        dmpl__Item__c item = TestDataHelpers.getItem();
        dmpl__Resource__c resource = TestDataHelpers.getResource();
        Asset asset = AssetTestDataHelpers.getAsset();
        dmpl__PriceList__c priceList = TestDataHelpers.getPriceList();
        dmpl__RepairOrder__c createdOrder = RepairOrderTestDataHelpers.getRepairOrder();


        System.assertNotEquals(null, createdOrder.Id, 'Repair Order should be created');
        System.assertEquals(branch.Id, createdOrder.dmpl__BranchId__c, 'Branch should be linked');
    }
 
    @isTest
    static void updateRepairOrderPositive() {
        dmpl__RepairOrder__c existingOrder = RepairOrderTestDataHelpers.getRepairOrder();
 
        Test.startTest();
        existingOrder.dmpl__UsageReading__c = 70.00;
        update existingOrder;
        Test.stopTest();
 
        dmpl__RepairOrder__c updatedOrder = RepairOrderTestDataHelpers.getRepairOrder();
        System.assertEquals(70.00, updatedOrder.dmpl__UsageReading__c, 'Usage Reading should be updated to 70.00');
    }
 
    @isTest
    static void deleteRepairOrderPositive() {
        dmpl__RepairOrder__c existingOrder = RepairOrderTestDataHelpers.getRepairOrder();
        System.assertNotEquals(null, existingOrder.Id, 'Repair Order should exist before deletion');
 
        Test.startTest();
        delete existingOrder;
        Test.stopTest();
 
        List<dmpl__RepairOrder__c> remainingOrders = RepairOrderTestDataHelpers.getRepairOrdersById(existingOrder.Id);
        System.assertEquals(0, remainingOrders.size(), 'Repair Order should be deleted');
    }
 
    @isTest
    static void createRepairOrderTaxPositive() {
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.getRepairOrder();
        dmpl__RepairOrderTax__c tax = RepairOrderTestDataHelpers.createRepairOrderTax(repairOrder);
        dmpl__RepairOrderTax__c createdTax = RepairOrderTestDataHelpers.getRepairOrderTax();

        System.assertEquals(10, createdTax.dmpl__TaxRate__c, 'Tax Rate should be 10');
        System.assertEquals(100, createdTax.dmpl__TaxAmount__c, 'Tax Amount should be 100');
        System.assertEquals(100, createdTax.dmpl__TaxOnAmount__c, 'Tax On Amount should be 100');
    }
 
    @isTest
    static void updateRepairOrderTaxPositive() {
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.getRepairOrder();
        dmpl__RepairOrderTax__c tax = RepairOrderTestDataHelpers.getRepairOrderTax();
        Test.startTest();
        tax.dmpl__TaxAmount__c = 150;
        tax.dmpl__TaxOnAmount__c = 1000;
        update tax;
        Test.stopTest();
 
        dmpl__RepairOrderTax__c updatedTax = RepairOrderTestDataHelpers.getRepairOrderTax();
        System.assertEquals(150, updatedTax.dmpl__TaxAmount__c, 'Tax Amount should be 150');
        System.assertEquals(1000, updatedTax.dmpl__TaxOnAmount__c, 'Tax On Amount should be 1000');
    }
 
    @isTest
    static void deleteRepairOrderTaxePositive() {
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.getRepairOrder();
        dmpl__RepairOrderTax__c tax = RepairOrderTestDataHelpers.createRepairOrderTax(repairOrder);
        
        Test.startTest();
        RepairOrderTestDataHelpers.deleteRepairOrderTaxesByRepairOrder(repairOrder.Id);
        Test.stopTest();
 
        List<dmpl__RepairOrderTax__c> remainingTaxes = RepairOrderTestDataHelpers.getRepairOrderTaxesByRepairOrder(repairOrder.Id);
        System.assertEquals(0, remainingTaxes.size(), 'Should have no tax records remaining');
    }
 
    @isTest
    static void createTimeSheetPositive() {
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.getRepairOrder();
 
        Test.startTest();
        RepairOrderTestDataHelpers.createTimeSheet(repairOrder);
        Test.stopTest();
 
        List<dmpl__RepairOrderTimeSheet__c> timeSheets = RepairOrderTestDataHelpers.getTimeSheetsByRepairOrder(repairOrder.Id);
        System.assertEquals(2, timeSheets.size(), 'Should have two time sheets');
        dmpl__RepairOrderTimeSheet__c createdTimeSheet = timeSheets[1]; 
        System.assertNotEquals(null, createdTimeSheet.Id, 'Time Sheet should be created');
        System.assertEquals(repairOrder.Id, createdTimeSheet.dmpl__RepairOrderId__c, 'Repair Order should be linked');
        System.assertEquals(false, createdTimeSheet.dmpl__WorkEnded__c, 'Work Ended should be false');
        System.assertEquals(false, createdTimeSheet.dmpl__WorkPaused__c, 'Work Paused should be false');
        System.assertEquals(false, createdTimeSheet.dmpl__WorkStarted__c, 'Work Started should be false');
    }
 
    @isTest
    static void updateTimeSheetPositive() {
        dmpl__RepairOrderTimeSheet__c existingTimeSheet = RepairOrderTestDataHelpers.getTimeSheet();
        System.assertNotEquals(null, existingTimeSheet, 'Time sheet should exist from test setup');
 
        Test.startTest();
        existingTimeSheet.dmpl__WorkStarted__c = true;
        existingTimeSheet.dmpl__WorkPaused__c = true;       
        existingTimeSheet.dmpl__WorkEnded__c = true;
        update existingTimeSheet;
        Test.stopTest();
 
        dmpl__RepairOrderTimeSheet__c updatedTimeSheet = RepairOrderTestDataHelpers.getTimeSheet();
        System.assertEquals(true, updatedTimeSheet.dmpl__WorkStarted__c, 'Work Started should be updated to true');
        System.assertEquals(true, updatedTimeSheet.dmpl__WorkPaused__c, 'Work Paused should be updated to true');
        System.assertEquals(true, updatedTimeSheet.dmpl__WorkEnded__c, 'Work Ended should be updated to true');
    }
 
    @isTest
    static void deleteRepairOrderTimeSheetPositive() {
        dmpl__RepairOrderTimeSheet__c existingTimeSheet = RepairOrderTestDataHelpers.getTimeSheet();
        System.assertNotEquals(null, existingTimeSheet.Id, 'Repair Order Time Sheet should exist before deletion');
 
        Test.startTest();
        delete existingTimeSheet;
        Test.stopTest();
 
        List<dmpl__RepairOrderTimeSheet__c> remainingTimeSheets = RepairOrderTestDataHelpers.getRepairOrderTimeSheetsById(existingTimeSheet.Id);
        System.assertEquals(0, remainingTimeSheets.size(), 'Repair Order Time Sheet should be deleted');
    }
 
    @isTest
    static void createTimeSheetLinePositive() {
        dmpl__RepairOrderTimeSheet__c timeSheet = RepairOrderTestDataHelpers.getTimeSheet();
 
        Test.startTest();
        RepairOrderTestDataHelpers.createTimeSheetLine(timeSheet);
        Test.stopTest();
 
        List<dmpl__RepairOrderTimeSheetLine__c> timeSheetLines = RepairOrderTestDataHelpers.getTimeSheetLinesByTimeSheet(timeSheet.Id);
        System.assertEquals(2, timeSheetLines.size(), 'Should have two time sheet lines');
        dmpl__RepairOrderTimeSheetLine__c createdLine = timeSheetLines[1]; 
        System.assertNotEquals(null, createdLine.Id, 'Time Sheet Line should be created');
        System.assertEquals(timeSheet.Id, createdLine.dmpl__RepairOrderTimeSheetId__c, 'Time Sheet should be linked');
        System.assertEquals(1.00, createdLine.dmpl__ActualDurationHours__c, 'Actual Duration Hours should be 1.00');
    }
 
    @isTest
    static void updateTimeSheetLinePositive() {
        dmpl__RepairOrderTimeSheetLine__c existingLine = RepairOrderTestDataHelpers.getTimeSheetLine();
        System.assertNotEquals(null, existingLine, 'Time sheet line should exist from test setup');
 
        Test.startTest();
        existingLine.dmpl__ActualDurationHours__c = 2.50;
        update existingLine;
        Test.stopTest();
 
        dmpl__RepairOrderTimeSheetLine__c updatedLine = RepairOrderTestDataHelpers.getTimeSheetLine();
        System.assertEquals(2.50, updatedLine.dmpl__ActualDurationHours__c, 'Actual Duration Hours should be updated to 2.50');
    }
   
    @isTest
    static void deleteTimeSheetLinePositive() {
        dmpl__RepairOrderTimeSheetLine__c existingLine = RepairOrderTestDataHelpers.getTimeSheetLine();
        System.assertNotEquals(null, existingLine.Id, 'Time Sheet Line should exist before deletion');
 
        Test.startTest();
        delete existingLine;
        Test.stopTest();
 
        List<dmpl__RepairOrderTimeSheetLine__c> remainingLines = RepairOrderTestDataHelpers.getTimeSheetLinesById(existingLine.Id);
        System.assertEquals(0, remainingLines.size(), 'Time Sheet Line should be deleted');
    }

    @isTest
static void CreateRepairOrderWithCorrectPartnerAndBranchPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    //dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('Default Tax Group');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,null
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be 6/20/2025');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    
}
@isTest
static void createRepairOrderWithWrongPartnerAccountNegative() {
    // Arrange
    Account wrongPartner = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1'); 
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');

    Boolean exceptionThrown = false;
    Decimal usageReading = 1000;

    Test.startTest();
    try {
        RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
            wrongPartner,
            branch,
            customer,
            usageReading
        );
    } catch (Exception e) {
        exceptionThrown = true;
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Expected exception for wrong partner ');
}
@isTest
static void updateRepairOrderWithWrongPartnerAccountNegative() {

    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account partner3 = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;
    Boolean exceptionThrown = false;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be 6/20/2025');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    


    try {
        fetchedOrder.dmpl__PartnerAccountId__c = partner3.Id;
        update fetchedOrder;
    } catch (Exception e) {
        exceptionThrown = true;
    }
    Test.stopTest();


    System.assertEquals(true, exceptionThrown, 'Update should have failed due to wrong partner account');
}
@isTest
static void updateRepairOrderWithWrongBranchNegative() {

    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Branch__c branch4 = TestDataHelpers.getBranch('Branch 4'); 
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;
    Boolean exceptionThrown = false;


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );
    
    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1 initially');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');



    try {
        fetchedOrder.dmpl__BranchId__c = branch4.Id;
        update fetchedOrder;
    } catch (Exception e) {
        exceptionThrown = true;
    }
    Test.stopTest();
    System.assertEquals(true, exceptionThrown, 'Update should have failed due to wrong branch');
    
}
// Repair Order creation with wrong branch (New)
@isTest
static void createRepairOrderWithWrongBranchNegative() {
    // Arrange
    Account Partner = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch4 = TestDataHelpers.getBranch('Branch 4'); 
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');

    Boolean exceptionThrown = false;
    Decimal usageReading = 1000;

    Test.startTest();
    try {
        RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
            Partner,
            branch4,
            customer,
            usageReading
        );
    } catch (DmlException e) {
        exceptionThrown = true;
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Expected exception for mismatched partner and branch');
}
// Repair Order creation with inactive branch (New)
@isTest
static void createRepairOrderWithInactiveBranchNegative() {

    Account Partner = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 3'); 
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');

    Boolean exceptionThrown = false;
    Decimal usageReading = 1000;

    Test.startTest();
    try {
        RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
            Partner,
            branch,
            customer,
            usageReading
        );
    } catch (DmlException e) {
        exceptionThrown = true;
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Expected exception for mismatched partner and branch');
}
// Repair Order creation with inactive branch (Edit)
@isTest
static void updateRepairOrderWithInactiveBranchNegative() {

    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Branch__c branch3 = TestDataHelpers.getBranch('Branch 3'); 
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;
    Boolean exceptionThrown = false;


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );
    
    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1 initially');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');



    try {
        fetchedOrder.dmpl__BranchId__c = branch3.Id;
        update fetchedOrder;
    } catch (Exception e) {
        exceptionThrown = true;
    }
    Test.stopTest();
    System.assertEquals(true, exceptionThrown, 'Update should have failed due to inactive  branch');
    
}
// Repair Order with active customer account (New)

    @isTest
static void CreateRepairOrderWithActiveCustomerAccountPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('Default Tax Group'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,null
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');

}
// Repair Order with active customer account (Edit)
@isTest
static void updateRepairOrderWithActiveCustomerAccountPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress1 = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress1 = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1 initially');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    
    fetchedOrder.dmpl__AccountId__c = customer2.Id;
    update fetchedOrder;
    Test.stopTest();

    dmpl__RepairOrder__c updatedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, updatedOrder.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
    System.assertEquals(branch1.Id, updatedOrder.dmpl__BranchId__c, 'Branch should remain Branch 1');
    System.assertEquals(customer2.Id, updatedOrder.dmpl__AccountId__c, 'Account should now be Customer 2');
    System.assertEquals(usageReading, updatedOrder.dmpl__UsageReading__c, 'Usage reading should remain 1000');
    System.assertEquals(Date.today(), updatedOrder.dmpl__DocumentDate__c, 'Document date should remain today');
    System.assertEquals('Draft', updatedOrder.dmpl__Status__c, 'Status should remain Draft');

}
// Repair Order with in-active customer account (New)
@isTest
static void createRepairOrderWithInactiveCustomerAccountNegative() {

    Account Partner = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer = TestDataHelpers.getCustomerAccount('Customer 7');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 3'); 
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');

    Boolean exceptionThrown = false;
    Decimal usageReading = 1000;

    Test.startTest();
    try {
        RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
            Partner,
            branch,
            customer,
            usageReading
        );
    } catch (DmlException e) {
        exceptionThrown = true;
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Expected exception for inactive customer account');
}
// Repair Order with in-active customer account (Edit)
@isTest
static void updateRepairOrderWithInactiveCustomerAccountNegative() { // Blocked

    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    Account customer7 = TestDataHelpers.getCustomerAccount('Customer 7');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Branch__c branch3 = TestDataHelpers.getBranch('Branch 3'); 
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;
    Boolean exceptionThrown = false;


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer2,
        usageReading,
        null,
        taxGroup
    );
    
    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1 initially');
    System.assertEquals(customer2.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');


    try {
        fetchedOrder.dmpl__AccountId__c = customer7.Id;
        update fetchedOrder;
    } catch (Exception e) {
        exceptionThrown = true;
    }
    Test.stopTest();
    //System.assertEquals(true, exceptionThrown, 'Update should have failed due to inactive  branch');
    
}
// Repair Order creation with asset (New)
@isTest
static void CreateRepairOrderWithAsset() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    //dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('Default Tax Group');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,null
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');

}
// Repair Order creation without asset (New)
@isTest
static void CreateRepairOrderWithoutAsset() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    //dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('Default Tax Group');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,null
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

}
// Repair Order Creation with GST Tax (Global) (New)
@isTest
static void CreateRepairOrderWithGSTTaxPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 12');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    
}
// Repair Order Creation with IGST Tax (Global) (New)
@isTest
static void CreateRepairOrderWithIGSTTaxPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('IGST 18');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

}
// Repair Order with Billing & Shipping Address (New)
@isTest
static void CreateRepairOrderWithBillingAndShippingAddressPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('IGST 18');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');

}
// Repair Order with Multiple Billing & Shipping Address (New)
@isTest
static void CreateRepairOrderWithMultipleBillingAndShippingAddress() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('IGST 18');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

}
// Repair Order with Billing & Shipping Address (Edit)
@isTest
static void updateRepairOrderWithBillingAndShippingAddressPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress1 = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress1 = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1 initially');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

    fetchedOrder.dmpl__ShippingAddressId__c = shippingAddress1.Id;
    fetchedOrder.dmpl__BillingAddressId__c = billingAddress1.Id;
    fetchedOrder.dmpl__AccountId__c = customer2.Id;
    update fetchedOrder;
    Test.stopTest();

    dmpl__RepairOrder__c updatedOrder = RepairOrderTestDataHelpers.getRepairOrderById(fetchedOrder.Id);
    
    System.assertEquals(partner1.Id, updatedOrder.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
    System.assertEquals(branch1.Id, updatedOrder.dmpl__BranchId__c, 'Branch should remain Branch 1');
    System.assertEquals(customer2.Id, updatedOrder.dmpl__AccountId__c, 'Account should now be Customer 2');
    System.assertEquals(usageReading, updatedOrder.dmpl__UsageReading__c, 'Usage reading should remain 1000');
    System.assertEquals(Date.today(), updatedOrder.dmpl__DocumentDate__c, 'Document date should remain today');
    System.assertEquals('Draft', updatedOrder.dmpl__Status__c, 'Status should remain Draft');

}
// Repair Order with Usage Reading (New)
@isTest
static void CreateRepairOrderWithUsageReadingPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('IGST 18');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 

    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

}
// Repair Order with Usage Reading (Edit)
@isTest
static void updateRepairOrderWithActiveUsageReadingPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    Asset asset = AssetDataHelper.getAsset('Asset 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    dmpl__ContactAddress__c billingAddress1 = TestDataHelpers.getContactAddress('Address 1');
    dmpl__ContactAddress__c shippingAddress1 = TestDataHelpers.getContactAddress('Address 2');
    
    Decimal usageReading = 1000;

    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        usageReading,
        asset,
        taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    
    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1 initially');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be today');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    


    fetchedOrder.dmpl__ShippingAddressId__c = shippingAddress1.Id;
    fetchedOrder.dmpl__UsageReading__c = 1100;
    fetchedOrder.dmpl__AccountId__c = customer2.Id;
    update fetchedOrder;
    Test.stopTest();

    dmpl__RepairOrder__c updatedOrder = RepairOrderTestDataHelpers.getRepairOrderById(fetchedOrder.Id);
    
    System.assertEquals(partner1.Id, updatedOrder.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
    System.assertEquals(branch1.Id, updatedOrder.dmpl__BranchId__c, 'Branch should remain Branch 1');
    System.assertEquals(customer2.Id, updatedOrder.dmpl__AccountId__c, 'Account should now be Customer 2');
    System.assertEquals(1100, updatedOrder.dmpl__UsageReading__c, 'Usage reading should remain 1000');
    System.assertEquals(Date.today(), updatedOrder.dmpl__DocumentDate__c, 'Document date should remain today');
    System.assertEquals('Draft', updatedOrder.dmpl__Status__c, 'Status should remain Draft');

}
// Repair Order without Usage Reading (New)
@isTest
static void CreateRepairOrderWithoutUsageReadingPositive() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('IGST 18');
    dmpl__ContactAddress__c billingAddress = TestDataHelpers.getContactAddress('Address 1'); 
    dmpl__ContactAddress__c shippingAddress = TestDataHelpers.getContactAddress('Address 2'); 


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner1,
        branch1,
        customer1,
        null,
        null,taxGroup
    );

    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1 initially');
    System.assertEquals(branch1.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
    System.assertEquals(customer1.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 1');
    System.assertEquals(null, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(taxGroup.Id, fetchedOrder.dmpl__TaxGroupId__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be todays date');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    

}
// Repair Order with Price List for Partner Account & Branch (New)
@isTest
static void createRepairOrderWithPriceListforPartneraccountAndBranch() {

    Account partner4 = TestDataHelpers.getPartnerAccount('Partner 4');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch4 = TestDataHelpers.getBranch('Branch 4');
    dmpl__PriceList__c priceList=TestDataHelpers.createPriceList(partner4,branch4);
    dmpl__PriceList__c priceList2 =  TestDataHelpers.getPriceList('Price List 2');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    
    Decimal usageReading = 1000;


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner4,
        branch4,
        customer2,
        usageReading,
        null,
        taxGroup
    );
    

    repairOrder.dmpl__PriceListId__c = priceList2.Id;
    repairOrder.dmpl__DocumentDate__c = Date.today();
    update repairOrder;
    
    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner4.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 4');
    System.assertEquals(branch4.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 4');
    System.assertEquals(customer2.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 2');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be 6/6/2025');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    System.assertEquals(priceList2.Id, fetchedOrder.dmpl__PriceListId__c, 'Price List should be Price List 4');
    

}
// Repair Order with Price List for Partner Account Group (New)
// Repair Order Price List In-active (New)

@isTest
static void createRepairOrderWithPriceListPositive() {

    Account partner4 = TestDataHelpers.getPartnerAccount('Partner 4');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch4 = TestDataHelpers.getBranch('Branch 4');
    dmpl__PriceList__c priceList5 =  TestDataHelpers.getPriceList('Price List 5');
    dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup();
    
    Decimal usageReading = 1000;


    Test.startTest();
    dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderwithUsageReading(
        partner4,
        branch4,
        customer2,
        usageReading,
        null,
        taxGroup
    );
    

    repairOrder.dmpl__PriceListId__c = priceList5.Id;
    repairOrder.dmpl__DocumentDate__c = Date.today();
    update repairOrder;
    
    dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrderById(repairOrder.Id);
    Test.stopTest();

    System.assertEquals(partner4.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 4');
    System.assertEquals(branch4.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 4');
    System.assertEquals(customer2.Id, fetchedOrder.dmpl__AccountId__c, 'Account should be Customer 2');
    System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage reading should be 1000');
    System.assertEquals(Date.today(), fetchedOrder.dmpl__DocumentDate__c, 'Document date should be 6/6/2025');
    System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
    System.assertEquals(priceList5.Id, fetchedOrder.dmpl__PriceListId__c, 'Price List should be Price List 4');
    
}

}