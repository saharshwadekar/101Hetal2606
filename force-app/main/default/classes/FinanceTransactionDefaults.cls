@isTest
public class FinanceTransactionDefaults implements TestFactory.FieldDefaults{
    public Map<String, Object> getFieldDefaults(){
        return new Map<String, Object>{ 
            'AccountId'=>null,
            'AdjustmentAmount'=>'123',
            'BaseCurrencyAmount'=>'123',
            'BaseCurrencyBalance'=>'123',
            'BaseCurrencyFxDate'=>'2024-01-01',
            'BaseCurrencyFxRate'=>'123',
            'BaseCurrencyIsoCode'=>'91',
            'ChargeAmount'=>'123',
            'DestinationEntityId'=>null,
            'DueDate'=>'2024-01-01',
            'EffectiveDate'=>'2024-01-01',
            'EventAction'=>'Post an invoice',
            'EventType'=>'Allocated',
            'FinanceSystemIntegrationMode'=>'none',
            'FinanceSystemName'=>'FinanceSystem1',
            'FinanceSystemTransactionNumber'=>'1234',
            'ImpactAmount'=>'1234',       
            'LegalEntityId'=>null,
            'FinanceTransactionNumber'=>'1234',
            'OriginalCreditGlAccountName'=>'OriginalCreditGlAccount1',
            'OriginalCreditGlAccountNumber'=>'1234',
            'OriginalDebitGlAccountName'=>'OriginalDebitGlAccount1',
            'OriginalDebitGlAccountNumber'=>'1234',
            'OriginalEventAction'=>'none',
            'OriginalEventType'=>'none',
            'OriginalFinanceBookName'=>'OriginalFinanceBook1',
            'OriginalFinancePeriodEndDate'=>'2024-01-01',
            'OriginalFinancePeriodName'=>'OriginalFinancePeriod1',
            'OriginalFinancePeriodStartDate'=>'2024-01-01',
            'OriginalFinancePeriodStatus'=>'none',
            'OriginalGlRuleName'=>'none',
            'OriginalGlTreatmentName'=>'OriginalGlTreatment1',
            'OriginalReferenceEntityType'=>'none',
            'ParentReferenceEntityId'=>null,
            'ReferenceEntityId'=>null,
            'ReferenceEntityType'=>'Invoice',
            'ResultingBalance'=>'1234',
            'SourceEntityId'=>null,
            'Subtotal'=>'1234',
            'TaxAmount'=>'123',
            'TotalAmountWithTax'=>'123',
            'TransactionDate'=>'2024-01-01'
        };
    }
}