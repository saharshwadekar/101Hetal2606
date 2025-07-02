@isTest
private class VisitPlanHandler_Test {
    @TestSetup
    static void createRequiredData() {
        Account partnerAccount = TestDataHelpers.createPartnerAccount();
        Account customerAccount = TestDataHelpers.createCustomerAccount(); 
        dmpl__AccountGroup__c AccountGroup = TestDataHelpers.createAccountGroup();       
        dmpl__Branch__c branch =TestDataHelpers.createBranch(partnerAccount);  
        dmpl__Resource__c resource =TestDataHelpers.createResource(partnerAccount,branch);  
        dmpl__ContactAddress__c contactAddress =TestDataHelpers.CreateContactAddress(customerAccount);
        dmpl__Item__c item =TestDataHelpers.createItem();
        dmpl__SKU__c sku =TestDataHelpers.createSKU(item);
        dmpl__VisitRoute__c route =VisitPlanTestDataHelpers.CreateVisitRoute(accountGroup,partnerAccount,resource);
        dmpl__VisitRouteStop__c routeStop=VisitPlanTestDataHelpers.CreateVisitRouteStop(customerAccount,route);
        dmpl__VisitTaskTemplate__c taskTemplate=VisitPlanTestDataHelpers.CreateVisitTaskTemplate();
        dmpl__VisitPlan__c plans=VisitPlanTestDataHelpers.CreateVisitPlan(partnerAccount,route,taskTemplate);
        dmpl__Visit__c visits=VisitPlanTestDataHelpers.CreateVisit(customerAccount,plans,taskTemplate);
        dmpl__VisitTaskTemplateEntry__c entry=VisitPlanTestDataHelpers.CreateVisitTaskTemplateEntry(taskTemplate);
        dmpl__VisitTaskTemplateActivity__c taskTempActivity=VisitPlanTestDataHelpers.CreateVisitTaskTemplateActivity(entry);
        dmpl__VisitTask__c task=VisitPlanTestDataHelpers.CreateVisitTask(visits,entry);
        dmpl__VisitTaskActivity__c taskActivity=VisitPlanTestDataHelpers.CreateVisitTaskActivity(task);
        Account partnerAccount1 = TestDataHelpers.createPartnerAccount('Partner 1', false, true, false, true, 'MG Road', 'Bengaluru', 'Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India', '560095','9876543210');
        Account partnerAccount2 = TestDataHelpers.createPartnerAccount('Partner 2', false, true, false, false, '45 Residency Road', 'Pune', 'Maharashtra', 'India', '411001', '22 Commerce Avenue', 'Pune', 'Maharashtra', 'India', '411038','91-99665544433');
        Account partnerAccount6 = TestDataHelpers.createPartnerAccount('Partner 6', false, true, false, true, 'MS Road', 'Bengaluru','Karnataka', 'India', '560001', '56 Industrial Layout', 'Bengaluru', 'Karnataka', 'India','560095','9845543210');
        dmpl__Branch__c branch6 =TestDataHelpers.createBranch('Branch 6',partnerAccount6.Id,true,true,false,true);
        dmpl__Branch__c branch1=TestDataHelpers.createBranch('Branch 1', partnerAccount1.Id, true, true, false, true);

         dmpl__VisitPlan__c plan = VisitPlanTestDataHelpers.createVisitPlan(partnerAccount1,'Test Plan','Order Capture',Date.Today(),branch1);
    }

    @isTest
    static void createVisitPlanPositive() {
        dmpl__VisitPlan__c plans=VisitPlanTestDataHelpers.getVisitPlan();
        if(plans !=null) {
            System.assertNotEquals(plans, null, 'Expected Visit Plan to be created.');
        }
        System.assertEquals( 'Task',plans.dmpl__Status__c, 'Expected Status to be Task.');
        System.assertEquals( 'Order Capture',plans.dmpl__VisitPurpose__c, 'Expected Visit Purpose to be Order Capture.');
        
        dmpl__Visit__c visits=VisitPlanTestDataHelpers.getVisit();
        if(visits!=null) {
            System.assertNotEquals(visits, null, 'Expected Visit to be created.');
        }
        System.assertEquals( 1,visits.dmpl__SequenceNumber__c, 'Expected Sequence no. to be 1.');
        
        dmpl__VisitTask__c task=VisitPlanTestDataHelpers.getVisitTask();
        if(task!=null) {
            System.assertNotEquals(task, null, 'Expected Visit Task to be created.');
        }
        System.assertEquals( 5,task.dmpl__SequenceNumber__c, 'Expected Sequence no. to be 5.');
        System.assertEquals( 'Planned',task.dmpl__Status__c, 'Expected Status to be Planned.');
        
        dmpl__VisitTaskActivity__c taskActivity=VisitPlanTestDataHelpers.getVisitTaskActivity();
        System.debug(taskActivity);
        if(taskActivity!=null) {
            System.assertNotEquals(taskActivity, null, 'Expected Visit Task Activity to be created.');
        }
        System.assertEquals(1,taskActivity.dmpl__SequenceNumber__c, 'Expected Sequence no. here also to be 1.');
        System.assertEquals(true,taskActivity.dmpl__PerformAutomatically__c, 'Expected Perform Automatically to be false.');
        System.assertEquals('http://www.example.com', taskActivity.dmpl__URL__c, 'URL mismatch');
    }

    @isTest
    static void updateVisitPlanPositive() {
        dmpl__VisitPlan__c plans=VisitPlanTestDataHelpers.getVisitPlan();
        System.assertNotEquals(plans, null, 'Visit Plan should exist before update.');
        plans.dmpl__Status__c = 'Completed';
        plans.dmpl__VisitPurpose__c = 'Order Delivery';
        update plans;

        dmpl__VisitPlan__c updatedPlans = VisitPlanTestDataHelpers.getVisitPlan();
        System.assertEquals( 'Completed',updatedPlans.dmpl__Status__c, 'Expected Status to be Completed.');  
        System.assertEquals( 'Order Delivery',updatedPlans.dmpl__VisitPurpose__c, 'Expected Visit Purpose to be Order Delivery.');
        
        dmpl__Visit__c visits=VisitPlanTestDataHelpers.getVisit();
        System.assertNotEquals(visits, null, 'Visit should exist before update.');
        visits.dmpl__SequenceNumber__c = 2;
        visits.dmpl__VisitStatus__c = 'Assigned';
        update visits;
        
        dmpl__Visit__c updatedVisits=VisitPlanTestDataHelpers.getVisit();
        System.assertEquals( 2,updatedVisits.dmpl__SequenceNumber__c, 'Expected Sequence no. to be 2.');  
        System.assertEquals( 'Assigned',updatedVisits.dmpl__VisitStatus__c, 'Expected Visit Status to be Assigned.');
        
        dmpl__VisitTask__c task=VisitPlanTestDataHelpers.getVisitTask();
        System.assertNotEquals(task, null, 'Visit Task should exist before update.');
        task.dmpl__SequenceNumber__c = 6;
        task.dmpl__Status__c='Started';
        update task;
        
        dmpl__VisitTask__c updatedTask=VisitPlanTestDataHelpers.getVisitTask();
        System.assertEquals( 6,updatedTask.dmpl__SequenceNumber__c, 'Expected Sequence no. to be 6.');  
        System.assertEquals( 'Started',updatedTask.dmpl__Status__c, 'Expected Status to be Started.');
        
        dmpl__VisitTaskActivity__c taskActivity=VisitPlanTestDataHelpers.getVisitTaskActivity();
        System.assertNotEquals(taskActivity, null, 'Visit Task Activity should exist before update.');
        taskActivity.dmpl__SequenceNumber__c=11;
        taskActivity.dmpl__PerformAutomatically__c=true;
        update taskActivity;
        
        dmpl__VisitTaskActivity__c updatedTaskActivity=VisitPlanTestDataHelpers.getVisitTaskActivity();
        System.assertEquals(11,updatedTaskActivity.dmpl__SequenceNumber__c, 'Expected Sequence no. to be 11.');
        System.assertEquals(true,updatedTaskActivity.dmpl__PerformAutomatically__c, 'Expected Perform Automatically to be true.');
    }
    @isTest
    static void createVisitPlanWithActivePartnerPositive() {
        Test.startTest();
        dmpl__VisitPlan__c fetchedPlan = VisitPlanTestDataHelpers.getVisitPlanNew();
        Test.stopTest();

      
        System.assertEquals('Test Plan', fetchedPlan.Name, 'Plan Name should match.');
        System.assertEquals('Order Capture', fetchedPlan.dmpl__VisitPurpose__c, 'Visit Purpose should match.');
        System.assertEquals(Date.today(), fetchedPlan.dmpl__PlanStartDate__c, 'Plan Start Date should be today.');
    }

    @isTest
    static void createVisitPlanWithInactivePartnerNegative() {
    Test.startTest();

    Account inactivePartner = TestDataHelpers.getPartnerAccount('Partner 2');
    dmpl__Branch__c branch = TestDataHelpers.getBranch('Branch 2');

    try {
        dmpl__VisitPlan__c plan = VisitPlanTestDataHelpers.createVisitPlan(
            inactivePartner,
            'Test Plan',
            'Order Capture',
            Date.today(),
            branch
        );
        System.assert(false, 'Expected exception for inactive partner account.');
    } catch (Exception e) {
        System.debug('Expected exception: ' + e.getMessage());
        System.assert(
            e.getMessage().containsIgnoreCase('inactive') ||
            e.getMessage().containsIgnoreCase('cannot create'),
            'Error should mention inactive partner or restriction.'
        );
    }

    Test.stopTest();
}

}