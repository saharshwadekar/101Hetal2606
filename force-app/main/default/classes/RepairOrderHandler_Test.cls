@isTest
private class RepairOrderHandler_Test {
   
   @TestSetup
    static void createRequiredData() {

        
        dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        dmpl__Item__c item2 = TestDataHelpers.createItem('Item 2','Product',false,false,false,'654345',false);

        
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

        Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        dmpl__Branch__c branch1 = TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);

        dmpl__TaxGroup__c taxGroupGST28partner1 = TestDataHelpers.createTaxGroup('GST 28', true, 'Line Level', partnerAccount1.Id, branch1.Id, null);
        dmpl__TaxGroupRule__c taxGroupRule28Item1 = TestDataHelpers.createTaxGroupRule('Within State',taxGroupGST28partner1.Id,item1.Id,null,null,null);


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
        dmpl__PriceList__c priceList1 = TestDataHelpers.createPriceList(partnerAccount1,branch1);
        dmpl__PriceListRules__c priceListRule = TestDataHelpers.createPriceListRules(priceList1,item1);
        dmpl__Quote__c serviceEstimate = QuoteTestDataHelpers.CreateServiceEstimate(branch,customerAccount,priceList,asset,null,item);
        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrder(item,branch,asset,serviceEstimate,customerAccount,resource);
        dmpl__RepairOrderTax__c tax = RepairOrderTestDataHelpers.createRepairOrderTax(repairOrder);
        dmpl__QuoteLine__c quoteLine=QuoteTestDataHelpers.CreateServiceEstimateLine(item1,priceListRule,taxGroupGST28partner1,null,serviceEstimate);
        
     
        dmpl__RepairOrderTimeSheet__c timeSheet = RepairOrderTestDataHelpers.createTimeSheet(repairOrder);
        RepairOrderTestDataHelpers.createTimeSheetLine(timeSheet);
       
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
    static void createRepairOrderLinePositive() {
        
        Account customerAccount1 = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount1 = TestDataHelpers.getPartnerAccount('Partner 1'); 
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');   
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal quantity = 1;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount1, branch, customerAccount1, usageReading
        );

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
            repairOrder, item, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrdersById(repairOrder.Id).get(0);
        System.assertNotEquals(null, fetchedOrder, 'Fetched Order should not be null');

        System.assertEquals(partnerAccount1.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner should be Partner 1');
        System.assertEquals(branch.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should be Branch 1');
        System.assertEquals(customerAccount1.Id, fetchedOrder.dmpl__AccountId__c, 'Customer should be Customer 1');
        System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage Reading should be 1000');
        System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals('Ring Rd', fetchedOrder.dmpl__BillingStreet__c, 'Billing Street should be Ring Rd');
        System.assertEquals('Pune', fetchedOrder.dmpl__BillingCity__c, 'Billing City should be Pune');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__BillingState__c, 'Billing State should be Maharashtra');
        System.assertEquals('440001', fetchedOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code should be 440001');
        System.assertEquals('Ring Road', fetchedOrder.dmpl__ShippingStreet__c, 'Shipping Street should be Ring Road');
        System.assertEquals('Nagpur', fetchedOrder.dmpl__ShippingCity__c, 'Shipping City should be Nagpur');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__ShippingState__c, 'Shipping State should be Maharashtra');
        System.assertEquals('India', fetchedOrder.dmpl__ShippingCountry__c, 'Shipping Country should be India');
        System.assertEquals('440001', fetchedOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code should be 440001');


        dmpl__RepairOrderLine__c fetchedLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);
        System.assertNotEquals(null, fetchedLine, 'Fetched Line should not be null');

        System.assertEquals(item.Id, fetchedLine.dmpl__ItemId__c, 'Item should be Item 1');
        System.assertEquals(quantity, fetchedLine.dmpl__Quantity__c, 'Quantity should be 1');
        System.assertEquals(unitPrice, fetchedLine.dmpl__UnitPrice__c, 'Unit Price should be 1500');
        System.assertEquals(taxGroup.Id, fetchedLine.dmpl__TaxGroupId__c, 'Tax Group should be 28');

        Decimal expectedAmount = quantity * unitPrice;
        Decimal expectedGrossAmount = expectedAmount * 1.28;

        System.assertEquals(expectedAmount, fetchedLine.dmpl__Amount__c, 'Amount should be 1500');
        System.assertEquals(expectedAmount, fetchedLine.dmpl__BaseAmount__c, 'Base Amount should be 1500');
        System.assertEquals(expectedGrossAmount, fetchedLine.dmpl__GrossAmount__c, 'Gross Amount should be 1920');
    }


    @isTest
    static void createRepairOrderLineWithReferenceNew() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal quantity = 1;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
            repairOrder, item, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrdersById(repairOrder.Id).get(0);
        System.assertNotEquals(null, fetchedOrder, 'Fetched Repair Order should not be null');

        System.assertEquals(partnerAccount.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner Account should match');
        System.assertEquals(branch.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should match');
        System.assertEquals(customerAccount.Id, fetchedOrder.dmpl__AccountId__c, 'Customer Account should match');
        System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage Reading should match');
        System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals('Ring Rd', fetchedOrder.dmpl__BillingStreet__c, 'Billing Street should be Ring Rd');
        System.assertEquals('Pune', fetchedOrder.dmpl__BillingCity__c, 'Billing City should be Pune');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__BillingState__c, 'Billing State should be Maharashtra');
        System.assertEquals('440001', fetchedOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code should be 440001');

        System.assertEquals('Ring Road', fetchedOrder.dmpl__ShippingStreet__c, 'Shipping Street should be Ring Road');
        System.assertEquals('Nagpur', fetchedOrder.dmpl__ShippingCity__c, 'Shipping City should be Nagpur');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__ShippingState__c, 'Shipping State should be Maharashtra');
        System.assertEquals('India', fetchedOrder.dmpl__ShippingCountry__c, 'Shipping Country should be India');
        System.assertEquals('440001', fetchedOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code should be 440001');

        dmpl__RepairOrderLine__c fetchedLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);
        System.assertNotEquals(null, fetchedLine, 'Fetched Repair Order Line should not be null');

        System.assertEquals(item.Id, fetchedLine.dmpl__ItemId__c, 'Item should match');
        System.assertEquals(quantity, fetchedLine.dmpl__Quantity__c, 'Quantity should match');
        System.assertEquals(unitPrice, fetchedLine.dmpl__UnitPrice__c, 'Unit Price should match');
        System.assertEquals(taxGroup.Id, fetchedLine.dmpl__TaxGroupId__c, 'Tax Group should match');

        Decimal expectedAmount = quantity * unitPrice;
        Decimal expectedGrossAmount = expectedAmount * 1.28;

        System.assertEquals(expectedAmount, fetchedLine.dmpl__Amount__c, 'Amount should match');
        System.assertEquals(expectedAmount, fetchedLine.dmpl__BaseAmount__c, 'Base Amount should match');
        System.assertEquals(expectedGrossAmount, fetchedLine.dmpl__GrossAmount__c, 'Gross Amount should match');
    }


    @isTest
    static void createRepairOrderLineWithoutRepairOrderReferenceNegative() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal quantity = 1;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );

        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created successfully');

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = new dmpl__RepairOrderLine__c(
            dmpl__ItemId__c = item.Id,
            dmpl__TaxGroupId__c = taxGroup.Id,
            dmpl__Quantity__c = quantity,
            dmpl__UnitPrice__c = unitPrice
        );
        
        try {
            insert roLine;
            System.assert(false, 'Expected exception due to missing Repair Order reference');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('dmpl__RepairOrder__c'), 'Error should mention missing Repair Order reference');
        }
        Test.stopTest();
    }

    @isTest
    static void createRepairOrderLineWithActiveItemPositive() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1'); 
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal quantity = 1;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );

        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created successfully');

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
            repairOrder, item, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrdersById(repairOrder.Id).get(0);
        System.assertNotEquals(null, fetchedOrder, 'Fetched Repair Order should not be null');

        System.assertEquals(partnerAccount.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner Account should match');
        System.assertEquals(branch.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should match');
        System.assertEquals(customerAccount.Id, fetchedOrder.dmpl__AccountId__c, 'Customer Account should match');
        System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage Reading should match');
        System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');

        System.assertEquals('Ring Rd', fetchedOrder.dmpl__BillingStreet__c, 'Billing Street should be Ring Rd');
        System.assertEquals('Pune', fetchedOrder.dmpl__BillingCity__c, 'Billing City should be Pune');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__BillingState__c, 'Billing State should be Maharashtra');
        System.assertEquals('440001', fetchedOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code should be 440001');

        System.assertEquals('Ring Road', fetchedOrder.dmpl__ShippingStreet__c, 'Shipping Street should be Ring Road');
        System.assertEquals('Nagpur', fetchedOrder.dmpl__ShippingCity__c, 'Shipping City should be Nagpur');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__ShippingState__c, 'Shipping State should be Maharashtra');
        System.assertEquals('India', fetchedOrder.dmpl__ShippingCountry__c, 'Shipping Country should be India');
        System.assertEquals('440001', fetchedOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code should be 440001');

        dmpl__RepairOrderLine__c fetchedLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);
        System.assertNotEquals(null, fetchedLine, 'Fetched Repair Order Line should not be null');

        System.assertEquals(item.Id, fetchedLine.dmpl__ItemId__c, 'Item should match');
        System.assertEquals(quantity, fetchedLine.dmpl__Quantity__c, 'Quantity should match');
        System.assertEquals(unitPrice, fetchedLine.dmpl__UnitPrice__c, 'Unit Price should match');
        System.assertEquals(taxGroup.Id, fetchedLine.dmpl__TaxGroupId__c, 'Tax Group should match');

        Decimal expectedAmount = quantity * unitPrice;
        Decimal expectedGrossAmount = expectedAmount * 1.28; 

        System.assertEquals(expectedAmount, fetchedLine.dmpl__Amount__c, 'Amount should match');
        System.assertEquals(expectedAmount, fetchedLine.dmpl__BaseAmount__c, 'Base Amount should match');
        System.assertEquals(expectedGrossAmount, fetchedLine.dmpl__GrossAmount__c, 'Gross Amount should match');
    }


    @isTest
    static void createRepairOrderLineWithInactiveItemNegative() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__Item__c inactiveItem = TestDataHelpers.getItem('Item 2');
        inactiveItem.dmpl__IsActive__c = false;

        Test.startTest();
        update inactiveItem;

        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal quantity = 1;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );
        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created successfully');

        Boolean exceptionThrown = false;
        
        try {
            RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
                repairOrder, inactiveItem, taxGroup, quantity, unitPrice
            );
        } catch (Exception e) {
            exceptionThrown = true;
            System.debug('Expected exception due to inactive item: ' + e.getMessage());
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Repair Order Line creation should fail with inactive item');

        dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrdersById(repairOrder.Id).get(0);

        System.assertEquals(partnerAccount.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner Account should match');
        System.assertEquals(branch.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should match');
        System.assertEquals(customerAccount.Id, fetchedOrder.dmpl__AccountId__c, 'Customer Account should match');
        System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage Reading should match');
        System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals('Ring Rd', fetchedOrder.dmpl__BillingStreet__c, 'Billing Street should be Ring Rd');
        System.assertEquals('Pune', fetchedOrder.dmpl__BillingCity__c, 'Billing City should be Pune');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__BillingState__c, 'Billing State should be Maharashtra');
        System.assertEquals('440001', fetchedOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code should be 440001');

        System.assertEquals('Ring Road', fetchedOrder.dmpl__ShippingStreet__c, 'Shipping Street should be Ring Road');
        System.assertEquals('Nagpur', fetchedOrder.dmpl__ShippingCity__c, 'Shipping City should be Nagpur');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__ShippingState__c, 'Shipping State should be Maharashtra');
        System.assertEquals('India', fetchedOrder.dmpl__ShippingCountry__c, 'Shipping Country should be India');
        System.assertEquals('440001', fetchedOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code should be 440001');
    }

    @isTest
    static void createRepairOrderLineWithZeroQuantityNegative() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 2');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');
        Decimal usageReading = 1000;
        Decimal unitPrice = 1500;
        Decimal zeroQuantity = 0;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );
        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created successfully');

        Boolean exceptionThrown = false;

        Test.startTest();
        try {
            RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
                repairOrder, item, taxGroup, zeroQuantity, unitPrice
            );
        } catch (Exception e) {
            exceptionThrown = true;
            System.debug('Expected exception due to zero quantity: ' + e.getMessage());
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Repair Order Line creation should fail with zero quantity');

        dmpl__RepairOrder__c fetchedOrder = RepairOrderTestDataHelpers.getRepairOrdersById(repairOrder.Id).get(0);

        System.assertEquals(partnerAccount.Id, fetchedOrder.dmpl__PartnerAccountId__c, 'Partner Account should match');
        System.assertEquals(branch.Id, fetchedOrder.dmpl__BranchId__c, 'Branch should match');
        System.assertEquals(customerAccount.Id, fetchedOrder.dmpl__AccountId__c, 'Customer Account should match');
        System.assertEquals(usageReading, fetchedOrder.dmpl__UsageReading__c, 'Usage Reading should match');
        System.assertEquals('Draft', fetchedOrder.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals('Ring Rd', fetchedOrder.dmpl__BillingStreet__c, 'Billing Street should be Ring Rd');
        System.assertEquals('Pune', fetchedOrder.dmpl__BillingCity__c, 'Billing City should be Pune');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__BillingState__c, 'Billing State should be Maharashtra');
        System.assertEquals('440001', fetchedOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code should be 440001');
        System.assertEquals('Ring Road', fetchedOrder.dmpl__ShippingStreet__c, 'Shipping Street should be Ring Road');
        System.assertEquals('Nagpur', fetchedOrder.dmpl__ShippingCity__c, 'Shipping City should be Nagpur');
        System.assertEquals('Maharashtra', fetchedOrder.dmpl__ShippingState__c, 'Shipping State should be Maharashtra');
        System.assertEquals('India', fetchedOrder.dmpl__ShippingCountry__c, 'Shipping Country should be India');
        System.assertEquals('440001', fetchedOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code should be 440001');
    }
//pr-54 -- not found 

    @isTest
    static void createRepairOrderLineWithQuoteLineReference() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

        dmpl__Quote__c quote = QuoteTestDataHelpers.getServiceEstimate();
        dmpl__QuoteLine__c quoteLine = QuoteTestDataHelpers.getServiceEstimateLine();

        Decimal usageReading = 1000;
        Decimal quantity = 1;
        Decimal unitPrice = 1500;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );
        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created');

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithQuoteLine(
            repairOrder, item, quoteLine, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrderLine__c fetchedOrderLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);

        System.assertEquals(quantity, fetchedOrderLine.dmpl__Quantity__c, 'Quantity should match input');
        System.assertEquals(unitPrice, fetchedOrderLine.dmpl__UnitPrice__c, 'Unit Price should match input');
        System.assertEquals(quoteLine.Id, fetchedOrderLine.dmpl__QuoteLineId__c, 'Quote Line should match');
        System.assertEquals(item.Id, fetchedOrderLine.dmpl__ItemId__c, 'Item should match');
        System.assertEquals(taxGroup.Id, fetchedOrderLine.dmpl__TaxGroupId__c, 'Tax Group should match');

        Decimal expectedBase = unitPrice * quantity;
        Decimal expectedTax = expectedBase * 0.28;
        Decimal expectedGross = expectedBase + expectedTax;

        System.assertEquals(expectedBase.setScale(2), roLine.dmpl__BaseAmount__c.setScale(2), 'Base Amount should match');
        System.assertEquals(expectedTax.setScale(2), roLine.dmpl__TaxAmount__c.setScale(2), 'Tax Amount should match');
        System.assertEquals(expectedGross.setScale(2), roLine.dmpl__GrossAmount__c.setScale(2), 'Gross Amount should match');
    }

    @isTest
    static void createRepairOrderLineWithAssetServiceContract() {

        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Patner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');
        dmpl__AssetServiceContract__c serviceContract = RepairOrderTestDataHelpers.getAssetServiceContract();

        Decimal usageReading = 1000;
        Decimal quantity = 1;
        Decimal unitPrice = 1500;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );
        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created');

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithServiceContract(
            repairOrder, item, serviceContract, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrderLine__c fetchedOrderLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);

        System.assertEquals(quantity, fetchedOrderLine.dmpl__Quantity__c, 'Quantity should match input');
        System.assertEquals(unitPrice, fetchedOrderLine.dmpl__UnitPrice__c, 'Unit Price should match input');
        System.assertEquals(serviceContract.Id, fetchedOrderLine.dmpl__AssetServiceContractId__c, 'Service Contract should match');
        System.assertEquals(item.Id, fetchedOrderLine.dmpl__ItemId__c, 'Item should match');
        System.assertEquals(taxGroup.Id, fetchedOrderLine.dmpl__TaxGroupId__c, 'Tax Group should match');

        Decimal expectedBase = unitPrice * quantity;
        Decimal expectedTax = expectedBase * 0.28;
        Decimal expectedGross = expectedBase + expectedTax;

        System.assertEquals(expectedBase, roLine.dmpl__BaseAmount__c, 'Base Amount should match');
        System.assertEquals(expectedTax, roLine.dmpl__TaxAmount__c, 'Tax Amount should match');
        System.assertEquals(expectedGross, roLine.dmpl__GrossAmount__c, 'Gross Amount should match');
    }

    
    //1 left 
    // one more left 

    @isTest
    static void createRepairOrderLineWithoutContract() {
        Account customerAccount = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('28');

        Decimal usageReading = 1000;
        Decimal quantity = 1;
        Decimal unitPrice = 1500;

        dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrderWithUsageReading(
            partnerAccount, branch, customerAccount, usageReading
        );
        System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created');

        Test.startTest();
        dmpl__RepairOrderLine__c roLine = RepairOrderTestDataHelpers.createRepairOrderLineWithTaxGroup(
        repairOrder, item, taxGroup, quantity, unitPrice
        );
        Test.stopTest();

        dmpl__RepairOrderLine__c fetchedOrderLine = RepairOrderTestDataHelpers.getRepairOrderLinesById(roLine.Id);

        System.assertEquals(quantity, fetchedOrderLine.dmpl__Quantity__c, 'Quantity should match');
        System.assertEquals(unitPrice, fetchedOrderLine.dmpl__UnitPrice__c, 'Unit Price should match');
        System.assertEquals(item.Id, fetchedOrderLine.dmpl__ItemId__c, 'Item should match');
        System.assertEquals(taxGroup.Id, fetchedOrderLine.dmpl__TaxGroupId__c, 'Tax Group should match');
        System.assertEquals(null, fetchedOrderLine.dmpl__ItemServiceContractId__c, 'Service Contract should be null');

        Decimal expectedBase = unitPrice * quantity;
        Decimal expectedTax = expectedBase * 0.28;
        Decimal expectedGross = expectedBase + expectedTax;

        System.assertEquals(expectedBase, roLine.dmpl__BaseAmount__c, 'Base Amount should match');
        System.assertEquals(expectedTax, roLine.dmpl__TaxAmount__c, 'Tax Amount should match');
        System.assertEquals(expectedGross, roLine.dmpl__GrossAmount__c, 'Gross Amount should match');
    }

    //last not found testcase

}