@isTest
public with sharing class TransferLineHandler_Test {
    @TestSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        dmpl__Branch__c branch = TestDataHelpers.createBranch(partnerAccount);
        dmpl__Transfer__c transfer = TransferTestDataHelper.createTransfer(partnerAccount,branch);
        dmpl__TransferLine__c transferLine = TransferTestDataHelper.createTransferLine(transfer);

        dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
		Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        dmpl__SKU__c sku1 = TestDataHelpers.createSKU('SKU 1', item1.id, false);
		dmpl__StorageLocation__c storageLocation1 = TestDataHelpers.createStorageLocation(
            'Storage Location 1',
            branch1.Id,
            true,
            'Warehouse'
        );
		dmpl__ItemLot__c itemLot = TestDataHelpers.createItemLot(branch1,item1,sku1,storageLocation1);

    }

    @isTest
    static void createTransferLinePositive() {
        dmpl__TransferLine__c transferLine = TransferTestDataHelper.getTransferLine();
        if (transferLine != null) {
            System.assertNotEquals(transferLine, null, 'Expected TransferLine to be created.');
            System.assertEquals(1, transferLine.dmpl__Quantity__c, 'Quantity should be 1');
            System.assertNotEquals(transferLine.dmpl__TransferId__c, null, 'TransferId should be set');
        } else {
            System.assert(false, 'TransferLine was not found during create test.');
        }
    }

    @isTest
    static void updateTransferLinePositive() {
        dmpl__TransferLine__c transferLine = TransferTestDataHelper.getTransferLine();
        System.assertNotEquals(transferLine, null, 'TransferLine should exist before update.');

        transferLine.dmpl__Quantity__c = 10;
        update transferLine;

        dmpl__TransferLine__c updatedTransferLine = TransferTestDataHelper.getTransferLine();
        System.assertEquals(10, updatedTransferLine.dmpl__Quantity__c, 'Expected Quantity to be updated to 10');
    }

     @isTest
     static void deleteTransferLineNegative() {
        dmpl__TransferLine__c transferLine = TransferTestDataHelper.getTransferLine();
        System.assertNotEquals(transferLine, null, 'TransferLine should exist before delete.');

        Test.startTest();
        try {
            delete transferLine;
            System.assert(false, 'Expected DML exception when deleting TransferLine');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY'), 
                'Expected CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY error');
            System.assert(e.getMessage().contains('dmpl.TransferLineTrigger'), 
                'Error should be from TransferLineTrigger');
        }
        Test.stopTest();

       
        dmpl__TransferLine__c nonDeletedLine = TransferTestDataHelper.getTransferLine();
        System.assertNotEquals(null, nonDeletedLine, 'TransferLine should still exist after failed delete');
    }

	/************************************ Transfer Line Outward ************************************/
	@isTest 
	static void createTransferOutwardLineWithItemLotPositive(){
		Test.startTest();
		dmpl__Transfer__c transfer = TransferTestDataHelper.getTransfer();
		dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
		dmpl__ItemLot__c itemLot = TestDataHelpers.getItemLot();
		dmpl__TransferOutwardLine__c transferOutwardLine;
		try{
			transferOutwardLine = TransferTestDataHelper.createTransferOutwardLine(transfer?.Id, item?.Id, itemLot?.Id, 'On Hand Transfer', 10);
		}catch(Exception e){
			System.Assert.isTrue(null != transferOutwardLine, 'TransferOutwardLine should be created.');
		}
		transferOutwardLine = TransferTestDataHelper.getTransferOutwardLine(transferOutwardLine.Id);
		System.AssertEquals(transfer?.Id, transferOutwardLine.dmpl__TransferId__c, 'Item Id should be matched.');
		System.AssertEquals(item?.Id, transferOutwardLine.dmpl__ItemId__c, 'Item Id should be matched.');
		System.AssertEquals(itemLot?.Id, transferOutwardLine.dmpl__ItemLotId__c, 'ItemLot Id should be matched.');
		System.AssertEquals(10, transferOutwardLine.dmpl__Quantity__c, 'Quantity should be 10.');
		System.AssertEquals(10, transferOutwardLine.dmpl__PendingInwardQuantity__c, 'Pending Inward Quantity should be null.');
		Test.stopTest();
	}
	@isTest 
	static void createTransferOutwardLineWithItemPositive(){
		Test.startTest();
		dmpl__Transfer__c transfer = TransferTestDataHelper.getTransfer();
		dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
		dmpl__ItemLot__c itemLot = null;
		dmpl__TransferOutwardLine__c transferOutwardLine;
		try{
			transferOutwardLine = TransferTestDataHelper.createTransferOutwardLine(transfer?.Id, item?.Id, itemLot?.Id, 'On Hand Transfer', 10);
		}catch(Exception e){
			System.Assert.isTrue(null != transferOutwardLine, 'TransferOutwardLine should be created.');
		}
		transferOutwardLine = TransferTestDataHelper.getTransferOutwardLine(transferOutwardLine.Id);

		System.AssertEquals(transfer?.Id, transferOutwardLine.dmpl__TransferId__c, 'Item Id should be matched.');
		System.AssertEquals(item?.Id, transferOutwardLine.dmpl__ItemId__c, 'Item Id should be matched.');
		System.AssertEquals(itemLot?.Id, transferOutwardLine.dmpl__ItemLotId__c, 'ItemLot Id should be matched.');
		System.AssertEquals(10, transferOutwardLine.dmpl__Quantity__c, 'Quantity should be 10.');
		System.AssertEquals(10, transferOutwardLine.dmpl__PendingInwardQuantity__c, 'Pending Inward Quantity should be null.');
		Test.stopTest();
	}
	@isTest 
	static void createTransferOutwardLineWithoutItemNegative(){
		Test.startTest();
		dmpl__Transfer__c transfer = TransferTestDataHelper.getTransfer();
		dmpl__Item__c item = null;
		dmpl__ItemLot__c itemLot = null;
		dmpl__TransferOutwardLine__c transferOutwardLine;
		try{
			transferOutwardLine = TransferTestDataHelper.createTransferOutwardLine(transfer?.Id, item?.Id, itemLot?.Id, 'On Hand Transfer', 10);
			System.Assert.isTrue(null == transferOutwardLine, 'TransferOutwardLine should be created.');
		}catch(Exception e){
			System.Assert.isTrue(null == transferOutwardLine, 'TransferOutwardLine should be created.');
		}
		Test.stopTest();
	}
	
}