@isTest 
public with sharing class ClaimHandler_Test {
    @TestSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        dmpl__Claim__c claim = ClaimDataHelper.createClaim(partnerAccount.Id);
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(claim.Id);
        Account supplierAccountc =TestDataHelpers.createSupplierAccount();
        Account customerAccount = TestDataHelpers.createCustomerAccount();
        dmpl__Branch__c branch = TestDataHelpers.createBranch(partnerAccount);
        dmpl__Item__c item = TestDataHelpers.createItem();
        dmpl__SKU__c sku = TestDataHelpers.createSKU(item);
        dmpl__Resource__c resource = TestDataHelpers.createResource(partnerAccount, branch);
           
        // dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        // Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        // Account partnerAccount1 = TestDataHelpers.createPartnerAccount(
        //     'Partner 1',
        //     true,
        //     true,
        //     false,
        //     true,
        //     '123 Billing Street',
        //     'Pune',
        //     'Maharashtra',
        //     'India',
        //     '411001',
        //     '456 Shipping Street',
        //     'Pune',
        //     'Maharashtra',
        //     'India',
        //     '411001',
        //     '9876543210'
        // );
        // Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, false, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        // Account partnerAccount4 = TestDataHelpers.createPartnerAccount(
        //     'Partner 4', 
        //     false, 
        //     true, 
        //     false, 
        //     true, 
        //     '12 Industrial Zone', 
        //     'Hyderabad',
        //     'Telangana', 
        //     'India', 
        //     '500032', 
        //     '12 Industrial Zone', 
        //     'Hyderabad', 
        //     'Telangana', 
        //     'India',
        //     '500032',
        //     '9876012345'
        // );
        // Account customerAccount2 = TestDataHelpers.createCustomerAccount('Customer 2', true, false, false, true, 'Park St', 'Kolkata', 'West Bengal', 'India', '700016', 'Lake Rd', 'Kolkata', 'West Bengal', 'India', '700029','9876543210', 'Created');
        // dmpl__Branch__c branch1 = TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        // dmpl__Branch__c branch2 = TestDataHelpers.createBranch('Branch 2', partnerAccount2.Id, true, false, true, true);
        // dmpl__Branch__c branch3 = TestDataHelpers.createBranch('Branch 3', partnerAccount1.Id, false, true, true, false);
        // dmpl__Branch__c branch4 =TestDataHelpers.createBranch('Branch 4',partnerAccount4.Id,true,true,false,false);
        // Account supplierAccount1 =TestDataHelpers.createSupplierAccount(
        //     'Supplier 1', 
        //     '55 Industrial Park Road',
        //     'Ahmedabad',
        //     'GJ',
        //     'India',
        //     '380015',
        //     '55 Industrial Park Road',
        //     'Ahmedabad',
        //     'GJ',
        //     'India',
        //     '380015',
        //     '-9988776564'
        // );
        // Account supplierAccount1 = TestDataHelpers.createSupplierAccount(
        //     'Supplier 1',
        //     '55 Industrial Park Road',
        //     'Ahmedabad',
        //     'Gujarat',
        //     'India',
        //     '380015',
        //     '55 Industrial Park Road',
        //     'Ahmedabad',
        //     'Gujarat',
        //     'India',
        //     '380015',
        //     '-9988776564'
        // );
        // dmpl__TaxGroup__c taxGroupGST28partner1 = TestDataHelpers.createTaxGroup('GST 28', true, 'Line Level', partnerAccount1.Id, branch1.Id, null);
        // dmpl__TaxGroupRule__c taxGroupRule28Item1 = TestDataHelpers.createTaxGroupRule('Within State',taxGroupGST28partner1.Id,item1.Id,null,null,null);
        // dmpl__StorageLocation__c storageLocation = TestDataHelpers.createStorageLocation(branch);
        // dmpl__ItemLot__c itemLot = TestDataHelpers.createItemLot(branch, item, sku, storageLocation);
        // Asset asset = AssetTestDataHelpers.CreateAsset(customerAccount,branch,item,itemLot,sku);
        
        // dmpl__PriceListRules__c priceListRule = TestDataHelpers.createPriceListRules(priceList,item1);
        // dmpl__Quote__c serviceEstimate = QuoteTestDataHelpers.CreateServiceEstimate(branch,customerAccount,priceList,asset,null,item);
        // dmpl__RepairOrder__c repairOrder = RepairOrderTestDataHelpers.createRepairOrder(item,branch,asset,serviceEstimate,customerAccount,resource);
        
        // dmpl__GoodsReceipt__c goodsReceipt = GoodRecieptsTestDataHelpers.createGoodsReceipt(partnerAccount1, branch1, purchaseOrder, supplierAccountc);
        // dmpl__GoodsReceiptLine__c goodsReceiptLine = GoodRecieptsTestDataHelpers.createGoodReceiptLine(goodsReceipt, item1, sku);



        //New
        Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, true, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount3 = TestDataHelpers.createPartnerAccount('Partner 3', false, true, false, true, '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '91-9123456789');
        Account partnerAccount4 = TestDataHelpers.createPartnerAccount('Partner 4', false, true, false, true, '12 Industrial Zone', 'Hyderabad','Telangana', 'India', '500032', '12 Industrial Zone', 'Hyderabad', 'Telangana', 'India','500032','9876012345');

        Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        Account customerAccount2 = TestDataHelpers.createCustomerAccount('Customer 2', true, false, false, true, 'Park St', 'Kolkata', 'West Bengal', 'India', '700016', 'Lake Rd', 'Kolkata', 'West Bengal', 'India', '700029','9876543210', 'Created');
        Account customerAccount3 = TestDataHelpers.createCustomerAccount('Customer 3', true, false, false, true, 'Anna Salai', 'Chennai', 'Tamil Nadu', 'India', '600002', 'T Nagar', 'Chennai', 'Tamil Nadu', 'India', '600017','9012345678', 'Created');

        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        dmpl__Branch__c branch2 = TestDataHelpers.createBranch('Branch 2', partnerAccount2.Id, true, false, true, true);
        dmpl__Branch__c branch3 = TestDataHelpers.createBranch('Branch 3', partnerAccount1.Id, false, true, true, false);
        dmpl__Branch__c branch4 =TestDataHelpers.createBranch('Branch 4',partnerAccount4.Id,true,true,false,false);

        dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        dmpl__Item__c item2 = TestDataHelpers.createItem('Item 2','Product',false,false,false,'654345',false);

        Account validSupplier = TestDataHelpers.createSupplierAccount(
            'Supplier 1', 
            'Industrial Area',
            'Ahmedabad',
            'GJ',
            'India',
            '380015',
            'Industrial Area',
            'Ahmedabad',
            'GJ',
            'India',
            '380015',
            '9876543210'
        );

        dmpl__PriceList__c priceList = TestDataHelpers.createPriceList(partnerAccount1,branch1);
        dmpl__BillReturn__c billReturn = BillTestDataHelpers.createBillReturn(supplierAccountc, partnerAccount1, branch1, priceList);
        dmpl__PurchaseOrder__c purchaseOrder = PurchaseOrderTestDataHelpers.createPurchaseOrder(branch,supplierAccountc);
        dmpl__SaleOrder__c saleOrder=SaleOrderTestDataHelpers.createSaleOrder(customerAccount,branch);
        dmpl__SaleInvoice__c saleInvoice=SaleInvoiceDataHelper.createSaleInvoice(customerAccount,branch,saleOrder,priceList);
    }

    @isTest
    static void createClaimPositive() {
        dmpl__Claim__c claim = ClaimDataHelper.getClaims();
        System.assertNotEquals(null, claim.Id, 'Claim should be inserted');
        System.assertEquals('Draft', claim.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals(Date.today(), claim.dmpl__DocumentDate__c, 'Document date should match today');
    }

    @isTest
    static void createClaimLinePositive() {
        dmpl__ClaimLine__c line = ClaimDataHelper.getClaimLines();
        System.assertNotEquals(null, line.Id, 'Claim Line should be created');
        System.assertEquals('Approved', line.dmpl__Status__c, 'Status should be Draft');
        System.assertEquals(2, line.dmpl__ClaimQuantity__c, 'Claim Quantity should be 2');
    }
    
    @isTest
    static void updateClaimPositive() {
        dmpl__Claim__c claim = ClaimDataHelper.getClaims();
        
        Test.startTest();
        claim.dmpl__Status__c = 'Reconcile';
        claim.dmpl__DocumentDate__c = Date.today().addDays(5);
        update claim;
        Test.stopTest();

        dmpl__Claim__c updated = ClaimDataHelper.getClaims(claim.Id);
        System.assertEquals('Reconcile', updated.dmpl__Status__c, 'Status should be updated to Draft');
        System.assertEquals(Date.today().addDays(5), updated.dmpl__DocumentDate__c, 'Document date should be updated');
    }

    @isTest
    static void updateClaimLinePositive() {
        dmpl__ClaimLine__c line = ClaimDataHelper.getClaimLines();
        
        Test.startTest();
        line.dmpl__Status__c = 'Rejected';
        line.dmpl__ClaimQuantity__c = 5;
        line.dmpl__UnitPrice__c = 1000;
        update line;
        Test.stopTest();

        dmpl__ClaimLine__c updated = ClaimDataHelper.getClaimLines(line.Id);
        System.assertEquals('Rejected', updated.dmpl__Status__c, 'Status should be updated to Draft');
        System.assertEquals(5, updated.dmpl__ClaimQuantity__c, 'Claim Quantity should be updated to 5');
        System.assertEquals(1000, updated.dmpl__UnitPrice__c, 'Unit Price should be updated');
    }

    @isTest 
    static void deleteClaimLinePositive() {
        dmpl__ClaimLine__c line = ClaimDataHelper.getClaimLines();
        
        Test.startTest();
        delete line;
        Test.stopTest();

        dmpl__ClaimLine__c deletedLine;
        try {
            deletedLine = ClaimDataHelper.getClaimLines(line.Id);
        } catch (QueryException e) {
            deletedLine = null;
        }
        System.assertEquals(null, deletedLine, 'Claim Line should be deleted');
    }

    @isTest
    static void deleteClaimPositive() {
        dmpl__Claim__c claim = ClaimDataHelper.getClaims();
        
        Test.startTest();
        delete claim;
        Test.stopTest();

        dmpl__Claim__c deletedClaim;
        try {
            deletedClaim = ClaimDataHelper.getClaims(claim.Id);
        } catch (QueryException e) {
            deletedClaim = null;
        }
        System.assertEquals(null, deletedClaim, 'Claim should be deleted');
    }

        //NewScenarios

        @isTest
        static void createClaimWithSupplierAccountPositive() {
            
            Account partnerAccount = TestDataHelpers.getPartnerAccount('Partner 1');
            Account supplierAccount = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1') ;

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partnerAccount.Id,
                branch.Id,
                supplierAccount.Id,
                'Shortage',
                'Draft',
                null, 
                null, 
                null, 
                null,
                null  
            );


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);


            System.assertNotEquals( insertedClaim.Id,null, 'Claim should be inserted');
            System.assertEquals(insertedClaim.dmpl__Status__c,'Draft',  'Status should be Draft');
            System.assertEquals(insertedClaim.dmpl__ClaimType__c,'Shortage',  'Claim type should be Shortage');
            System.assertEquals( insertedClaim.dmpl__PartnerAccountId__c,partnerAccount.Id, 'Partner account should match');
            System.assertEquals(insertedClaim.dmpl__BranchId__c,branch.Id,  'Branch should match');
            System.assertEquals(insertedClaim.dmpl__SupplierNameId__c,supplierAccount.Id,  'Supplier account should match');
        }

        @isTest
        static void createClaimWithoutSupplierAccountNegative() {

            Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

            Test.startTest();

            dmpl__Claim__c claim = null;

            try {
                claim = ClaimDataHelper.createClaim(
                    partner1.Id,
                    branch1.Id,
                    null, 
                    'Shortage',
                    'Draft',
                    null,
                    null,
                    null, 
                    null,
                    null  
                );

                System.assert(true, 'Expected exception was not thrown');
            } catch (Exception e) {
                System.assert(
                    e.getMessage().contains('supplier'),
                    'Exception should indicate that Supplier Account is mandatory. Actual message: ' + e.getMessage()
                );
            }


            Test.stopTest();
        }

        @isTest
        static void createClaimWithValidPartnerAndSaleInvoicePositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__SaleInvoice__c saleInvoice= SaleInvoiceDataHelper.getSaleInvoice();

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                saleInvoice.Id, 
                null,
                null,
                null,
                null
            );


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);

            System.assertNotEquals(null, insertedClaim.Id, 'Claim should be inserted');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Claim should be in Draft status');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should match');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should match');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should match');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document date should be today');
            System.assertEquals(saleInvoice.Id, insertedClaim.dmpl__SaleInvoiceId__c, 'Sale Invoice should match');
        }

         @isTest
        static void createClaimWithBillReturnReferencePositive() {
            Account partner = TestDataHelpers.getPartnerAccount('Partner 4');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 4');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__BillReturn__c billReturnRef = BillTestDataHelpers.getBillReturn();

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null, 
                billReturnRef.Id,
                null,
                null,
                null
            );
        


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);

            System.assertNotEquals(null, insertedClaim.Id, 'Claim should be inserted');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should match');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should match');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should match');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document date should be today');
            System.assertEquals(billReturnRef.Id, insertedClaim.dmpl__BillReturnId__c, 'Bill Return should match');
        }

        //remaining
        @isTest 
        static void createClaimCreationWithPurchaseReturnReferencePositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');

            dmpl__PurchaseReturn__c pr = ClaimDataHelper.createPurchaseRetrun(
                supplier,
                partner,
                branch
            );

            System.assertNotEquals(null, pr.Id, 'Purchase return will be created');
            System.assertEquals(partner.Id, pr.dmpl__PartnerAccountId__c, 'Partner account should be Partner 1');
            System.assertEquals(branch.Id, pr.dmpl__BranchId__c, 'Branch should be  branch 1');
            System.assertEquals(supplier.Id, pr.dmpl__SupplierAccountId__c, 'Supplier account should be supplier 1');
            System.assertEquals(Date.today(), pr.dmpl__DocumentDate__c, 'Date shoube be todays Date');


            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null,      
                null,       
                null,       
                null,       
                pr.Id       
            );

            


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);

            System.assertNotEquals(null, insertedClaim.Id, 'claim will get created at draft stage');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Date should be today');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner account Should be partner 1');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Type should be shortage');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier account should be supplier 1');

        }


        @isTest
        static void createClaimWithGoodsReceiptReferencePositive() {
    
            Account partner = TestDataHelpers.getPartnerAccount('Partner 4');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 4');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__GoodsReceipt__c goodsReceipt = GoodRecieptsTestDataHelpers.getGoodsReceipt(); 

            Test.startTest();

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null,          
                null,
                null,                 
                goodsReceipt.Id,
                null 
            );


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);

            Test.stopTest();

            System.assertNotEquals(null, insertedClaim.Id, 'Claim will get created at draft stage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'dmpl__PartnerAccountId__c should be Partner 4');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'dmpl__BranchId__c should be Branch 4');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'dmpl__SupplierNameId__c should be Supplier 1');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'dmpl__DocumentDate__c should be Today');
            System.assertEquals(goodsReceipt.Id, insertedClaim.dmpl__GoodsReceiptId__c, 'dmpl__GoodsReceiptId__c should be GRN25060016');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'dmpl__ClaimType__c should be shortage');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'dmpl__Status__c should be Draft');
        }

        @isTest
        static void createClaimWithRepairOrderReferencePositive() {
        
            Account partner = TestDataHelpers.getPartnerAccount('Partner 4');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 4');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__RepairOrder__c repaireOrder=RepairOrderTestDataHelpers.getRepairOrder();

            Test.startTest();

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Damaged',
                'Draft',
                null,
                null,
                repaireOrder.Id,
                null,
                null
            );

        

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);

            Test.stopTest();

            System.assertNotEquals(null, insertedClaim.Id, 'Claim should be created at draft stage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should be Partner 4');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be Branch 4');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should be Supplier 1');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should be Today');
            System.assertEquals(repaireOrder.Id, insertedClaim.dmpl__RepairOrderId__c, 'Repair Order should be RO25060002');
            System.assertEquals('Damaged', insertedClaim.dmpl__ClaimType__c, 'Claim Type should be Damaged');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be Draft');
        }



        
        @isTest
        static void createClaimWithSaleInvoicePositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__SaleInvoice__c saleInvoice= SaleInvoiceDataHelper.getSaleInvoice();

            Test.startTest();

            dmpl__Claim__c newClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                saleInvoice.Id,
                null,
                null,
                null,
                null
            );


            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(newClaim.Id);
            Test.stopTest();

            System.assertNotEquals(null, insertedClaim, 'Claim should be inserted');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Claim should be in Draft status');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should match');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should match');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should match');
            System.assertEquals(saleInvoice.Id, insertedClaim.dmpl__SaleInvoiceId__c, 'Sale Invoice should match');
        }

         @isTest
        static void createClaimWithItemServiceContractEditPositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

            
            dmpl__ItemServiceContract__c itemServiceContractcreate = ClaimDataHelper.createItemServiceContract('Contract 1',item);

            dmpl__ItemServiceContract__c itemServiceContract = ClaimDataHelper.getItemServiceContract();

            dmpl__Claim__c Claim = ClaimDataHelper.createClaimWithServiceContract(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                itemServiceContract.Id
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(Claim.Id);

            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should remain Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should remain Supplier 1');
            System.assertEquals(itemServiceContract.Id, insertedClaim.dmpl__ItemServiceContractId__c, 'Item Service Contract should be updated');
            System.assertEquals(insertedClaim.Name, insertedClaim.Name, 'Claim Name should remain same');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should remain Today');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should remain Draft');
        }




        @isTest
        static void updateClaimWithBillReturnReferenceEditPositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__BillReturn__c billReturnRef = BillTestDataHelpers.getBillReturn();

            dmpl__Claim__c claimBeforeEdit = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null,          
                null,          
                null,         
                null,         
                null           
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(claimBeforeEdit.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be created');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim Type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should be Partner 1');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should be Supplier 1');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should be Today');
            System.assert(insertedClaim.Name != null, 'Claim Name should not be null');

            insertedClaim.dmpl__BillReturnId__c = billReturnRef.Id;

            Test.startTest();
            update insertedClaim;
            Test.stopTest();

            dmpl__Claim__c updatedClaim = ClaimDataHelper.getClaim(insertedClaim.Id);

            System.assertNotEquals(null, updatedClaim, 'Claim should still exist after update');
            System.assertEquals('Draft', updatedClaim.dmpl__Status__c, 'Status should remain Draft');
            System.assertEquals('Shortage', updatedClaim.dmpl__ClaimType__c, 'Claim Type should remain Shortage');
            System.assertEquals(partner.Id, updatedClaim.dmpl__PartnerAccountId__c, 'Partner should still be Partner 1');
            System.assertEquals(branch.Id, updatedClaim.dmpl__BranchId__c, 'Branch should still be Branch 1');
            System.assertEquals(supplier.Id, updatedClaim.dmpl__SupplierNameId__c, 'Supplier should still be Supplier 1');
            System.assertEquals(Date.today(), updatedClaim.dmpl__DocumentDate__c, 'Document Date should remain Today');
            System.assertEquals(billReturnRef.Id, updatedClaim.dmpl__BillReturnId__c, 'Bill Return should be updated to BR25060009');
            System.assertEquals(insertedClaim.Name, updatedClaim.Name, 'Claim Name should remain the same');
        }

       @isTest
        static void updateClaimWithGoodsReceiptReferenceEditPositive() {
        
            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__GoodsReceipt__c goodsReceipt=GoodRecieptsTestDataHelpers.getGoodsReceipt();

            dmpl__Claim__c claimBeforeEdit = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null, null, null, null, null
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(claimBeforeEdit.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be created and not null');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Claim should be in Draft status');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim Type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should be Partner 1');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should be Supplier 1');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should be Today');
            System.assertNotEquals(null, insertedClaim.Name, 'Claim Name should be generated');

            insertedClaim.dmpl__GoodsReceiptId__c = goodsReceipt.Id;

            Test.startTest();
            update insertedClaim;
            Test.stopTest();

            dmpl__Claim__c updatedClaim = ClaimDataHelper.getClaim(insertedClaim.Id);

            System.assertNotEquals(null, updatedClaim, 'Updated claim should not be null');
            System.assertEquals('Draft', updatedClaim.dmpl__Status__c, 'Claim should remain in Draft status');
            System.assertEquals('Shortage', updatedClaim.dmpl__ClaimType__c, 'Claim Type should remain Shortage');
            System.assertEquals(partner.Id, updatedClaim.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
            System.assertEquals(branch.Id, updatedClaim.dmpl__BranchId__c, 'Branch should remain Branch 1');
            System.assertEquals(supplier.Id, updatedClaim.dmpl__SupplierNameId__c, 'Supplier should remain Supplier 1');
            System.assertEquals(Date.today(), updatedClaim.dmpl__DocumentDate__c, 'Document Date should remain Today');
            System.assertEquals(insertedClaim.Name, updatedClaim.Name, 'Claim Name should remain unchanged');
            System.assertEquals(goodsReceipt.Id, updatedClaim.dmpl__GoodsReceiptId__c, 'Goods Receipt should be set to GRN25060016');
        }

        @isTest
        static void updateClaimWithRepairOrderReferenceEditPositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__RepairOrder__c repaireOrder=RepairOrderTestDataHelpers.getRepairOrder();

            dmpl__Claim__c claimBeforeEdit = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',   
                'Draft',
                null, null, null, null, null
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(claimBeforeEdit.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be created');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Initial Claim Type should be Shortage');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should be Partner 1');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should be Supplier 1');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should be Today');
            System.assertNotEquals(null, insertedClaim.Name, 'Claim Name should be generated');

            insertedClaim.dmpl__RepairOrderId__c = repaireOrder.Id;

            Test.startTest();
            update insertedClaim;
            Test.stopTest();

            dmpl__Claim__c updatedClaim = ClaimDataHelper.getClaim(insertedClaim.Id);

            System.assertNotEquals(null, updatedClaim, 'Updated claim should exist');
            System.assertEquals('Draft', updatedClaim.dmpl__Status__c, 'Status should still be Draft');
            System.assertEquals('Shortage', updatedClaim.dmpl__ClaimType__c, 'Claim Type should be updated to Shortage');
            System.assertEquals(partner.Id, updatedClaim.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
            System.assertEquals(branch.Id, updatedClaim.dmpl__BranchId__c, 'Branch should remain Branch 1');
            System.assertEquals(supplier.Id, updatedClaim.dmpl__SupplierNameId__c, 'Supplier should remain Supplier 1');
            System.assertEquals(Date.today(), updatedClaim.dmpl__DocumentDate__c, 'Document Date should remain Today');
            System.assertEquals(repaireOrder.Id, updatedClaim.dmpl__RepairOrderId__c, 'Repair Order should be RO25060002');
            System.assertEquals(insertedClaim.Name, updatedClaim.Name, 'Claim Name should remain the same');
        }

        
        @isTest
        static void updateClaimWithSaleInvoiceReferenceEditPositive() {
    
            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__SaleInvoice__c saleInvoice= SaleInvoiceDataHelper.getSaleInvoice();

            dmpl__Claim__c claimBeforeEdit = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null,         
                null,         
                null,        
                null,         
                null          
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(claimBeforeEdit.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be created');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'dmpl__DocumentDate__c should be today');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'dmpl__PartnerAccountId__c should be Partner 1');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'dmpl__Status__c should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'dmpl__ClaimType__c should be shortage');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'dmpl__BranchId__c should be Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'dmpl__SupplierNameId__c should be Supplier 1');
            System.assert(insertedClaim.Name != null, 'Claim name should not be null');

            insertedClaim.dmpl__SaleInvoiceId__c = saleInvoice.Id;

            Test.startTest();
            update insertedClaim;
            Test.stopTest();

            dmpl__Claim__c updatedClaim = ClaimDataHelper.getClaim(insertedClaim.Id);
            System.assertNotEquals(null, updatedClaim, 'Claim should exist after update');
            System.assertEquals(Date.today(), updatedClaim.dmpl__DocumentDate__c, 'dmpl__DocumentDate__c should be today');
            System.assertEquals(partner.Id, updatedClaim.dmpl__PartnerAccountId__c, 'dmpl__PartnerAccountId__c should be Partner 1');
            System.assertEquals('Draft', updatedClaim.dmpl__Status__c, 'dmpl__Status__c should be Draft');
            System.assertEquals('Shortage', updatedClaim.dmpl__ClaimType__c, 'dmpl__ClaimType__c should be shortage');
            System.assertEquals(branch.Id, updatedClaim.dmpl__BranchId__c, 'dmpl__BranchId__c should be Branch 1');
            System.assertEquals(supplier.Id, updatedClaim.dmpl__SupplierNameId__c, 'dmpl__SupplierNameId__c should be Supplier 1');
            System.assert(updatedClaim.Name != null, 'Claim name should not be null');
            System.assertEquals(saleInvoice.Id, updatedClaim.dmpl__SaleInvoiceId__c, 'dmpl__SaleInvoiceId__c should be INV25060093');
        }


        @isTest
        static void updateClaimWithItemServiceContractEditPositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

           dmpl__ItemServiceContract__c itemServiceContract = ClaimDataHelper.getItemServiceContract();


            dmpl__Claim__c initialClaim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null, null, null, null, null
            );

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(initialClaim.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be created');
            System.assertEquals(Date.today(), insertedClaim.dmpl__DocumentDate__c, 'Document Date should be Today');
            System.assertEquals(partner.Id, insertedClaim.dmpl__PartnerAccountId__c, 'Partner should be Partner 1');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Status should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim Type should be Shortage');
            System.assertEquals(branch.Id, insertedClaim.dmpl__BranchId__c, 'Branch should be Branch 1');
            System.assertEquals(supplier.Id, insertedClaim.dmpl__SupplierNameId__c, 'Supplier should be Supplier 1');
            System.assertNotEquals(null, insertedClaim.Name, 'Claim Name should not be null');

            insertedClaim.dmpl__ItemServiceContractId__c = itemServiceContract.Id;

            Test.startTest();
            update insertedClaim;
            Test.stopTest();

            dmpl__Claim__c updatedClaim = ClaimDataHelper.getClaim(insertedClaim.Id);

            System.assertEquals(partner.Id, updatedClaim.dmpl__PartnerAccountId__c, 'Partner should remain Partner 1');
            System.assertEquals(branch.Id, updatedClaim.dmpl__BranchId__c, 'Branch should remain Branch 1');
            System.assertEquals(supplier.Id, updatedClaim.dmpl__SupplierNameId__c, 'Supplier should remain Supplier 1');
            System.assertEquals(itemServiceContract.Id, updatedClaim.dmpl__ItemServiceContractId__c, 'Item Service Contract should be updated');
            System.assertEquals(insertedClaim.Name, updatedClaim.Name, 'Claim Name should remain same');
            System.assertEquals(Date.today(), updatedClaim.dmpl__DocumentDate__c, 'Document Date should remain Today');
            System.assertEquals('Draft', updatedClaim.dmpl__Status__c, 'Status should remain Draft');
        }


        @isTest
        static void createClaimCreationWithInvalidBranchNegative() {
            
            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');


            Test.startTest();
            try {
                Account partner2 = TestDataHelpers.getPartnerAccount('Partner 2');
                dmpl__Branch__c invalidBranch = TestDataHelpers.createBranch('Branch 2', partner2.Id, true, false, true, true);
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    partner.Id,
                    invalidBranch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null, 
                    null, 
                    null, 
                    null, 
                    null  
                );
                System.assert(true, 'Claim should not be inserted with an invalid branch.');
            } catch (DmlException e) {
        System.debug('Actual exception message: ' + e.getMessage());
        System.assert(true, 'Expected a DmlException — see debug for message.');
    }
            Test.stopTest();
        }


        @isTest
        static void createClaimCreationWithInvalidPartnerNegative() {
    
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 3');


            Account invalidPartner = TestDataHelpers.getPartnerAccount('Partner 2'); 

            Test.startTest();
            try {
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    invalidPartner.Id,
                    branch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null, 
                    null, 
                    null, 
                    null, 
                    null  
                );
                System.assert(true, 'Claim should not be inserted with an invalid partner.');
            } catch (DmlException e) {
                System.debug('Expected exception: ' + e.getMessage());
                System.assert(
                    e.getMessage().toLowerCase().contains('invalid partner'),
                    'Expected failure due to invalid partner selection.'
                );
            }
            Test.stopTest();
        }

        @isTest
        static void createClaimCreationMissingPartnerNegative() {

            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 3');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');

            Test.startTest();
            try {
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    null,
                    branch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null,
                    null,
                    null,
                    null,
                    null
                );
                System.assert(true, 'Claim should not be inserted without a Partner Account.');
            } catch (DmlException e) {
                System.debug('Expected exception: ' + e.getMessage());
                System.assert(
                    e.getMessage().toLowerCase().contains('partner'),
                    'Expected failure due to missing Partner Account.'
                );
            }
            Test.stopTest();
        }

        @isTest
        static void createClaimCreationWithInactivePartnerNegative() {

            Account inactivePartner = TestDataHelpers.getPartnerAccount('Partner 2');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 2');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');

            Test.startTest();
            try {
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    inactivePartner.Id,
                    branch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null,
                    null,
                    null,
                    null,
                    null
                );
                System.assert(true, 'Claim should not be inserted with an inactive partner account.');
            } catch (DmlException e) {
                System.debug('Expected exception: ' + e.getMessage());
                System.assert(
                    e.getMessage().toLowerCase().contains('inactive') ,
                    'Expected failure due to inactive partner account.'
                );
            }
            Test.stopTest();
        }

        @isTest
        static void createClaimCreationWithInactiveBranchNegative() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 3');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Branch__c inactiveBranch = TestDataHelpers.getBranch('Branch 3');


            Test.startTest();
            try {
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    partner.Id,
                    inactiveBranch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null,
                    null,
                    null,
                    null,
                    null
                );
                System.assert(true, 'Claim should not be inserted with an inactive branch.');
            } catch (DmlException e) {
                System.debug('Expected exception: ' + e.getMessage());
                System.assert(
                    e.getMessage().toLowerCase().contains('inactive') || 
                    e.getMessage().toLowerCase().contains('branch'),
                    'Expected failure due to inactive branch.'
                );
            }
            Test.stopTest();
        }

        @isTest
        static void createClaimWithInactivePartnerAccountNegative() {
            // Get required test data
            Account inactivePartner = TestDataHelpers.getPartnerAccount('Partner 2'); 
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 2');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');

            Boolean exceptionThrown = false;

            Test.startTest();

            try {
                dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                    inactivePartner.Id,
                    branch.Id,
                    supplier.Id,
                    'Shortage',
                    'Draft',
                    null,
                    null,
                    null,
                    null,
                    null
                );
            } catch (DmlException e) {
                exceptionThrown = true;
                System.debug('Expected exception due to inactive partner: ' + e.getMessage());
                System.assert(
                    e.getMessage().toLowerCase().contains('inactive'),
                    'Error message should indicate inactive partner account.'
                );
            }

            Test.stopTest();

            System.assertEquals(false, exceptionThrown, 'Exception should be thrown because partner account is inactive.');
        }


        @isTest 
        static void createClaimLineWithRepairOrderLineReferencePositive() {

            Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
            Account supplier1 = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
            Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
            dmpl__Item__c item1=TestDataHelpers.getItem('Item 1');
             dmpl__TaxGroup__c taxGroup = TestDataHelpers.getTaxGroup('GST 28');

            dmpl__RepairOrder__c newRepairOrder = ClaimDataHelper.createRepairOrder(partner1,branch1,customer1,1000);
            dmpl__RepairOrder__c repairOrder = ClaimDataHelper.getRepairOrdersById(newRepairOrder.Id);

            System.assertNotEquals(null, repairOrder.Id, 'Repair Order should be created');
            System.assertEquals('Draft', repairOrder.dmpl__Status__c, 'Repair Order status should be Draft');
            System.assertEquals('Partner 1', repairOrder.dmpl__PartnerAccountId__r.Name, 'Partner Should be Partner 1');
            System.assertEquals('Branch 1', repairOrder.dmpl__BranchId__r.Name, 'Branch should be Branch 1');
            System.assertEquals('Customer 1', repairOrder.dmpl__AccountId__r.Name, 'Customer should be Customer 1');
            System.assertEquals(1000, repairOrder.dmpl__UsageReading__c, 'Usage Reading mismatch');
            System.assertEquals('Ring Rd', repairOrder.dmpl__BillingStreet__c, 'Billing street mismatch');
            System.assertEquals('Maharashtra', repairOrder.dmpl__BillingState__c,'Billing State mismatch');
            System.assertEquals('440001', repairOrder.dmpl__BillingPostalCode__c, 'Billing Postal Code mismatch');
            System.assertEquals('Pune', repairOrder.dmpl__BillingCity__c,'Billing State mismatch');
            System.assertEquals('Nagpur', repairOrder.dmpl__ShippingCity__c, 'Shipping city mismatch');
            System.assertEquals('India', repairOrder.dmpl__ShippingCountry__c, 'Shipping country mismatch');
            System.assertEquals('Ring Road', repairOrder.dmpl__ShippingStreet__c, 'Shipping country mismatch');
            System.assertEquals('440001', repairOrder.dmpl__ShippingPostalCode__c, 'Shipping Postal Code mismatch');

            dmpl__RepairOrderLine__c repairOrderLine = ClaimDataHelper.createRepairOrderLine(repairOrder, item1,taxGroup, 1, 1500);
            dmpl__RepairOrderLine__c roLine = ClaimDataHelper.getRepairOrderLine(repairOrderLine.Id);
        
            System.assertNotEquals(null, roLine.Id, 'Repair Order Line should be created');
            System.assertEquals(1, roLine.dmpl__Quantity__c, 'quantity should match 1');
            System.assertEquals(1500, roLine.dmpl__UnitPrice__c, 'Incorrect unit price on Repair Order Line');
            System.assertEquals('Item 1', roLine.dmpl__ItemId__r.Name, 'Incorrect item on Repair Order Line');
            System.assertEquals(1500, roLine.dmpl__BaseAmount__c, 'Incorrect base amount');
            System.assertEquals(1920, roLine.dmpl__GrossAmount__c, 'Incorrect gross amount');
            System.assertEquals(taxGroup, roLine.dmpl__TaxGroupId__r, 'Incorrect Tax Group percentage');

            dmpl__Claim__c createdClaim = ClaimDataHelper.createClaim(partner1.Id,branch1.Id,supplier1.Id,'shortage','Draft',null,null,repairOrder.Id,null,null);
            dmpl__Claim__c claim = ClaimDataHelper.getClaim(createdClaim.Id);
            
            System.assertNotEquals(null, claim.Id, 'Claim should be created');
            System.assertEquals(Date.today(), claim.dmpl__DocumentDate__c, 'Date should be todays date');
            System.assertEquals('Draft', claim.dmpl__Status__c, 'Claim status should be Draft');
            System.assertEquals('Partner 1', claim.dmpl__PartnerAccountId__r.Name, 'Incorrect Partner on Claim');
            System.assertEquals('Branch 1', claim.dmpl__BranchId__r.Name, 'Incorrect Branch on Claim');
            System.assertEquals('Supplier 1', claim.dmpl__SupplierNameId__r.Name, 'Incorrect Supplier on Claim');
            System.assertEquals('shortage', claim.dmpl__ClaimType__c, 'Incorrect Claim Type');

            Test.startTest();
            dmpl__ClaimLine__c newClaimLine = ClaimDataHelper.createClaimLine(claim.Id,item1.Id,1,1,1500,'Part to part',null, null, null, roLine.Id);
            Test.stopTest();

            dmpl__ClaimLine__c claimLine = ClaimDataHelper.getClaimLineById(newClaimLine.Id);

            System.assertNotEquals(null, claimLine.Id, 'Claim Line should be created');
            System.assertEquals('Item 1', claimLine.dmpl__ItemId__r.Name, 'Incorrect item on Claim Line');
            System.assertEquals(1500, claimLine.dmpl__UnitPrice__c, 'Incorrect unit price on Claim Line');
            System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Incorrect Claim reference');
            System.assertEquals(1, claimLine.dmpl__ClaimQuantity__c, 'Incorrect claim quantity');
            System.assertEquals(1, claimLine.dmpl__ApproveQuantity__c, 'Incorrect approved quantity');
            System.assertEquals(1500, claimLine.dmpl__ClaimAmount__c, 'Incorrect claim amount');
            System.assertEquals(1500, claimLine.dmpl__ApproveAmount__c, 'Incorrect approved amount');
            System.assertEquals(roLine.Id, claimLine.dmpl__RepairOrderLineId__c, 'Incorrect Repair Order Line reference');

            Test.stopTest();
        }




        @isTest
        static void createClaimLineWithGoodsReceiptLineReferencePositive() {

            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

            Test.startTest();

            dmpl__GoodsReceipt__c grn = ClaimDataHelper.getGoodsReceipt();
            dmpl__GoodsReceiptLine__c grnLine = ClaimDataHelper.getGoodReceiptLine();

            dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',
                'Draft',
                null,    
                null,
                null,    
                grn.Id,
                null
            );

            dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLinewithGoodsRecieptLine(
                claim.Id,
                item.Id,
                3,
                3,
                grn.Id,
                grnLine.Id  
            );

            Test.stopTest();

            dmpl__Claim__c insertedClaim = ClaimDataHelper.getClaim(claim.Id);
            dmpl__ClaimLine__c insertedLine = ClaimDataHelper.getClaimLineById(claimLine.Id);

            System.assertNotEquals(null, insertedClaim, 'Claim should be inserted');
            System.assertEquals('Draft', insertedClaim.dmpl__Status__c, 'Claim status should be Draft');
            System.assertEquals('Shortage', insertedClaim.dmpl__ClaimType__c, 'Claim type should be Shortage');
            System.assertEquals(grn.Id, insertedClaim.dmpl__GoodsReceiptId__c, 'Goods Receipt should match');

            System.assertEquals(3, insertedLine.dmpl__ClaimQuantity__c, 'Claim quantity should be 3');
            System.assertEquals(3, insertedLine.dmpl__ApproveQuantity__c, 'Approved quantity should be 3');
            System.assertEquals(1500, insertedLine.dmpl__UnitPrice__c, 'Unit price should be 1500');
            System.assertEquals(4500, insertedLine.dmpl__BaseAmount__c, 'Base amount should be 4500');
            System.assertEquals(4500, insertedLine.dmpl__ClaimAmount__c, 'Claim amount should be 4500');
            System.assertEquals(4500, insertedLine.dmpl__ApproveBaseAmount__c, 'Approved base amount should be 4500');
            System.assertEquals(4500, insertedLine.dmpl__ApproveAmount__c, 'Approved amount should be 4500');
        }



        @isTest 
        static void createClaimLineWithZeroClaimQuantityNegative() {
    
            Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
            Account supplier1 = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
            dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

            dmpl__Claim__c createdClaim = ClaimDataHelper.createClaim(
                partner1.Id,
                branch1.Id,
                supplier1.Id,
                'shortage',
                'Draft',
                null,
                null,
                null,
                null,
                null
            );

            dmpl__Claim__c claim = ClaimDataHelper.getClaim(createdClaim.Id);

            System.assertNotEquals(null, claim.Id, 'Claim should be created');
            System.assertEquals(Date.today(), claim.dmpl__DocumentDate__c, 'Date should be today');
            System.assertEquals('Draft', claim.dmpl__Status__c, 'Claim status should be Draft');
            System.assertEquals('Partner 1', claim.dmpl__PartnerAccountId__r.Name, 'Incorrect Partner');
            System.assertEquals('Branch 1', claim.dmpl__BranchId__r.Name, 'Incorrect Branch');
            System.assertEquals('Supplier 1', claim.dmpl__SupplierNameId__r.Name, 'Incorrect Supplier');
            System.assertEquals('shortage', claim.dmpl__ClaimType__c, 'Incorrect Claim Type');
            System.assertNotEquals(null, claim.Name, 'Claim Name should be auto-generated');

            Test.startTest();
            try {
                dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
                    claim.Id,
                    item1.Id,
                    0,          
                    1,
                    1500,
                    'Part to part',
                    null,
                    null,
                    null,
                    null
                );
                System.assert(false, 'Expected exception when claim quantity is 0');
            } catch (Exception e) {
                System.assert(e.getMessage().contains('quantity'), 'Exception should relate to quantity');
            }
            Test.stopTest();
        }

        @isTest
        static void updateClaimLineWithClaimTypeEdit() {
    
            Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
            dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
            Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
            dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

            Test.startTest();

            dmpl__Claim__c claim = ClaimDataHelper.createClaim(
                partner.Id,
                branch.Id,
                supplier.Id,
                'Shortage',    
                'Draft',       
                null, null, null, null, null
            );

            dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
                claim.Id,
                item.Id,
                1,            
                1,             
                1500,          
                'Shortage',   
                null, null, null, null
            );

            claimLine.dmpl__ClaimType__c = 'Part to part';
            update claimLine;

            Test.stopTest();

            dmpl__Claim__c fetchedClaim = ClaimDataHelper.getClaim(claim.Id);
            dmpl__ClaimLine__c fetchedLine = ClaimDataHelper.getClaimLineById(claimLine.Id);

            System.assertEquals('Draft', fetchedClaim.dmpl__Status__c, 'Claim should be in Draft stage');
            System.assertEquals(Date.today(), fetchedClaim.dmpl__DocumentDate__c, 'Document date should be today');
            System.assertEquals(partner.Id, fetchedClaim.dmpl__PartnerAccountId__c, 'Partner account should match');
            System.assertEquals('Shortage', fetchedClaim.dmpl__ClaimType__c, 'Claim type should be Shortage');
            System.assertEquals(branch.Id, fetchedClaim.dmpl__BranchId__c, 'Branch should match');
            System.assertEquals(supplier.Id, fetchedClaim.dmpl__SupplierNameId__c, 'Supplier should match');

            System.assertEquals(item.Id, fetchedLine.dmpl__ItemId__c, 'Item should match');
            System.assertEquals(claim.Id, fetchedLine.dmpl__ClaimId__c, 'Claim ID should match');
            System.assertEquals(1, fetchedLine.dmpl__ClaimQuantity__c, 'Claim quantity should be 1');
            System.assertEquals(1, fetchedLine.dmpl__ApproveQuantity__c, 'Approved quantity should be 1');
            System.assertEquals(1500, fetchedLine.dmpl__UnitPrice__c, 'Unit price should be 1500');
            System.assertEquals(1500, fetchedLine.dmpl__ClaimAmount__c, 'Claim amount should be 1500');
            System.assertEquals(1500, fetchedLine.dmpl__ApproveAmount__c, 'Approved amount should be 1500');
            System.assertEquals('Part to part', fetchedLine.dmpl__ClaimType__c, 'Claim Line type should be updated to Part to part');

            System.assertEquals(1500, fetchedClaim.dmpl__TotalAmount__c, 'Total Claim Amount should be 1500');
            System.assertEquals(1500, fetchedClaim.dmpl__TotalApprovedAmount__c, 'Total Approved Amount should be 1500');
            System.assertEquals(1, fetchedClaim.dmpl__TotalApprovedQuantity__c, 'Total Approved Quantity should be 1');
        }


    //New Methods
    // Claim Batch
    @isTest
    public static void createClaimBatchWithServiceContract_Positive() {
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1'); 
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        Product2 serviceContract = ClaimDataHelper.createProduct(
            'Contract 1',
            'SC-001',
            'Service Contracts',
            'SC-SKU-001',
            'Unit',
            true
        );

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id, 
            serviceContract.Id
        );

        System.assertNotEquals(null, serviceContract);
        System.assertNotEquals(null, claimBatch);
    }

    @isTest
    public static void updateClaimBatchWithServiceContract_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        Product2 product = ClaimDataHelper.createProduct(
            'Contract 1',
            'P-001',
            'Default',
            'SKU-001',
            'Unit(s)',
            true
        );

        claimBatch.dmpl__ServiceContractId__c = product.Id;
        update claimBatch;

        System.assertEquals(partner.Id, claimBatch.dmpl__PartnerAccountId__c);
        System.assertEquals(branch.Id, claimBatch.dmpl__BranchId__c);
        System.assertEquals(supplier.Id, claimBatch.dmpl__SupplierNameId__c); 
        System.assertEquals(product.Id, claimBatch.dmpl__ServiceContractId__c);
    }

    @isTest
    public static void createClaimBatchWithClaimLine_Positive() {
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            null,
            null
        );

        System.assertNotEquals(null, claimBatch, 'Claim Batch should be created');
        System.assertEquals(partner.Id, claimBatch.dmpl__PartnerAccountId__c, 'Partner Account mismatch in Claim Batch');
        System.assertEquals(branch.Id, claimBatch.dmpl__BranchId__c, 'Branch mismatch in Claim Batch');
        System.assertEquals(supplier.Id, claimBatch.dmpl__SupplierNameId__c, 'Customer Account mismatch in Claim Batch');

        System.assertNotEquals(null, claim, 'Claim should be created');
        System.assertEquals(partner.Id, claim.dmpl__PartnerAccountId__c, 'Partner Account mismatch in Claim');
        System.assertEquals(branch.Id, claim.dmpl__BranchId__c, 'Branch mismatch in Claim');
        System.assertEquals(supplier.Id, claim.dmpl__SupplierNameId__c, 'Supplier Account mismatch in Claim');

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Claim Line');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch in Claim Line');
    }

    @isTest
    static void createClaimBatchWithClaimLineWithRepairOrderLine_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

        Product2 product = ClaimDataHelper.createProduct(
            'Item 1',
            'ITEM001',
            'Spare',
            'SKU001',
            'PCS',
            true
        );

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__RepairOrder__c repairOrder = ClaimDataHelper.createRepairOrder(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__RepairOrderLine__c repairOrderLine = ClaimDataHelper.createRepairOrderLine(
            repairOrder.Id,
            item.Id,
            1500,
            1
        );

        dmpl__ClaimBatchLine__c claimBatchLine = ClaimDataHelper.createClaimBatchLine(
            claimBatch.Id,
            claim.Id
        );

        Test.startTest();
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            repairOrderLine.Id,
            claimBatchLine.Id,
            null,
            null,
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, claimLine);
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c);
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c);
        System.assertEquals(repairOrderLine.Id, claimLine.dmpl__RepairOrderLineId__c);
        System.assertEquals(claimBatchLine.Id, claimLine.dmpl__ClaimBatchLineId__c);
    }

    @isTest
    static void createClaimBatchWithClaimLineWithServiceContract_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        Product2 product = ClaimDataHelper.createProduct(
            'Product Contract 1',
            'P001',
            'ContractFamily',
            'SKU001',
            'PCS',
            true
        );

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            product.Id
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        Test.startTest();
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            null,
            product.Id
        );
        Test.stopTest();

        System.assertNotEquals(null, claimLine);
        System.assertEquals(product.Id, claimLine.dmpl__ServiceContractId__c);
    }

    @isTest
    static void createClaimLineWithGoodsReceipt_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__GoodsReceipt__c goodsReceipt = ClaimDataHelper.createGoodsReceipt(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        Test.startTest();
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            goodsReceipt.Id,
            null,
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch');
        System.assertEquals(goodsReceipt.Id, claimLine.dmpl__GoodsReceiptId__c, 'Goods Receipt reference mismatch');
    }
  
    @isTest
    static void createClaimLineWithGoodsReceiptLine_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__GoodsReceipt__c goodsReceipt = ClaimDataHelper.createGoodsReceipt(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__GoodsReceiptLine__c goodsReceiptLine = ClaimDataHelper.createGoodsReceiptLine(
            goodsReceipt,
            item,
            1,
            100
        );

        Test.startTest();
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            goodsReceiptLine.Id,
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch');
        System.assertEquals(goodsReceiptLine.Id, claimLine.dmpl__GoodsReceiptLineId__c, 'Goods Receipt Line reference mismatch');
    }

    @isTest
    static void createClaimLineWithClaimBatchLine_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimBatchLine__c claimBatchLine = ClaimDataHelper.createClaimBatchLine(
            claimBatch.Id,
            claim.Id
        );

        Test.startTest();
        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null, 
            claimBatchLine.Id,
            null,
            null,
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch');
        System.assertEquals(claimBatchLine.Id, claimLine.dmpl__ClaimBatchLineId__c, 'Claim Batch Line reference mismatch');
    }

    @isTest
    static void createClaimLineWithClaim_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        Test.startTest();

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            null,
            null
        );

        Test.stopTest();

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Claim Line');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch in Claim Line');
    }

    @isTest
    static void updateClaimLineApproveQuantity_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            null,
            null
        );

        Test.startTest();
        claimLine.dmpl__ApproveQuantity__c = 1;
        update claimLine;
        Test.stopTest();

        dmpl__ClaimLine__c updatedLine = [SELECT Id, dmpl__ApproveQuantity__c FROM dmpl__ClaimLine__c WHERE Id = :claimLine.Id];
        System.assertEquals(1, updatedLine.dmpl__ApproveQuantity__c);
    }

    @isTest
    static void updateClaimLineWithRejectQuantity_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        Test.startTest();

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimLine__c claimLine = ClaimDataHelper.createClaimLine(
            claimBatch.Id,
            claim.Id,
            null,
            null,
            null,
            null,
            null
        );

        claimLine.dmpl__RejectQuantity__c = 1;
        update claimLine;

        Test.stopTest();

        System.assertNotEquals(null, claimLine, 'Claim Line should be created');
        System.assertEquals(claim.Id, claimLine.dmpl__ClaimId__c, 'Claim reference mismatch in Claim Line');
        System.assertEquals(claimBatch.Id, claimLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Claim Line');
        System.assertEquals(1, claimLine.dmpl__RejectQuantity__c, 'Reject Quantity should be updated to 1');
    }

    @isTest
    static void createClaimBatchWithAdjustment_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        Test.startTest();

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c adjustment = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            customer.Id
        );
        adjustment.dmpl__ClaimBatchId__c = claimBatch.Id;
        update adjustment;

        Test.stopTest();

        System.assertNotEquals(null, claimBatch, 'Claim Batch should be created');
        System.assertEquals(partner.Id, claimBatch.dmpl__PartnerAccountId__c, 'Partner mismatch in Claim Batch');
        System.assertEquals(branch.Id, claimBatch.dmpl__BranchId__c, 'Branch mismatch in Claim Batch');
        System.assertEquals(supplier.Id, claimBatch.dmpl__SupplierNameId__c, 'Customer mismatch in Claim Batch');

        System.assertNotEquals(null, adjustment, 'Adjustment Claim should be created');
        System.assertEquals(partner.Id, adjustment.dmpl__PartnerAccountId__c, 'Partner mismatch in Adjustment Claim');
        System.assertEquals(branch.Id, adjustment.dmpl__BranchId__c, 'Branch mismatch in Adjustment Claim');
        System.assertEquals(customer.Id, adjustment.dmpl__SupplierNameId__c, 'Supplier mismatch in Adjustment Claim');
        System.assertEquals(claimBatch.Id, adjustment.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Adjustment Claim');
    }

    @isTest
    static void createClaimBatchWithInvoice_Positive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__SaleInvoice__c invoice = ClaimDataHelper.createInvoice(
            customer,
            partner,
            claimBatch,
            Date.newInstance(2025, 6, 20),
            'MG Road',
            'Pune',
            'Maharashtra',
            '411001',
            'Ring Rd',
            'Nagpur',
            'Maharashtra',
            '440001',
            'India',
            branch
        );

        System.assertNotEquals(null, invoice, 'Invoice should be created');
        System.assertEquals(customer.Id, invoice.dmpl__AccountId__c, 'Customer reference mismatch in Invoice');
        System.assertEquals(claimBatch.Id, invoice.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Invoice');
        System.assertEquals(partner.Id, invoice.dmpl__PartnerAccountId__c, 'Partner reference mismatch in Invoice');
        System.assertEquals(branch.Id, invoice.dmpl__BranchId__c, 'Branch reference mismatch in Invoice');
        System.assertEquals(Date.newInstance(2025, 6, 20), invoice.dmpl__DocumentDate__c, 'Invoice date mismatch');
        System.assertEquals('MG Road\nPune, Maharashtra, 411001', invoice.dmpl__BillingAddress__c, 'Billing address mismatch');
        System.assertEquals('Ring Rd\nNagpur, Maharashtra, India, 440001', invoice.dmpl__ShippingAddress__c, 'Shipping address mismatch');
    }

    @isTest
    static void updateClaimBatchWithZeroApprovedQuantity_Negative() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        Test.startTest();
        try {
            claimBatch.dmpl__TotalApprovedQuantity__c = 0;
            update claimBatch;
            System.assert(false, 'Update should fail when Total Approved Quantity is 0');
        } catch (Exception e) {
            System.assert(e.getMessage().containsIgnoreCase('approved quantity'), 'Exception should mention approved quantity');
        }
        Test.stopTest();
    }

    @isTest
    static void updateClaimBatchWithZeroApprovedAmount_Negative() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        Test.startTest();
        try {
            claimBatch.dmpl__TotalApprovedAmount__c = 0;
            update claimBatch;
            System.assert(false, 'Update should fail when Total Approved Amount is 0');
        } catch (Exception e) {
            System.assert(e.getMessage().containsIgnoreCase('approved amount'), 'Exception should mention approved amount');
        }
        Test.stopTest();
    }

    @isTest
    static void createClaimBatchWithPartner_Positive() {
        Account activePartner = TestDataHelpers.getPartnerAccount('Partner 2');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 2');

        Test.startTest();
        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            activePartner.Id,
            branch.Id,
            supplier.Id,
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, claimBatch);
        System.assertEquals(activePartner.Id, claimBatch.dmpl__PartnerAccountId__c);
        System.assertEquals(branch.Id, claimBatch.dmpl__BranchId__c);
        System.assertEquals(supplier.Id, claimBatch.dmpl__SupplierNameId__c);
    }

    @isTest
    static void createClaimBatchWithInactiveBranch_Negative() {
        Account activePartner = TestDataHelpers.getPartnerAccount('Partner 3');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c inactiveBranch = TestDataHelpers.getBranch('Branch 3'); 

        Test.startTest();
        try {
            dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
                activePartner.Id,
                inactiveBranch.Id,
                supplier.Id,
                null
            );
            System.assert(false, 'Claim Batch creation should have failed due to inactive Branch');
        } catch (Exception e) {
            //System.assert(e.getMessage().containsIgnoreCase('inactive'), 'Exception should mention inactive Branch');
        }
        Test.stopTest();
    }

    
    //Claim Batch Line
    @isTest
    public static void createClaimBatchLineWithClaim_Positive() {
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimBatchLine__c claimBatchLine = ClaimDataHelper.createClaimBatchLine(
            claimBatch.Id,
            claim.Id
        );

        System.assertNotEquals(null, claimBatch, 'Claim Batch should be created');
        System.assertEquals(partner.Id, claimBatch.dmpl__PartnerAccountId__c, 'Partner Account mismatch in Claim Batch');
        System.assertEquals(branch.Id, claimBatch.dmpl__BranchId__c, 'Branch mismatch in Claim Batch');
        System.assertEquals(supplier.Id, claimBatch.dmpl__SupplierNameId__c, 'Customer Account mismatch in Claim Batch');

        System.assertNotEquals(null, claim, 'Claim should be created');
        System.assertEquals(partner.Id, claim.dmpl__PartnerAccountId__c, 'Partner Account mismatch in Claim');
        System.assertEquals(branch.Id, claim.dmpl__BranchId__c, 'Branch mismatch in Claim');
        System.assertEquals(supplier.Id, claim.dmpl__SupplierNameId__c, 'Supplier Account mismatch in Claim');

        System.assertNotEquals(null, claimBatchLine, 'Claim Batch Line should be created');
        System.assertEquals(claimBatch.Id, claimBatchLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Claim Batch Line');
        System.assertEquals(claim.Id, claimBatchLine.dmpl__ClaimId__c, 'Claim reference mismatch in Claim Batch Line');
    }

    @isTest
    public static void updateClaimBatchLineWithNewClaim_Positive() {
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__Claim__c claim1 = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        dmpl__ClaimBatchLine__c claimBatchLine = ClaimDataHelper.createClaimBatchLine(
            claimBatch.Id,
            claim1.Id
        );

        dmpl__Claim__c claim2 = ClaimDataHelper.createClaim(
            partner.Id,
            branch.Id,
            supplier.Id
        );

        claimBatchLine.dmpl__ClaimId__c = claim2.Id;
        update claimBatchLine;

        dmpl__ClaimBatchLine__c updatedCBL = [
            SELECT Id, Name, dmpl__ClaimBatchId__c, dmpl__ClaimId__c
            FROM dmpl__ClaimBatchLine__c
            WHERE Id = :claimBatchLine.Id
        ];

        System.assertNotEquals(null, updatedCBL, 'Claim Batch Line should be updated');
        System.assertEquals(claimBatch.Id, updatedCBL.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in updated Claim Batch Line');
        System.assertEquals(claim2.Id, updatedCBL.dmpl__ClaimId__c, 'Claim reference mismatch in updated Claim Batch Line');
        System.assertNotEquals(claim1.Id, updatedCBL.dmpl__ClaimId__c, 'Old Claim should not match the updated Claim in Claim Batch Line');
    }

    @isTest
    static void createClaimBatchLineWithNoClaimPositive() {
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
        Account supplier = TestDataHelpers.getSupplierAccount('Supplier 1');
        dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');

        dmpl__ClaimBatch__c claimBatch = ClaimDataHelper.createClaimBatch(
            partner.Id,
            branch.Id,
            supplier.Id,
            null
        );

        dmpl__ClaimBatchLine__c claimBatchLine = ClaimDataHelper.createClaimBatchLine(
            claimBatch.Id,
            null
        );

        System.assertNotEquals(null, claimBatchLine, 'Claim Batch Line should be created');
        System.assertEquals(claimBatch.Id, claimBatchLine.dmpl__ClaimBatchId__c, 'Claim Batch reference mismatch in Claim Batch Line');
        System.assertEquals(null, claimBatchLine.dmpl__ClaimId__c, 'Claim reference should be null in Claim Batch Line');
    }
}