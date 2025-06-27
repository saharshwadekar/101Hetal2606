public with sharing class ClaimDataHelper {
    public static dmpl__Claim__c createClaim(Id partnerAccountId){
        return (dmpl__Claim__c) TestFactory.createSObject(
            new dmpl__Claim__c(
                dmpl__Status__c = 'Draft',
                dmpl__DocumentDate__c = Date.today(),
                dmpl__ClaimType__c = 'Damaged',
                dmpl__InvoiceGroup__c = 'Service',
                dmpl__Remarks__c = 'Test Claim',
                dmpl__ApproveAll__c = true,
                dmpl__RejectAll__c = false,
                dmpl__AsOnDate__c = Date.today(),
                dmpl__ServiceInvoiceAsOnDate__c = Date.today(),
                dmpl__WorkOrderAsonDate__c = Date.today().addDays(-5),
                dmpl__PartnerAccountId__c = partnerAccountId
            ),
            'ClaimDefaults',
            true
        );
    }
    
    public static dmpl__Claim__c getClaims(){
        return [
            SELECT Id, Name, dmpl__ExternalId__c, dmpl__Status__c, dmpl__DocumentDate__c, 
                   dmpl__ClaimType__c, dmpl__InvoiceGroup__c, dmpl__Remarks__c, dmpl__ApproveAll__c,
                   dmpl__RejectAll__c, dmpl__AsOnDate__c, dmpl__ServiceInvoiceAsOnDate__c,
                   dmpl__WorkOrderAsonDate__c
            FROM dmpl__Claim__c
            LIMIT 1
        ];
    }

    public static dmpl__Claim__c getClaims(Id claimId) {
        return [
            SELECT Id, Name, dmpl__ExternalId__c, dmpl__Status__c, dmpl__DocumentDate__c, 
                   dmpl__ClaimType__c, dmpl__InvoiceGroup__c, dmpl__Remarks__c, dmpl__ApproveAll__c,
                   dmpl__RejectAll__c, dmpl__AsOnDate__c, dmpl__ServiceInvoiceAsOnDate__c,
                   dmpl__WorkOrderAsonDate__c
            FROM dmpl__Claim__c
            WHERE Id = :claimId
            LIMIT 1
        ];
    }

    public static dmpl__ClaimLine__c createClaimLine(
        Id claimId
    ){
        return (dmpl__ClaimLine__c) TestFactory.createSObject(
            new dmpl__ClaimLine__c(
                dmpl__ClaimId__c = claimId,
                dmpl__ClaimType__c = 'Part To Part',
                dmpl__Status__c = 'Approved',
                dmpl__UnitPrice2__c = 1000,
                dmpl__UnitPrice__c = 900
            ),
            'ClaimLineDefaults',
            true
        );
    }

    public static dmpl__ClaimLine__c getClaimLines() {
        return [
            SELECT Id, Name, dmpl__ExternalId__c, dmpl__Status__c, dmpl__ClaimType__c,
                   dmpl__ItemCode__c, dmpl__UnitPrice2__c, dmpl__UnitPrice__c,
                   dmpl__ApproveAmount__c, dmpl__ApproveBaseAmount__c, dmpl__ApproveDiscount__c,
                   dmpl__ApproveDiscountAmount__c, dmpl__ApproveNetDiscount__c, dmpl__ApproveQuantity__c,
                   dmpl__BaseAmount__c, dmpl__ClaimAmount__c, dmpl__ClaimQuantity__c,
                   dmpl__Discount__c, dmpl__DiscountAmount__c, dmpl__NetDiscount__c
            FROM dmpl__ClaimLine__c
            LIMIT 1
        ];
    }

    public static dmpl__ClaimLine__c getClaimLines(Id claimLineId) {
        return [
            SELECT Id, Name, dmpl__ExternalId__c, dmpl__Status__c, dmpl__ClaimType__c,
                   dmpl__ItemCode__c, dmpl__UnitPrice2__c, dmpl__UnitPrice__c,
                   dmpl__ApproveAmount__c, dmpl__ApproveBaseAmount__c, dmpl__ApproveDiscount__c,
                   dmpl__ApproveDiscountAmount__c, dmpl__ApproveNetDiscount__c, dmpl__ApproveQuantity__c,
                   dmpl__BaseAmount__c, dmpl__ClaimAmount__c, dmpl__ClaimQuantity__c,
                   dmpl__Discount__c, dmpl__DiscountAmount__c, dmpl__NetDiscount__c
            FROM dmpl__ClaimLine__c
            WHERE Id = :claimLineId
            LIMIT 1
        ];
    }
    
    
    
    
    
       public static dmpl__Claim__c createClaim(
        Id partnerAccountId,
        Id branchId,
        Id supplierAccountId,
        String claimType,
        String status,
        Id saleInvoiceId,
        Id billReturnId,
        Id repairOrderId,
        Id goodsReceiptId,
        Id purchaseReturnId
    ) {
        return (dmpl__Claim__c) TestFactory.createSObject(
            new dmpl__Claim__c(
                dmpl__PartnerAccountId__c = partnerAccountId,
                dmpl__BranchId__c = branchId,
                dmpl__SupplierNameId__c = supplierAccountId,
                dmpl__ClaimType__c = claimType,
                dmpl__Status__c = status,
                dmpl__DocumentDate__c = Date.today(),
                dmpl__SaleInvoiceId__c = saleInvoiceId,
                dmpl__BillReturnId__c = billReturnId,
                dmpl__RepairOrderId__c = repairOrderId,
                dmpl__GoodsReceiptId__c = goodsReceiptId,
                dmpl__PurchaseReturnId__c = purchaseReturnId 
            ),
            'ClaimDefaults',
            true
        );
    }
 
    public static dmpl__Claim__c createClaimWithServiceContract(
        Id partnerAccountId,
        Id branchId,
        Id supplierAccountId,
        String claimType,
        Id itemServiceContractId
    ) {
        return (dmpl__Claim__c) TestFactory.createSObject(
            new dmpl__Claim__c(
                dmpl__PartnerAccountId__c       = partnerAccountId,
                dmpl__BranchId__c               = branchId,
                dmpl__SupplierNameId__c         = supplierAccountId,
                dmpl__ClaimType__c              = claimType,
                dmpl__DocumentDate__c           = Date.today(),
                dmpl__ItemServiceContractId__c  = itemServiceContractId
            ),
            'ClaimDefaults',
            true
        );
    }
 
 
    public static dmpl__Claim__c getClaim(Id claimId) {
        return [
            SELECT Id, Name, dmpl__Status__c, dmpl__DocumentDate__c,
                dmpl__ClaimType__c, dmpl__PartnerAccountId__c, 
                dmpl__BranchId__c, dmpl__SupplierNameId__c,
                dmpl__SaleInvoiceId__c, dmpl__BillReturnId__c,
                dmpl__RepairOrderId__c, dmpl__GoodsReceiptId__c,
                dmpl__PurchaseReturnId__c 
            FROM dmpl__Claim__c
            WHERE Id = :claimId
            LIMIT 1
        ];
    }
 
    public static dmpl__ClaimLine__c createClaimLine(
        Id claimId,
        Id itemId,
        Decimal claimQuantity,
        Decimal approveQuantity,
        Decimal unitPrice,
        String claimType,
        Id goodsReceiptId,
        Id goodsReceiptLineId,
        Id claimBatchId,
        Id repairOrderLineId
    ) {
        return (dmpl__ClaimLine__c) TestFactory.createSObject(
            new dmpl__ClaimLine__c(
                dmpl__ClaimId__c             = claimId,
                dmpl__ItemId__c              = itemId,
                dmpl__ClaimQuantity__c       = claimQuantity,
                dmpl__ApproveQuantity__c     = approveQuantity,
                dmpl__UnitPrice__c           = unitPrice,
                dmpl__ClaimType__c           = claimType,
                dmpl__GoodsReceiptId__c      = goodsReceiptId,
                dmpl__GoodsReceiptLineId__c  = goodsReceiptLineId,
                dmpl__ClaimBatchId__c        = claimBatchId,
                dmpl__RepairOrderLineId__c     = repairOrderLineId
            ),
            'ClaimLineDefaults',
            true
        );
    }
 
    public static dmpl__ClaimLine__c getClaimLineById(Id claimLineId) {
        List<dmpl__ClaimLine__c> results = [
            SELECT Id, Name, dmpl__ExternalId__c, dmpl__Status__c, dmpl__ClaimType__c,
                dmpl__ItemCode__c, dmpl__UnitPrice2__c, dmpl__UnitPrice__c,
                dmpl__ApproveAmount__c, dmpl__ApproveBaseAmount__c, dmpl__ApproveDiscount__c,
                dmpl__ApproveDiscountAmount__c, dmpl__ApproveNetDiscount__c, dmpl__ApproveQuantity__c,
                dmpl__BaseAmount__c, dmpl__ClaimAmount__c, dmpl__ClaimQuantity__c,
                dmpl__Discount__c, dmpl__DiscountAmount__c, dmpl__NetDiscount__c,
                dmpl__ItemId__c, dmpl__ClaimId__c, dmpl__GoodsReceiptId__c,
                dmpl__GoodsReceiptLineId__c, dmpl__ClaimBatchId__c, dmpl__RepairOrderLineId__c
            FROM dmpl__ClaimLine__c
            WHERE Id = :claimLineId
            LIMIT 1
        ];
        return results.isEmpty() ? null : results[0];
    }
 
 
    public static dmpl__PurchaseReturn__c createPurchaseRetrun(
        Account supplierAccount,
        Account partnerAccount,
        dmpl__Branch__c branch
    ) {
        return (dmpl__PurchaseReturn__c) TestFactory.createSObject(
            new dmpl__PurchaseReturn__c(
                dmpl__SupplierAccountId__c = supplierAccount.Id,
                dmpl__BranchId__c = branch.Id,
                dmpl__Status__c = '1',
                dmpl__PartnerAccountId__c = partnerAccount.Id,
                dmpl__SupplierInvoiceDate__c = date.today(),
                dmpl__PerformReturn__c = false,
                dmpl__IsReturned__c = false,
                dmpl__PerformInventoryPosting__c=false,
                dmpl__DocumentDate__c = date.today()
            ),
            'PurchaseReturnDefaults',
            true
        );
    }
 
    public static dmpl__RepairOrder__c createRepairOrder(
        Account partnerAccount,
        dmpl__Branch__c branch,
        Account customerAccount,
        Decimal usageReading
    ){
        return (dmpl__RepairOrder__c)TestFactory.createSObject(
            new dmpl__RepairOrder__c(
                dmpl__BranchId__c = branch.Id,
                dmpl__AccountId__c = customerAccount.Id,
                dmpl__PartnerAccountId__c = branch.dmpl__PartnerAccountId__c,
                dmpl__UsageReading__c = usageReading,
                dmpl__DocumentDate__c = Date.today(),
                dmpl__Status__c = 'Draft'
            ),
            'RepairOrderDefaults',
            true
        );
    }
 
    public static dmpl__RepairOrderLine__c createRepairOrderLine(
        dmpl__RepairOrder__c repairOrder,
        dmpl__Item__c item,
        dmpl__TaxGroup__c taxGroup,
        Decimal quantity,
        Decimal unitPrice
     
    ) {
        return (dmpl__RepairOrderLine__c) TestFactory.createSObject(
            new dmpl__RepairOrderLine__c(
                dmpl__RepairOrderId__c = repairOrder.Id,
                dmpl__ItemId__c = item.Id,
                dmpl__TaxGroupId__c = taxGroup.Id,
                dmpl__Quantity__c = quantity,
                dmpl__UnitPrice__c = unitPrice
            ),
            'RepairOrderLineDefaults',
            true
        );
    }
    public static List<dmpl__RepairOrder__c> getRepairOrdersById(Id repairOrderId) {
        return [SELECT 
            Id,
            Name,
            dmpl__BranchId__c,
            dmpl__AccountId__c,
            dmpl__PartnerAccountId__c,
            dmpl__AssetId__c,
            dmpl__ServiceEstimateId__c,
            dmpl__ServiceAdvisorId__c,
            dmpl__UsageReading__c,
            dmpl__AccountName__c,
            dmpl__PriceListId__c,
            dmpl__PriceListId__r.Name,
            dmpl__TaxGroupId__c,
            dmpl__TaxGroupId__r.Name,
            dmpl__TaxSupplyType__c,
            dmpl__Status__c,
            dmpl__DocumentDate__c,
            dmpl__BillingAddress__c,
            dmpl__BillingStreet__c,
            dmpl__BillingCity__c,
            dmpl__BillingState__c,
            dmpl__BillingCountry__c,
            dmpl__BillingPostalCode__c,
            dmpl__ShippingAddress__c,
            dmpl__ShippingStreet__c,
            dmpl__ShippingCity__c,
            dmpl__ShippingState__c,
            dmpl__ShippingPostalCode__c,
            dmpl__ShippingCountry__c
        FROM dmpl__RepairOrder__c 
        WHERE Id = :repairOrderId
        LIMIT 1
        ];
    }
 
    public static dmpl__RepairOrderLine__c getRepairOrderLine(Id repairOrderLineId){
        return [SELECT 
            Id,
            Name,
            dmpl__RepairOrderId__c ,
                dmpl__ItemId__c ,
                dmpl__TaxGroupId__c ,
                dmpl__Quantity__c ,
                dmpl__UnitPrice__c 
        FROM dmpl__RepairOrderLine__c 
        WHERE Id = :repairOrderLineId
        LIMIT 1];
    }

}