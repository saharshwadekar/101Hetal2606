@isTest
private class MetadataTriggerHandler_Tests {
    @isTest
    static void testMetadataTriggerHandlerNoOppWithoutRecordsPositive() {
        TestDouble stub = new TestDouble(MetadataTriggerService.class);
        TestDouble.Method stubbedGetMetatdataRecords = new TestDouble.Method(
                'getMetadataTriggers'
            )
            .returning(new List<DMSTriggerMapping__mdt>());

        stub.track(stubbedGetMetatdataRecords);

        MetadataTriggerHandler mdtHandler = new MetadataTriggerHandler(
            (MetadataTriggerService) stub.generate()
        );

        mdtHandler.setTriggerContext('after update', true);

        Test.startTest();
        mdtHandler.run();
        Test.stopTest();

        System.assertEquals(
            null,
            mdtHandler.activeHandler,
            'Expected the activeHandler Property to be null, as no handlers were returned.'
        );
    }

    @isTest
    static void testExecutesBeforeInsertPositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before insert'
        );
    }

    @isTest
    static void testExecutesBeforeUpdatePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before update'
        );
    }

    @isTest
    static void testExecutesBeforeDeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before delete'
        );
    }

    @isTest
    static void testExecutesAfterInsertPositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after insert'
        );
    }

    @isTest
    static void testExecutesAfterUpdatePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after update'
        );
    }

    @isTest
    static void testExecutesAfterDeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after delete'
        );
    }

    @isTest
    static void testExecutesAfterUndeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after undelete'
        );
    }

    private static void exerciseTriggerHandlerPositive(String context) {
        DMSTriggerMapping__mdt sampleHandler = new DMSTriggerMapping__mdt();
        sampleHandler.className__c = 'sampleHandler';
        sampleHandler.enabled__c = true;
        sampleHandler.executionOrder__c = 1;
        sampleHandler.objectName__c = 'contact';

        TestDouble stub = new TestDouble(MetadataTriggerService.class);
        TestDouble.Method stubbedGetMetatdataRecords = new TestDouble.Method(
                'getMetadataTriggers'
            )
            .returning(new List<DMSTriggerMapping__mdt>{ sampleHandler });

        stub.track(stubbedGetMetatdataRecords);

        MetadataTriggerHandler mdtHandler = new MetadataTriggerHandler(
            (MetadataTriggerService) stub.generate()
        );

        mdtHandler.setTriggerContext(context, true);

        Test.startTest();
        mdtHandler.run();
        Test.stopTest();

        System.assertEquals(
            'SampleHandler',
            TestHelper.getUnkownObjectType(mdtHandler.activeHandler),
            'Expected the activeHandler Property to be \'SampleHandler\'.'
        );
    }
}