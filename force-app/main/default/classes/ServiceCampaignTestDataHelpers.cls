public with sharing class ServiceCampaignTestDataHelpers {
    public static dmpl__ServiceCampaign__c createServiceCampaign(dmpl__ServiceLead__c serviceLead, dmpl__Item__c item, dmpl__ItemServiceContract__c itemServiceContract, dmpl__ItemMaintenanceSchedule__c itemMaintenanceSchedule, dmpl__Branch__c branch, Account partnerAccount)
    {
        return (dmpl__ServiceCampaign__c)TestFactory.createSObject(  
            new dmpl__ServiceCampaign__c(
                dmpl__ServiceLeadId__c = serviceLead.Id,
                dmpl__ServiceContractItemId__c = item.Id,
                dmpl__ItemServiceContractId__c = itemServiceContract.Id,
                dmpl__ItemMaintenanceScheduleId__c = itemMaintenanceSchedule.Id,
                dmpl__BranchId__c = branch.Id,
                dmpl__PartnerAccountId__c = partnerAccount.Id
                ),
                'ServiceCampaignDefaults',
                true); 
    }

    public static dmpl__ServiceCampaign__c getServiceCampaign()
    {
        return [
            SELECT
                Id,
                Name,
                dmpl__IsActive__c,
                dmpl__ReportId__c,
                dmpl__ApexJobId__c,
                dmpl__CronExpression__c,
                dmpl__Type__c,
                dmpl__ReminderDaysOffset1__c,
                dmpl__ServiceLeadId__c,
                dmpl__ServiceContractItemId__c,
                dmpl__ItemServiceContractId__c,
                dmpl__ItemMaintenanceScheduleId__c,
                dmpl__BranchId__c,
                dmpl__PartnerAccountId__c
            FROM dmpl__ServiceCampaign__c 
            LIMIT 1
        ];
    }

    public static dmpl__ServiceCampaign__c getServiceCampaign(Id serviceCampaignId)
    {
        return [
            SELECT
                Id,
                Name,
                dmpl__IsActive__c,
                dmpl__ReportId__c,
                dmpl__ApexJobId__c,
                dmpl__CronExpression__c,
                dmpl__Type__c,
                dmpl__ReminderDaysOffset1__c,
                dmpl__ServiceLeadId__c,
                dmpl__ServiceContractItemId__c,
                dmpl__ItemServiceContractId__c,
                dmpl__ItemMaintenanceScheduleId__c,
                dmpl__BranchId__c,
                dmpl__PartnerAccountId__c
            FROM dmpl__ServiceCampaign__c 
            WHERE ID = :serviceCampaignId 
            LIMIT 1
        ];
    }

    public static dmpl__ServiceCampaignItem__c createServiceCampaignItem(dmpl__ServiceCampaign__c serviceCampaign, dmpl__Item__c item, dmpl__ItemServiceContract__c itemServiceContract)
    {
        return (dmpl__ServiceCampaignItem__c)TestFactory.createSObject(  
            new dmpl__ServiceCampaignItem__c(
                dmpl__ServiceCampaignId__c = serviceCampaign.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__ItemServiceContractId__c = itemServiceContract.Id
            ),
            'ServiceCampaignItemDefaults',
            true
        ); 
    }

    public static dmpl__ServiceCampaignItem__c getServiceCampaignItem()
    {
        return [
            SELECT
                Id,
                dmpl__IsMandatory__c,
                dmpl__Quantity__c,
                dmpl__ServiceCampaignId__c,
                dmpl__ItemId__c,
                dmpl__ItemServiceContractId__c
            FROM dmpl__ServiceCampaignItem__c 
            LIMIT 1
        ];
    }

    public static dmpl__ServiceCampaignMember__c createServiceCampaignMember(dmpl__ServiceCampaign__c serviceCampaign, dmpl__Item__c item, dmpl__Branch__c branch, Asset asset, Account partnerAccount, Account account)
    {
        return (dmpl__ServiceCampaignMember__c)TestFactory.createSObject(  
            new dmpl__ServiceCampaignMember__c(
                dmpl__ServiceCampaignId__c = serviceCampaign.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__BranchId__c = branch.Id,
                dmpl__AssetId__c = asset.Id,
                dmpl__PartnerAccountId__c = partnerAccount.Id,
                dmpl__AccountId__c = account.Id
            ),
            true); 
    }

    public static dmpl__ServiceCampaignMember__c getServiceCampaignMember()
    {
        return [
            SELECT
                Id,
                dmpl__ServiceCampaignId__c,
                dmpl__ItemId__c,
                dmpl__BranchId__c,
                dmpl__AssetId__c,
                dmpl__PartnerAccountId__c,
                dmpl__AccountId__c
            FROM dmpl__ServiceCampaignMember__c 
            LIMIT 1
        ];
    }

    public static dmpl__ServiceCampaignRule__c createServiceCampaignRule(dmpl__ServiceCampaign__c serviceCampaign)
    {
        return (dmpl__ServiceCampaignRule__c)TestFactory.createSObject(  
            new dmpl__ServiceCampaignRule__c(
                dmpl__ServiceCampaignId__c = serviceCampaign.Id
            ), 
            true
        ); 
    }

    public static dmpl__ServiceCampaignRule__c getServiceCampaignRule()
    {
        return [
            SELECT
                Id,
                dmpl__ServiceCampaignId__c
            FROM dmpl__ServiceCampaignRule__c 
            LIMIT 1
        ];
    }

    public static dmpl__ItemServiceContract__c createItemServiceContract(dmpl__Item__c items,dmpl__SKU__c skus) {
        return (dmpl__ItemServiceContract__c) TestFactory.createSObject(
            new dmpl__ItemServiceContract__c(
                dmpl__DateEffectiveFrom__c = date.today(),
                dmpl__DateEffectiveTill__c = date.today() + 7,
                dmpl__ItemId__c = items.Id,
                dmpl__SKUId__c = skus.Id,
                dmpl__PopulateContractLines__c = true
            ), 
            true 
        );
    }
    public static dmpl__ItemServiceContract__c getItemServiceContract() {
        return [
            SELECT
                Id,
                dmpl__DateEffectiveFrom__c,
                dmpl__DateEffectiveTill__c,
                dmpl__ItemId__c,
                dmpl__SKUId__c,
                dmpl__PopulateContractLines__c
            FROM dmpl__ItemServiceContract__c LIMIT 1
        ];
    }

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
            true
        );
    }

    public static Asset getAsset() {
        return [
            SELECT Id, Name
            FROM Asset
            LIMIT 1
        ];
    }



    //New Methods
    public static dmpl__ServiceCampaign__c createServiceCampaign(String name) {
        dmpl__ServiceCampaign__c campaign = (dmpl__ServiceCampaign__c) TestFactory.createSObject(
            new dmpl__ServiceCampaign__c(
                Name = name
            ),
            true
        );
        return campaign;
    }

    public static dmpl__ServiceCampaign__c getServiceCampaignByName(String name) {
        return [
            SELECT Id, Name
            FROM dmpl__ServiceCampaign__c
            WHERE Name = :name
            LIMIT 1
        ];
    }

    public static List<dmpl__ServiceCampaign__c> getServiceCampaigns() {
        return [
            SELECT Id, Name
            FROM dmpl__ServiceCampaign__c
        ];
    }

    public static dmpl__ServiceCampaignItem__c createServiceCampaignItem(
        dmpl__ServiceCampaign__c campaign,
        dmpl__Item__c item,
        dmpl__ItemServiceContract__c itemServiceContract,
        Decimal quantity,
        Boolean isMandatory
    ) {
        dmpl__ServiceCampaignItem__c sci = (dmpl__ServiceCampaignItem__c) TestFactory.createSObject(
            new dmpl__ServiceCampaignItem__c(
                dmpl__ServiceCampaignId__c = campaign != null ? campaign.Id : null,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__ItemServiceContractId__c = itemServiceContract != null ? itemServiceContract.Id : null,
                dmpl__Quantity__c = quantity,
                dmpl__IsMandatory__c = isMandatory
            ),
            true
        );
        return sci;
    }

    public static dmpl__ServiceCampaignItem__c getServiceCampaignItemByName(String name) {
        return [
            SELECT Id, Name, dmpl__ServiceCampaignId__c, dmpl__ItemId__c, dmpl__ItemServiceContractId__c,
                   dmpl__Quantity__c, dmpl__IsMandatory__c
            FROM dmpl__ServiceCampaignItem__c
            WHERE Name = :name
            LIMIT 1
        ];
    }

    public static List<dmpl__ServiceCampaignItem__c> getServiceCampaignItemsByCampaign(Id campaignId) {
        return [
            SELECT Id, Name, dmpl__ItemId__c, dmpl__ItemServiceContractId__c, dmpl__Quantity__c, dmpl__IsMandatory__c
            FROM dmpl__ServiceCampaignItem__c
            WHERE dmpl__ServiceCampaignId__c = :campaignId
        ];
    }

     public static dmpl__ServiceCampaignMember__c createServiceCampaignMember(
        dmpl__ServiceCampaign__c campaign,
        Account partnerAccount,
        dmpl__Item__c item,
        Date dueDate,
        String mobilePhone,
        Id branchId
    ) {
        dmpl__ServiceCampaignMember__c member = (dmpl__ServiceCampaignMember__c) TestFactory.createSObject(
            new dmpl__ServiceCampaignMember__c(
                dmpl__ServiceCampaignId__c = campaign != null ? campaign.Id : null,
                dmpl__PartnerAccountId__c = partnerAccount != null ? partnerAccount.Id : null,
                dmpl__ItemId__c = item != null ? item.Id : null,
                dmpl__DueDate__c = dueDate != null ? dueDate : Date.today().addDays(7),
                dmpl__MobilePhone__c = mobilePhone,
                dmpl__BranchId__c = branchId
            ),
            true
        );
        return member;
    }

    public static dmpl__ServiceCampaignMember__c getServiceCampaignMemberByName(String name) {
        return [
            SELECT Id, Name, dmpl__ServiceCampaignId__c, dmpl__PartnerAccountId__c,
                   dmpl__ItemId__c, dmpl__DueDate__c, dmpl__MobilePhone__c, dmpl__BranchId__c
            FROM dmpl__ServiceCampaignMember__c
            WHERE Name = :name
            LIMIT 1
        ];
    }

    public static List<dmpl__ServiceCampaignMember__c> getServiceCampaignMembersByCampaign(Id campaignId) {
        return [
            SELECT Id, Name, dmpl__PartnerAccountId__c, dmpl__ItemId__c, dmpl__DueDate__c,
                   dmpl__MobilePhone__c, dmpl__BranchId__c
            FROM dmpl__ServiceCampaignMember__c
            WHERE dmpl__ServiceCampaignId__c = :campaignId
        ];
    }

    public static dmpl__ServiceCampaignRule__c createServiceCampaignRule(
        dmpl__ServiceCampaign__c campaign,
        String objectType,
        String operation
    ) {
        dmpl__ServiceCampaignRule__c rule = (dmpl__ServiceCampaignRule__c) TestFactory.createSObject(
            new dmpl__ServiceCampaignRule__c(
                dmpl__ServiceCampaignId__c = campaign != null ? campaign.Id : null,
                dmpl__ObjectType__c = objectType != null ? objectType : 'Account',
                dmpl__Operation__c = operation != null ? operation : 'equals'
            ),
            true
        );
        return rule;
    }

    public static dmpl__ServiceCampaignRule__c getServiceCampaignRuleByName(String name) {
        return [
            SELECT Id, Name, dmpl__ServiceCampaignId__c, dmpl__ObjectType__c, dmpl__Operation__c
            FROM dmpl__ServiceCampaignRule__c
            WHERE Name = :name
            LIMIT 1
        ];
    }

    public static List<dmpl__ServiceCampaignRule__c> getRulesByCampaign(Id campaignId) {
        return [
            SELECT Id, Name, dmpl__ObjectType__c, dmpl__Operation__c
            FROM dmpl__ServiceCampaignRule__c
            WHERE dmpl__ServiceCampaignId__c = :campaignId
        ];
    }
}