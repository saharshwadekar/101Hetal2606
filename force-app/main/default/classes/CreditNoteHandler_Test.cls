@isTest
public with sharing class CreditNoteHandler_Test {
    @TestSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        Id partnerAccountId = partnerAccount.Id;
        dmpl__Branch__c branch = TestDataHelpers.createBranch(partnerAccount);
        dmpl__CreditNote__c creditNote = CreditNoteDataHelper.createCreditNote(partnerAccountId, branch.Id);
        List<dmpl__CreditNoteLine__c> lines = CreditNoteDataHelper.createCreditNoteLines(creditNote.Id);

         Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, true, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount3 = TestDataHelpers.createPartnerAccount('Partner 3', false, true, false, true, '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '78 Nehru Nagar Road', 'Chennai', 'Tamil Nadu', 'India', '600042', '91-9123456789');

        Account customerAccount1 = TestDataHelpers.createCustomerAccount('Customer 1', true, false, false, true, 'MG Road', 'Pune', 'Maharashtra', 'India', '411001', 'Ring Rd', 'Nagpur', 'Maharashtra', 'India', '440001','9876543210', 'Created');
        Account customerAccount2 = TestDataHelpers.createCustomerAccount('Customer 2', true, false, false, true, 'Park St', 'Kolkata', 'West Bengal', 'India', '700016', 'Lake Rd', 'Kolkata', 'West Bengal', 'India', '700029','9876543210', 'Created');
        Account customerAccount3 = TestDataHelpers.createCustomerAccount('Customer 3', true, false, false, true, 'Anna Salai', 'Chennai', 'Tamil Nadu', 'India', '600002', 'T Nagar', 'Chennai', 'Tamil Nadu', 'India', '600017','9012345678', 'Created');
        Account customerAccount7=TestDataHelpers.createCustomerAccount('Customer 7', true, false, false, false, 'Mission Road', 'Bengaluru', 'Karnataka', 'India', '560027', 'Indiranagar', 'Bengaluru', 'Karnataka', 'India', '560038','9811122233', 'Created');
        Account customerAccount6=TestDataHelpers.createCustomerAccount('Customer 6', true, false, false, true, 'Sector 18', 'Noida', 'Uttar Pradesh', 'India', '201301', 'Sector 62', 'Noida', 'Uttar Pradesh', 'India', '201309','9876501234', 'Created');

        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        dmpl__Branch__c branch2 = TestDataHelpers.createBranch('Branch 2', partnerAccount2.Id, true, false, true, true);
        dmpl__Branch__c branch3 = TestDataHelpers.createBranch('Branch 3', partnerAccount1.Id, false, true, true, false);
    }  
  

    @isTest
    static void createCreditNotePositive() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        System.assertNotEquals(note, null, 'Expected Credit Note to be created.');
        System.assertEquals('INR', note.dmpl__Currency__c, 'Expected currency to be INR.');
    }
    
    @isTest
    static void updateCreditNotePositive() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        note.dmpl__Notes__c = 'Updated credit note';
        update note;

        dmpl__CreditNote__c updatedNote = CreditNoteDataHelper.getCreditNote(note.Id);
        System.assertEquals('Updated credit note', updatedNote.dmpl__Notes__c, 'Expected note update.');
    }
    
    @isTest
    static void deleteCreditNote() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        delete note;

        Integer count = [SELECT COUNT() FROM dmpl__CreditNote__c WHERE Id = :note.Id];
        System.assertEquals(0, count, 'Expected Credit Note to be deleted.');
    }

    @isTest
    static void createCreditNoteLinesPositive() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        List<dmpl__CreditNoteLine__c> lines = CreditNoteDataHelper.getCreditNoteLines(note.Id);
        
        System.assert(lines.size() > 0, 'Expected at least one Credit Note Line.');
        for(dmpl__CreditNoteLine__c line : lines) {
            System.assertEquals(note.Id, line.dmpl__CreditNoteId__c, 'Expected Credit Note Line to be associated with Credit Note.');
        }
    }
    
    @isTest
    static void updateCreditNoteLinePositive() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        List<dmpl__CreditNoteLine__c> lines = CreditNoteDataHelper.getCreditNoteLines(note.Id);
        if (!lines.isEmpty()) {
            dmpl__CreditNoteLine__c line = lines[0];            
            line.dmpl__Amount__c = 250;
            line.dmpl__Description__c = 'Updated Credit Note Line Description';
            update line;
            dmpl__CreditNoteLine__c updatedLine = CreditNoteDataHelper.getCreditNoteLine(line.Id);
            System.assertEquals(250, updatedLine.dmpl__Amount__c, 'Expected amount to be updated.');
            System.assertEquals('Updated Credit Note Line Description', updatedLine.dmpl__Description__c, 'Expected description to be updated.');
        }
    }
    
    @isTest
    static void deleteCreditNoteLine() {
        dmpl__CreditNote__c note = CreditNoteDataHelper.getCreditNote();
        List<dmpl__CreditNoteLine__c> lines = CreditNoteDataHelper.getCreditNoteLines(note.Id);
        if (!lines.isEmpty()) {
            Id lineIdToDelete = lines[0].Id;
            delete lines[0];
            Integer count = [SELECT COUNT() FROM dmpl__CreditNoteLine__c WHERE Id = :lineIdToDelete];
            System.assertEquals(0, count, 'Expected Credit Note Line to be deleted.');
        }
    }
    @isTest
static void UpdateCreditNoteWithActiveCustomerAccountPositive() {
    Account partner = TestDataHelpers.getPartnerAccount('Partner 1');
    Account customer1 = TestDataHelpers.getCustomerAccount('Customer 1');
    Account customer2 = TestDataHelpers.getCustomerAccount('Customer 2');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 1');
    Date todayDate = Date.today();

    Test.startTest();
    dmpl__CreditNote__c creditNote = CreditNoteDataHelper.createCreditNoteWithDate(
        partner.Id,
        branch.Id,
        customer1.Id,
        todayDate
    );
    Test.stopTest();

    dmpl__CreditNote__c fetchedCreditNote = CreditNoteDataHelper.getCreditNoteWithDate(creditNote.Id);
    System.assertEquals(partner.Id, fetchedCreditNote.dmpl__PartnerAccountId__c);
    System.assertEquals(branch.Id, fetchedCreditNote.dmpl__BranchId__c);
    System.assertEquals(customer1.Id, fetchedCreditNote.dmpl__AccountId__c);
    System.assertEquals(todayDate, fetchedCreditNote.dmpl__DocumentDate__c);
    System.assertEquals(0, fetchedCreditNote.dmpl__Amount__c);
    System.assertEquals(0, fetchedCreditNote.dmpl__GLAmount__c);
    System.assertEquals(0, fetchedCreditNote.dmpl__OpenAmount__c);

    Test.startTest();
    fetchedCreditNote.dmpl__AccountId__c = customer2.Id;
    update fetchedCreditNote;
    Test.stopTest();

    dmpl__CreditNote__c updatedCreditNote = CreditNoteDataHelper.getCreditNoteWithDate(fetchedCreditNote.Id);
    System.assertEquals(partner.Id, updatedCreditNote.dmpl__PartnerAccountId__c);
    System.assertEquals(branch.Id, updatedCreditNote.dmpl__BranchId__c);
    System.assertEquals(customer2.Id, updatedCreditNote.dmpl__AccountId__c);
    System.assertEquals(todayDate, updatedCreditNote.dmpl__DocumentDate__c);
    System.assertEquals(0, updatedCreditNote.dmpl__Amount__c);
    System.assertEquals(0, updatedCreditNote.dmpl__GLAmount__c);
    System.assertEquals(0, updatedCreditNote.dmpl__OpenAmount__c);

}

    
}