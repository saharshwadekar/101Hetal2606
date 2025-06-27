@isTest
public with sharing class CaseHandler_Test {
    @testSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        Account customerAccount = TestDataHelpers.createCustomerAccount();
        dmpl__Branch__c Branch = TestDataHelpers.createBranch(partnerAccount);
        dmpl__Item__c item = TestDataHelpers.createItem();
        dmpl__Resource__c resource = TestDataHelpers.createResource(partnerAccount,Branch);
        dmpl__Case__c Case1 = CaseTestDataHelper.createCase(TestDataHelpers.getPartnerAccount(),TestDataHelpers.getCustomerAccount(),
                                                            TestDataHelpers.getBranch(),TestDataHelpers.getResource());



        Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, true, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount3 = TestDataHelpers.createPartnerAccount('Partner 3', false, true, false, true, '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '91-9123456789');

        Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        Account customerAccount3 = TestDataHelpers.createCustomerAccount('Customer 3', true, false, false, true, 'Anna Salai', 'Chennai', 'Tamil Nadu', 'India', '600002', 'T Nagar', 'Chennai', 'Tamil Nadu', 'India', '600017','9012345678', 'Created');
        Account customerAccount7=TestDataHelpers.createCustomerAccount('Customer 7', true, false, false, false, 'Mission Road', 'Bengaluru', 'Karnataka', 'India', '560027', 'Indiranagar', 'Bengaluru', 'Karnataka', 'India', '560038','9811122233', 'Created');

        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        dmpl__Branch__c branch2 = TestDataHelpers.createBranch('Branch 2', partnerAccount2.Id, true, false, true, true);
        dmpl__Branch__c branch3 = TestDataHelpers.createBranch('Branch 3', partnerAccount1.Id, false, true, true, false);

        dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
		dmpl__Item__c item5 = TestDataHelpers.createItem('Item 5', 'Product', true, false, false, '876543', false);

    }

    @isTest
    static void createCasePositive() {
        dmpl__Case__c newCase = CaseTestDataHelper.getCase();
        System.assertEquals('9733387909', newCase.dmpl__Mobile__c, 'Mobile should be 9733387909');
        System.assertEquals('Test-Account', newCase.dmpl__AccountName__c, 'AccountName should be Test-Account');
        System.assertEquals('9733387909', newCase.dmpl__AccountPhone__c, 'AccountPhone should match');
        System.assertEquals('Medium', newCase.dmpl__Priority__c, 'Priority should be Medium');
        System.assertEquals('Phone', newCase.dmpl__CaseSource__c, 'CaseSource should be Phone');
        System.assertEquals('Performance', newCase.dmpl__CaseReason__c, 'CaseReason should be Performance');
        System.assertEquals('New', newCase.dmpl__Status__c, 'Status should be New');
        System.assertEquals('Test Remarks', newCase.dmpl__Remarks__c, 'Remarks should be Test Remarks');
    }


    @isTest
    static void updateCasePositive() {
        dmpl__Case__c newCase = CaseTestDataHelper.getCase();
        newCase.dmpl__AccountName__c = 'Test';
        newCase.dmpl__Priority__c = 'High';
        newCase.dmpl__Status__c = 'Working';
        newCase.dmpl__Remarks__c = 'Updated Remarks';
        newCase.dmpl__Mobile__c = '8888888888';
        newCase.dmpl__AccountPhone__c = '9999999999';
        newCase.dmpl__CaseReason__c = 'Installation';
        newCase.dmpl__CaseSource__c = 'Email';
        update newCase;
        
        dmpl__Case__c updatedCase = CaseTestDataHelper.getCase(newCase.Id);
        System.assertEquals('Test', updatedCase.dmpl__AccountName__c, 'AccountName should be Test');
        System.assertEquals('High', updatedCase.dmpl__Priority__c, 'Priority should be High');
        System.assertEquals('Working', updatedCase.dmpl__Status__c, 'Status should be Working');
        System.assertEquals('Updated Remarks', updatedCase.dmpl__Remarks__c, 'Remarks should be Updated Remarks');
        System.assertEquals('8888888888', updatedCase.dmpl__Mobile__c, 'Mobile should be updated');
        System.assertEquals('9999999999', updatedCase.dmpl__AccountPhone__c, 'AccountPhone should be updated');
        System.assertEquals('Installation', updatedCase.dmpl__CaseReason__c, 'CaseReason should be updated');
        System.assertEquals('Email', updatedCase.dmpl__CaseSource__c, 'CaseSource should be updated');
    }
    
    
    @isTest
    static void deleteCasePositive() {
        dmpl__Case__c newCase = CaseTestDataHelper.getCase();
        Id caseId = newCase.Id;
        delete newCase;

        dmpl__Case__c deletedCase;
        

        try {
            deletedCase = CaseTestDataHelper.getCase(caseId);
        } catch (Exception e) {
            deletedCase = null;
        }

        System.assertEquals(null, deletedCase, 'Case should be marked as deleted');
    }
    
    @isTest
    static void CreateCasesCreationWithCorrectPartnerandBranch(){

    Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
    
    Test.startTest();
    dmpl__Case__c createdCase = CaseTestDataHelper.createCase(partner, customer, branch, null);
    Test.stopTest();
    
    dmpl__Case__c fetchedCase = CaseTestDataHelper.getCaseById(createdCase.Id);

    System.assertEquals(partner.Id, fetchedCase.dmpl__PartnerAccountId__c, 'Partner should match');
    System.assertEquals(branch.Id, fetchedCase.dmpl__BranchId__c, 'Branch should match');
    System.assertEquals(customer.Id, fetchedCase.dmpl__AccountId__c, 'Customer should match');
    System.assertEquals(Date.today(), fetchedCase.dmpl__DocumentDate__c, 'Document date should be today');
    }

    @isTest
    static void CreateCasesCreationWithWrongPartnerAccount() {

    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');        
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch2 = TestDataHelpers.getBranch('Branch 2');          

    Boolean exceptionThrown = false;

    
    Test.startTest();
    try {
        dmpl__Case__c createdCase = CaseTestDataHelper.createCase(partner1, customer1, branch2, null);
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') || 
                      e.getMessage().contains('Invalid') || 
                      e.getMessage().contains('constraint'),
                      'Exception should be related to invalid field relationship or integrity.');
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to mismatched partner and branch.');
}

@isTest
static void UpdateCreateCasesCreationWithWrongPartnerAccount() {
    
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1'); 
    dmpl__Branch__c branch2 = TestDataHelpers.getBranch('Branch 2'); 
    Asset asset = TestDataHelpers.getAsset('Asset 1');

    Boolean exceptionThrown = false;


    Test.startTest();
    dmpl__Case__c createdCase = CaseTestDataHelper.CreateCaseById(partner1, customer1, branch1, asset);
    createdCase.dmpl__DocumentDate__c = Date.today();
    insert createdCase;
    Test.stopTest();

    Test.startTest();
    try {
        dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(createdCase.Id);
        caseToUpdate.dmpl__BranchId__c = branch2.Id; 
        update caseToUpdate;
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().contains('Invalid') ||
            e.getMessage().contains('constraint'),
            'Expected FIELD_INTEGRITY or relationship validation failure.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to branch not matching partner.');
}

    @isTest
    static void CreateCasesCreationWithInactivePartnerAccount() {
    Account partner2 = TestDataHelpers.getPartnerAccount('Partner 2'); // Inactive
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch2 = TestDataHelpers.getBranch('Branch 2');

    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner2, customer1, branch2, null);
        insert caseRec;
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().contains('INACTIVE_OWNER_OR_USER') ||
            e.getMessage().contains('inactive'),
            'Expected exception due to inactive partner account.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to inactive partner account.');
}

@isTest
static void UpdateCasesCreationWithInactivePartnerAccount() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account partner2 = TestDataHelpers.getPartnerAccount('Partner 2'); 
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Branch__c branch2 = TestDataHelpers.getBranch('Branch 2');

    Asset asset = TestDataHelpers.getAsset('Asset 1');

    Boolean exceptionThrown = false;

    Test.startTest();
    dmpl__Case__c createdCase = CaseTestDataHelper.CreateCaseById(partner1, customer1, branch1, asset);
    createdCase.dmpl__DocumentDate__c = Date.today();
    insert createdCase;
    Test.stopTest();

    dmpl__Case__c fetchedCase = CaseTestDataHelper.getCaseById(createdCase.Id);

    System.assertEquals(partner1.Id, fetchedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, fetchedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, fetchedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), fetchedCase.dmpl__DocumentDate__c);

    Test.startTest();
    try {
        dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(fetchedCase.Id);
        caseToUpdate.dmpl__PartnerAccountId__c = partner2.Id;
        caseToUpdate.dmpl__BranchId__c = branch2.Id;
        update caseToUpdate;
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().toLowerCase().contains('inactive'),
            'Expected exception due to inactive partner account.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to inactive partner account on update.');
}
@isTest
static void CreateCasesCreationWithWrongBranch() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch3 = TestDataHelpers.getBranch('Branch 3'); 
    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner1, customer1, branch3, null);
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().toLowerCase().contains('invalid') ||
            e.getMessage().toLowerCase().contains('branch'),
            'Expected exception due to invalid branch not linked to partner.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to branch mismatch with partner.');
}
    @isTest
    static void UpdateCasesCreationWithWrongBranch() {
        Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
        Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
        dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
        dmpl__Branch__c branch2 = TestDataHelpers.getBranch('Branch 2'); 

        Boolean exceptionThrown = false;

        Test.startTest();
        dmpl__Case__c createdCase = CaseTestDataHelper.createCase(partner1, customer1, branch1, null);
        createdCase.dmpl__DocumentDate__c = Date.today();
        insert createdCase;
        Test.stopTest();

        dmpl__Case__c fetchedCase = CaseTestDataHelper.getCaseById(createdCase.Id);

        System.assertEquals(partner1.Id, fetchedCase.dmpl__PartnerAccountId__c);
        System.assertEquals(branch1.Id, fetchedCase.dmpl__BranchId__c);
        System.assertEquals(customer1.Id, fetchedCase.dmpl__AccountId__c);
        System.assertEquals(Date.today(), fetchedCase.dmpl__DocumentDate__c);

        Test.startTest();
        try {
            dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(fetchedCase.Id);
            caseToUpdate.dmpl__BranchId__c = branch2.Id;
            update caseToUpdate;
        } catch (System.DmlException e) {
            exceptionThrown = true;
            System.assert(
                e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
                e.getMessage().toLowerCase().contains('branch') ||
                e.getMessage().toLowerCase().contains('invalid'),
                'Expected exception due to invalid branch not matching partner.'
            );
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to invalid branch update.');
    }

    @isTest
    static void CreateCasesCreationWithInactiveBranch() {
    Account partner3 = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch3 = TestDataHelpers.getBranch('Branch 3'); // Inactive

    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner3, customer1, branch3, null);
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().toLowerCase().contains('inactive') ||
            e.getMessage().toLowerCase().contains('branch'),
            'Expected exception due to inactive branch.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to inactive branch.');
}

@isTest
static void UpdateCasesCreationWithInactiveBranch() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account partner3 = TestDataHelpers.getPartnerAccount('Partner 3');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');

    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1'); // Active
    dmpl__Branch__c branch3 = TestDataHelpers.getBranch('Branch 3'); // Inactive

    Boolean exceptionThrown = false;

    Test.startTest();
    dmpl__Case__c createdCase = CaseTestDataHelper.createCase(partner1, customer1, branch1, null);
    createdCase.dmpl__DocumentDate__c = Date.today();
    Test.stopTest();

    dmpl__Case__c fetchedCase = CaseTestDataHelper.getCaseById(createdCase.Id);

    System.assertEquals(partner1.Id, fetchedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, fetchedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, fetchedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), fetchedCase.dmpl__DocumentDate__c);

    Test.startTest();
    try {
        dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(fetchedCase.Id);
        caseToUpdate.dmpl__PartnerAccountId__c = partner3.Id;
        caseToUpdate.dmpl__BranchId__c = branch3.Id;
        update caseToUpdate;
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION') ||
            e.getMessage().toLowerCase().contains('inactive') ||
            e.getMessage().toLowerCase().contains('branch'),
            'Expected exception due to inactive branch.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to update to inactive branch.');
}
@isTest
static void CreateCasesCreationWithAsset() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');

    Asset asset1 = TestDataHelpers.createAsset('Asset 1', customer1.Id, item1.Id);

    Test.startTest();
    dmpl__Case__c caseRec = CaseTestDataHelper.CreateCaseById(partner1, customer1, branch1, asset1);
    caseRec.dmpl__DocumentDate__c = Date.today();
    Test.stopTest();

    dmpl__Case__c insertedCase = CaseTestDataHelper.getCaseById(caseRec.Id);

    System.assertEquals(partner1.Id, insertedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, insertedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, insertedCase.dmpl__AccountId__c);
    System.assertEquals(asset1.Id, insertedCase.dmpl__AssetId__c);
    System.assertEquals(Date.today(), insertedCase.dmpl__DocumentDate__c);
}

@isTest
static void CreateCasesCreationWithActiveCustomerAccount() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1'); // Active
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    Test.startTest();
    dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner1, customer1, branch1, null);
    caseRec.dmpl__DocumentDate__c = Date.today();
    insert caseRec;
    Test.stopTest();

    dmpl__Case__c insertedCase = CaseTestDataHelper.getCaseById(caseRec.Id);

    System.assertEquals(partner1.Id, insertedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, insertedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, insertedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), insertedCase.dmpl__DocumentDate__c);
}


@isTest
static void UpdatedCasesCreationWithActiveCustomerAccount() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1'); 
    Account customer3 = TestDataHelpers.getCustomerAccount('Customer 3'); 
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    Test.startTest();
    dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner1, customer1, branch1, null);
    caseRec.dmpl__DocumentDate__c = Date.today();
    insert caseRec;
    Test.stopTest();

    dmpl__Case__c insertedCase = CaseTestDataHelper.getCaseById(caseRec.Id);

    System.assertEquals(partner1.Id, insertedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, insertedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, insertedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), insertedCase.dmpl__DocumentDate__c);

    Test.startTest();
    dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(insertedCase.Id);
    caseToUpdate.dmpl__AccountId__c = customer3.Id;
    update caseToUpdate;
    Test.stopTest();

    dmpl__Case__c updatedCase = CaseTestDataHelper.getCaseById(caseToUpdate.Id);

    System.assertEquals(partner1.Id, updatedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, updatedCase.dmpl__BranchId__c);
    System.assertEquals(customer3.Id, updatedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), updatedCase.dmpl__DocumentDate__c);
}

@isTest
static void CreateCasesCreationWithInactiveCustomerAccount() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer7 = TestDataHelpers.getCustomerAccount('Customer 7');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    Boolean exceptionThrown = false;

    Test.startTest();
    try {
        dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner1, customer7, branch1, null);
        caseRec.dmpl__DocumentDate__c = Date.today();
        insert caseRec;
    } catch (System.DmlException e) {
        exceptionThrown = true;
        System.assert(
            e.getMessage().toLowerCase().contains('inactive') ||
            e.getMessage().toLowerCase().contains('customer') ||
            e.getMessage().contains('FIELD_INTEGRITY_EXCEPTION'),
            'Expected exception due to inactive customer account.'
        );
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to inactive customer account.');
}

@isTest
static void UpdateCasesCreationWithInactiveCustomerAccount() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1'); 
    Account customer7 = TestDataHelpers.getCustomerAccount('Customer 7'); 
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

    Boolean exceptionThrown = false;

    Test.startTest();
    dmpl__Case__c caseRec = CaseTestDataHelper.createCase(partner1, customer1, branch1, null);
    caseRec.dmpl__DocumentDate__c = Date.today();
    insert caseRec;
    Test.stopTest();

    dmpl__Case__c insertedCase = CaseTestDataHelper.getCaseById(caseRec.Id);

    System.assertEquals(partner1.Id, insertedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, insertedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, insertedCase.dmpl__AccountId__c);
    System.assertEquals(Date.today(), insertedCase.dmpl__DocumentDate__c);

    Test.startTest();
    try {
        dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(insertedCase.Id);
        caseToUpdate.dmpl__AccountId__c = customer7.Id;
        update caseToUpdate;
    } catch (System.DmlException e) {
        exceptionThrown = true;
       
    }
    Test.stopTest();

    System.assertEquals(true, exceptionThrown, 'Exception should be thrown due to inactive customer account.');
}

@isTest
static void UpdateCasesCreationWithAsset() {
    Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');
    dmpl__Item__c item1 = TestDataHelpers.getItem('Item 1');
    dmpl__Item__c item5 = TestDataHelpers.getItem('Item 5');

    Asset asset1 = TestDataHelpers.createAsset('Asset 1', customer1.Id, item1.Id);
    Asset asset3 = TestDataHelpers.createAsset('Asset 3', customer1.Id, item5.Id);

    Test.startTest();
    dmpl__Case__c caseRec = CaseTestDataHelper.CreateCaseById(partner1, customer1, branch1, asset1);
    caseRec.dmpl__DocumentDate__c = Date.today();
    Test.stopTest();

    dmpl__Case__c insertedCase = CaseTestDataHelper.getCaseById(caseRec.Id);

    System.assertEquals(partner1.Id, insertedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, insertedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, insertedCase.dmpl__AccountId__c);
    System.assertEquals(asset1.Id, insertedCase.dmpl__AssetId__c);
    System.assertEquals(Date.today(), insertedCase.dmpl__DocumentDate__c);

    Test.startTest();
    dmpl__Case__c caseToUpdate = CaseTestDataHelper.getCaseById(insertedCase.Id);
    caseToUpdate.dmpl__AssetId__c = asset3.Id;
    update caseToUpdate;
    Test.stopTest();

    dmpl__Case__c updatedCase = CaseTestDataHelper.getCaseById(caseToUpdate.Id);

    System.assertEquals(partner1.Id, updatedCase.dmpl__PartnerAccountId__c);
    System.assertEquals(branch1.Id, updatedCase.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, updatedCase.dmpl__AccountId__c);
    System.assertEquals(asset3.Id, updatedCase.dmpl__AssetId__c);
    System.assertEquals(Date.today(), updatedCase.dmpl__DocumentDate__c);
}
}