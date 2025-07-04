@isTest
public with sharing class DeliveryOrderDefaults implements TestFactory.FieldDefaults {
    public Map<String, Object> getFieldDefaults(){
        return new Map<String, Object>{ 
            'dmpl__AccountName__c'=>'AccountName1',
            'dmpl__BillingAddress__c'=>'Mohali, Punjab',
            'dmpl__BillingCity__c'=>'Mumbai',
            'dmpl__BillingCountry__c'=>'India',
            'dmpl__BillingPostalCode__c'=>'140055',
            'dmpl__BillingRegion__c'=>'north',
            'dmpl__BillingState__c'=>'Punjab',
            'dmpl__BillingStreet__c'=>'mohali',
            'dmpl__DeliveredDateTime__c'=>null,
            'dmpl__DeliveryCity__c'=>'Mumbai',
            'dmpl__DeliveryCountry__c'=>'India',
            'dmpl__DeliveryDate__c'=>null,
            'dmpl__DeliveryDoneBy__c'=>null,
            'dmpl__DeliveryPostalCode__c'=>'140055',
            'dmpl__DeliveryRegion__c'=>'north',
            'dmpl__DeliveryState__c'=>'Punjab',
            'dmpl__DeliveryStreet__c'=>'mohali',
            'dmpl__Discount__c'=>1000,
            'dmpl__DocumentDate__c'=>Date.today(),
            'dmpl__IsCancelled__c'=>false,
            'dmpl__IsConfirmed__c'=>false,
            'dmpl__IsDelivered__c'=>false,
            'dmpl__IsILPosted__c'=>false,
            'dmpl__IsILPostingApproved__c'=>false,
            'dmpl__IsInJobQueue__c'=>false,
            'dmpl__IsShipmentReleased__c'=>false,
            'dmpl__PerformPopulateChecklist__c'=>false,
            'dmpl__PerformReleaseShipment__c'=>false,
            'dmpl__PriceAsOnDate__c'=>null,
            'dmpl__Remarks__c'=>'Remarks1',
            'dmpl__RequestedDeliveryDate__c'=>null,
            'dmpl__RequestedDeliveryDateTime__c'=>null,
            'dmpl__RequestedDeliveryTime__c'=>null,
            'dmpl__ScheduledDeliveryDate__c'=>null,
            'dmpl__ScheduledDeliveryDateTime__c'=>null,
            'dmpl__ShippingAddress__c'=>'Mohali,punjab',
            'dmpl__ShippingCity__c'=>'Mumbai',
            'dmpl__ShippingCountry__c'=>'India',
            'dmpl__ShippingPostalCode__c'=>'140055',
            'dmpl__ShippingRegion__c'=>'north',
            'dmpl__ShippingState__c'=>'Punjab',
            'dmpl__ShippingStreet__c'=>'mohali',
            'dmpl__Status__c'=>'Draft',
            'dmpl__TaxSupplyType__c'=>'Within State'
        };
    }
}