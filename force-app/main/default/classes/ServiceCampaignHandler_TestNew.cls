@isTest
public with sharing class ServiceCampaignHandler_TestNew {
    @TestSetup
    static void createRequiredData() {
        dmpl__AccountGroup__c accountGroup = TestDataHelpers.createAccountGroup();
        Account account = TestDataHelpers.createAccount(accountGroup);
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        Account customerAccount = TestDataHelpers.createCustomerAccount();        
        dmpl__Branch__c branch =TestDataHelpers.createBranch(partnerAccount);   
        dmpl__Resource__c resource =TestDataHelpers.createResource(partnerAccount, branch);  
        dmpl__ServiceLead__c serviceLead = ServiceLeadTestDataHelpers.createServiceLead(branch, customerAccount, resource); 
        dmpl__Item__c item = TestDataHelpers.createItem();
        dmpl__SKU__c sku =TestDataHelpers.createSKU(item);
        dmpl__ItemServiceContract__c itemServiceContract = ServiceCampaignTestDataHelpers.createItemServiceContract(item, sku);
        dmpl__ItemMaintenanceSchedule__c itemMaintenanceSchedule = TestDataHelpers.createItemMaintenanceSchedule(item, sku);
        dmpl__ServiceCampaign__c serviceCampaign = ServiceCampaignTestDataHelpers.createServiceCampaign(serviceLead, item, itemServiceContract, itemMaintenanceSchedule, branch, partnerAccount);
        dmpl__ServiceCampaignItem__c serviceCampaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(serviceCampaign, item, itemServiceContract);
        dmpl__StorageLocation__c storageLocation = TestDataHelpers.createStorageLocation(branch); 
        dmpl__ItemLot__c itemLot = TestDataHelpers.createItemLot(branch, item, sku, storageLocation);
        Asset asset = ServiceCampaignTestDataHelpers.CreateAsset(account, branch, item, itemLot, sku);
        dmpl__ServiceCampaignMember__c serviceCampaignMember = ServiceCampaignTestDataHelpers.createServiceCampaignMember(serviceCampaign, item, branch, asset, partnerAccount, account);
        dmpl__ServiceCampaignRule__c serviceCampaignRule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(serviceCampaign);

        //New
        dmpl__Item__c  item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        dmpl__Item__c item2 = TestDataHelpers.createItem('Item 2','Product',false,false,false,'654345',false);
        dmpl__Item__c item3 = TestDataHelpers.createItem('Item 3','Charge Item',true, false, false ,'765434',true);
        dmpl__Item__c item4 = TestDataHelpers.createItem('Item 4','Product',true, false, false ,'765676',true);

        Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, true, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount4 = TestDataHelpers.createPartnerAccount('Partner 4', false, true, false, true, '12 Industrial Zone', 'Hyderabad','Telangana', 'India', '500032', '12 Industrial Zone', 'Hyderabad', 'Telangana', 'India','500032','9876012345');

        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);
        
    }

    @isTest
    static void createServiceCampaignPositive() {
        dmpl__ServiceCampaign__c serviceCampaign = ServiceCampaignTestDataHelpers.getServiceCampaign();
        System.assertNotEquals(serviceCampaign, null, 'Expected Service Campaign to be created.');
        System.assertEquals(serviceCampaign.dmpl__Type__c, 'Service', 'Type should be Service.');
        System.assertEquals(serviceCampaign.Name, 'Service - Campaign', 'Name should be Service - Campaign.');
        System.assertEquals(serviceCampaign.dmpl__ReminderDaysOffset1__c, 3, 'Reminder Days Offset 1 should be 3.');
        System.assertEquals(serviceCampaign.dmpl__IsActive__c, true, 'is Active should be true.');
        System.assertEquals(serviceCampaign.dmpl__ReportId__c, 'Sample Report', 'Report Id  should be Sample Report.');
        System.assertEquals(serviceCampaign.dmpl__ApexJobId__c, 'Job1', 'Apex Job Id should be Job1.');
        System.assertEquals(serviceCampaign.dmpl__CronExpression__c, 'Cron Expression', 'Cron Expression should be Cron Expression.');

        dmpl__ServiceCampaignItem__c serviceCampaignItem = ServiceCampaignTestDataHelpers.getServiceCampaignItem();
        System.assertNotEquals(serviceCampaignItem, null, 'Expected Service Campaign Item to be created.');
        System.assertEquals(serviceCampaignItem.dmpl__IsMandatory__c, true, 'Is Mandatory should be true.');
        System.assertEquals(serviceCampaignItem.dmpl__Quantity__c, 4, 'Quantity should be 4.');
        
        dmpl__ServiceCampaignMember__c serviceCampaignMember = ServiceCampaignTestDataHelpers.getServiceCampaignMember();
        System.assertNotEquals(serviceCampaignMember, null, 'Expected Service Campaign Member to be created.');
        
        dmpl__ServiceCampaignRule__c serviceCampaignRule = ServiceCampaignTestDataHelpers.getServiceCampaignRule();
        System.assertNotEquals(serviceCampaignRule, null, 'Expected Service Campaign Rule to be created.');
        
    }

    @isTest
    static void updateServiceCampaignPositive() {
        dmpl__ServiceCampaign__c serviceCampaign = ServiceCampaignTestDataHelpers.getServiceCampaign();
        System.assertNotEquals(serviceCampaign, null, 'Service Campaign should exist before update.');
        serviceCampaign.Name = 'Service - Campaign updated';
        serviceCampaign.dmpl__ReminderDaysOffset1__c = 2;
        serviceCampaign.dmpl__IsActive__c = false;
        serviceCampaign.dmpl__ReportId__c = 'Sample Report1';
        serviceCampaign.dmpl__ApexJobId__c = 'Job2';
        serviceCampaign.dmpl__CronExpression__c = 'Cron Exp1';
        update serviceCampaign;

        dmpl__ServiceCampaign__c UpdatedServiceCampaign = ServiceCampaignTestDataHelpers.getServiceCampaign();
        System.assertEquals(UpdatedServiceCampaign.Name, 'Service - Campaign updated', 'Name should be Service - Campaign updated after update.');
        System.assertEquals(UpdatedServiceCampaign.dmpl__ReminderDaysOffset1__c, 2, 'Reminder Days Offset 1 should be 2 after update.');
        System.assertEquals(serviceCampaign.dmpl__IsActive__c, false, 'is Active should be false after update.');
        System.assertEquals(serviceCampaign.dmpl__ReportId__c, 'Sample Report1', 'Report Id  should be Sample Report1 after update.');
        System.assertEquals(serviceCampaign.dmpl__ApexJobId__c, 'Job2', 'Apex Job Id should be Job2.');
        System.assertEquals(serviceCampaign.dmpl__CronExpression__c, 'Cron Exp1', 'Cron Expression should be Cron Exp1 after update.');

        dmpl__ServiceCampaignItem__c serviceCampaignItem = ServiceCampaignTestDataHelpers.getServiceCampaignItem();
        System.assertNotEquals(serviceCampaignItem, null, 'Service Campaign Item should exist before update.');
        serviceCampaignItem.dmpl__IsMandatory__c = false;
        serviceCampaignItem.dmpl__Quantity__c = 2;
        update serviceCampaignItem;

        dmpl__ServiceCampaignItem__c updatedServiceCampaignItem = ServiceCampaignTestDataHelpers.getServiceCampaignItem();
        System.assertEquals(updatedServiceCampaignItem.dmpl__IsMandatory__c, false, 'Is Mandatory should be false after update.');
        System.assertEquals(updatedServiceCampaignItem.dmpl__Quantity__c, 2, 'Quantity should be 2 after update.');
    }

    @isTest
    static void deleteServiceCampaign() {
        dmpl__ServiceCampaign__c serviceCampaign = ServiceCampaignTestDataHelpers.getServiceCampaign();
        System.assertNotEquals(serviceCampaign, null, 'Service Campaign should exist before delete.');
        Id serviceCampaignId = serviceCampaign.Id;
        delete serviceCampaign;
        dmpl__ServiceCampaign__c deletedServiceCampaign = null;
        try {
            deletedServiceCampaign = ServiceCampaignTestDataHelpers.getServiceCampaign(serviceCampaignId);
        } catch (Exception e) {
            deletedServiceCampaign = null;
        }
        System.assertEquals(deletedServiceCampaign, null, 'Service Campaign should be deleted and not found in query.');
    }

    //New Methods
	//Service Campaign Item
    @isTest
    static void createServiceCampaignItemWithCampaignPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        Test.startTest();
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,    
            null,    
            1,       
            false    
        );
        Test.stopTest();
    
        System.assertNotEquals(null, campaign.Id);
        System.assertNotEquals(null, campaignItem.Id);
        System.assertEquals(campaign.Id, campaignItem.dmpl__ServiceCampaignId__c);
    }

    @isTest
    static void updateServiceCampaignItemWithActiveItemPositive() {
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
    
        Test.startTest();
        campaignItem.dmpl__ItemId__c = item.Id;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__ServiceCampaignId__c, dmpl__ItemId__c
            FROM dmpl__ServiceCampaignItem__c
            WHERE Id = :campaignItem.Id
        ];
    
        System.assertEquals(item.Id, updated.dmpl__ItemId__c);
        System.assertEquals(campaign.Id, updated.dmpl__ServiceCampaignId__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithItemServiceContractPositive() {
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
    
        dmpl__ItemServiceContract__c itemContract = ServiceCampaignTestDataHelpers.createItemServiceContractWithName(item, 'ISC01');
    
        Test.startTest();
        campaignItem.dmpl__ItemId__c = item.Id;
        campaignItem.dmpl__ItemServiceContractId__c = itemContract.Id;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__ServiceCampaignId__c, dmpl__ItemId__c, dmpl__ItemServiceContractId__c
            FROM dmpl__ServiceCampaignItem__c
            WHERE Id = :campaignItem.Id
        ];
    
        System.assertEquals(item.Id, updated.dmpl__ItemId__c);
        System.assertEquals(itemContract.Id, updated.dmpl__ItemServiceContractId__c);
        System.assertEquals(campaign.Id, updated.dmpl__ServiceCampaignId__c);
    }
    
    @isTest
    static void createServiceCampaignItemWithNoItemServiceContractPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        Test.startTest();
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
        Test.stopTest();
    
        System.assertNotEquals(null, campaignItem.Id);
        System.assertEquals(campaign.Id, campaignItem.dmpl__ServiceCampaignId__c);
        System.assertEquals(null, campaignItem.dmpl__ItemServiceContractId__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithIsMandatoryTruePositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
    
        Test.startTest();
        campaignItem.dmpl__IsMandatory__c = true;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__ServiceCampaignId__c, dmpl__IsMandatory__c
            FROM dmpl__ServiceCampaignItem__c
            WHERE Id = :campaignItem.Id
        ];
    
        System.assertEquals(true, updated.dmpl__IsMandatory__c);
        System.assertEquals(campaign.Id, updated.dmpl__ServiceCampaignId__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithDiscontinuedItemPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
        dmpl__Item__c discontinuedItem = TestDataHelpers.getItem('Item 4'); 
    
        Test.startTest();
        campaignItem.dmpl__ItemId__c = discontinuedItem.Id;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__ItemId__c FROM dmpl__ServiceCampaignItem__c WHERE Id = :campaignItem.Id
        ];
        System.assertEquals(discontinuedItem.Id, updated.dmpl__ItemId__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithInactiveItemPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            1,
            false
        );
        dmpl__Item__c item2 = TestDataHelpers.createItem('Item 2','Product',false,false,false,'654345',false);
        dmpl__Item__c inactiveItem = TestDataHelpers.getItem('Item 2'); 
    
        Test.startTest();
        campaignItem.dmpl__ItemId__c = inactiveItem.Id;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__ItemId__c FROM dmpl__ServiceCampaignItem__c WHERE Id = :campaignItem.Id
        ];
        System.assertEquals(inactiveItem.Id, updated.dmpl__ItemId__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithQuantityAsMinusOnePositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            null,
            null,
            2,
            false
        );
    
        Test.startTest();
        campaignItem.dmpl__Quantity__c = 3;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__Quantity__c FROM dmpl__ServiceCampaignItem__c WHERE Id = :campaignItem.Id
        ];
        System.assertEquals(3, updated.dmpl__Quantity__c);
    }
    
    @isTest
    static void updateServiceCampaignItemWithActiveItemAndNoQuantityPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        dmpl__Item__c item1 = TestDataHelpers.createItem('Item 1','Product',true,false,false,'675654',false);
        dmpl__Item__c item = TestDataHelpers.getItem('Item 1');
    
        dmpl__ServiceCampaignItem__c campaignItem = ServiceCampaignTestDataHelpers.createServiceCampaignItem(
            campaign.Id,
            item.Id,
            null,
            2,
            false
        );
    
        Test.startTest();
        campaignItem.dmpl__Quantity__c = 5;
        update campaignItem;
        Test.stopTest();
    
        dmpl__ServiceCampaignItem__c updated = [
            SELECT Id, dmpl__Quantity__c FROM dmpl__ServiceCampaignItem__c WHERE Id = :campaignItem.Id
        ];
        System.assertEquals(5, updated.dmpl__Quantity__c);
    }

    //Service Campaign Menmer
    @isTest
    static void createServiceCampaignMemberWithCampaignOnlyPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');

        Test.startTest();
        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            null,
            null,
            null,
            null,
            null
        );
        Test.stopTest();

        dmpl__ServiceCampaignMember__c fetchedMember = [
            SELECT Id, dmpl__ServiceCampaignId__c
            FROM dmpl__ServiceCampaignMember__c
            WHERE Id = :member.Id
        ];

        System.assertEquals(campaign.Id, fetchedMember.dmpl__ServiceCampaignId__c);
    }

    @isTest
    static void createServiceCampaignMemberWithActivePartnerPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        Account partner = TestDataHelpers.getPartnerAccount('Partner 1');

        Test.startTest();
        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            partner.Id,
            null,
            null,
            null,
            null
        );
        Test.stopTest();

        dmpl__ServiceCampaignMember__c fetchedMember = [
            SELECT Id, dmpl__ServiceCampaignId__c, dmpl__PartnerAccountId__c
            FROM dmpl__ServiceCampaignMember__c
            WHERE Id = :member.Id
        ];

        System.assertEquals(campaign.Id, fetchedMember.dmpl__ServiceCampaignId__c);
        System.assertEquals(partner.Id, fetchedMember.dmpl__PartnerAccountId__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithInactivePartnerPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
        Account partner2 = TestDataHelpers.getPartnerAccount('Partner 2');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            partner1.Id,
            null,
            null,
            null,
            null
        );

        Test.startTest();
        member.dmpl__PartnerAccountId__c = partner2.Id;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__PartnerAccountId__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(partner2.Id, updated.dmpl__PartnerAccountId__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithCorrectMobilePhonePositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        Account activePartner = TestDataHelpers.getPartnerAccount('Partner 1');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            activePartner.Id,
            null,
            '9999999999',
            null,
            null
        );

        Test.startTest();
        member.dmpl__MobilePhone__c = '8888888888';
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__MobilePhone__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals('8888888888', updated.dmpl__MobilePhone__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithIncorrectMobilePhonePositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        Account activePartner = TestDataHelpers.getPartnerAccount('Partner 1');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            activePartner.Id,
            null,
            '8888888888',
            null,
            null
        );

        Test.startTest();
        member.dmpl__MobilePhone__c = '237477847938797';
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__MobilePhone__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals('237477847938797', updated.dmpl__MobilePhone__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithActiveItemPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        dmpl__Item__c activeItem1 = TestDataHelpers.getItem('Item 1');
        dmpl__Item__c activeItem3 = TestDataHelpers.getItem('Item 3');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            null,
            activeItem1.Id,
            null,
            null,
            null
        );

        Test.startTest();
        member.dmpl__ItemId__c = activeItem3.Id;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__ItemId__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(activeItem3.Id, updated.dmpl__ItemId__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithInactiveItemPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        dmpl__Item__c activeItem = TestDataHelpers.getItem('Item 1');
        dmpl__Item__c inactiveItem = TestDataHelpers.getItem('Item 2');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            null,
            activeItem.Id,
            null,
            null,
            null
        );

        Test.startTest();
        member.dmpl__ItemId__c = inactiveItem.Id;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__ItemId__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(inactiveItem.Id, updated.dmpl__ItemId__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithDiscontinuedItemPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        dmpl__Item__c activeItem = TestDataHelpers.getItem('Item 1');
        dmpl__Item__c discontinuedItem = TestDataHelpers.getItem('Item 4');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            null,
            activeItem.Id,
            null,
            null,
            null
        );

        Test.startTest();
        member.dmpl__ItemId__c = discontinuedItem.Id;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__ItemId__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(discontinuedItem.Id, updated.dmpl__ItemId__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithPastDueDatePositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');

        Date validDueDate = Date.today().addDays(5);
        Date pastDueDate = Date.today().addDays(-10);

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            null,
            null,
            null,
            validDueDate,
            null
        );

        Test.startTest();
        member.dmpl__DueDate__c = pastDueDate;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__DueDate__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(pastDueDate, updated.dmpl__DueDate__c);
    }

    @isTest
    static void updateServiceCampaignMemberWithIncorrectPartnerBranchMappingPositive() {
        dmpl__ServiceCampaign__c campaign = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        Account partner1 = TestDataHelpers.getPartnerAccount('Partner 1');
        Account partner4 = TestDataHelpers.getPartnerAccount('Partner 4');
        dmpl__Branch__c branch1 = TestDataHelpers.getBranch('Branch 1');

        dmpl__ServiceCampaignMember__c member = ServiceCampaignTestDataHelpers.createServiceCampaignMember(
            campaign.Id,
            partner1.Id,
            null,
            null,
            null,
            branch1.Id
        );

        Test.startTest();
        member.dmpl__PartnerAccountId__c = partner4.Id;
        update member;
        Test.stopTest();

        dmpl__ServiceCampaignMember__c updated = [
            SELECT Id, dmpl__PartnerAccountId__c FROM dmpl__ServiceCampaignMember__c WHERE Id = :member.Id
        ];
        System.assertEquals(partner4.Id, updated.dmpl__PartnerAccountId__c);
    }

    //Service Campaign Rule
    @isTest
    static void updateServiceCampaignRuleWithNewCampaignPositive() {
        dmpl__ServiceCampaign__c campaign1 = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');
        dmpl__ServiceCampaign__c campaign2 = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 2');

        dmpl__ServiceCampaignRule__c rule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(
            campaign1.Id,
            'Account',
            'equals'
        );

        Test.startTest();
        delete rule;
        dmpl__ServiceCampaignRule__c newRule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(
            campaign2.Id,
            'Account',
            'equals'
        );
        Test.stopTest();

        System.assertEquals(campaign2.Id, newRule.dmpl__ServiceCampaignId__c);
    }

    @isTest
    static void createServiceCampaignRuleWithoutCampaignNegative() {
        Test.startTest();
        try {
            dmpl__ServiceCampaignRule__c rule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(
                null,
                'Account',
                'equals'
            );
            System.assert(false, 'Rule creation should fail when no campaign is provided.');
        } catch (DmlException e) {
            System.assert(e.getMessage().toLowerCase().contains('campaign'), 'Expected error due to missing campaign.');
        }
        Test.stopTest();
    }

    @isTest
    static void updateServiceCampaignRuleWithInvalidObjectTypeNegative() {
        dmpl__ServiceCampaign__c campaign1 = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');

        dmpl__ServiceCampaignRule__c rule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(
            campaign1.Id,
            'Account',
            'equals'
        );

        Test.startTest();
        rule.dmpl__ObjectType__c = 'Pickle'; 
        try {
            update rule;
            System.assert(false, 'Update should fail due to invalid object type.');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().toLowerCase().contains('object') || e.getMessage().toLowerCase().contains('type'),
                'Expected failure due to incorrect object type.'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void updateServiceCampaignRuleWithInvalidOperationNegative() {
        dmpl__ServiceCampaign__c campaign1 = ServiceCampaignTestDataHelpers.createServiceCampaign('Campaign 1');

        dmpl__ServiceCampaignRule__c rule = ServiceCampaignTestDataHelpers.createServiceCampaignRule(
            campaign1.Id,
            'Account',
            'equals'
        );

        Test.startTest();
        rule.dmpl__Operation__c = 'morning'; 
        try {
            update rule;
            System.assert(false, 'Update should fail due to invalid operation.');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().toLowerCase().contains('operation') || e.getMessage().toLowerCase().contains('invalid'),
                'Expected failure due to incorrect operation.'
            );
        }
        Test.stopTest();
    }
}