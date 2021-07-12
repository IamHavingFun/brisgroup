/*
 * This trigger updates:
 *   Several account fields, see comments
 * Author : Steve Mason
 * since  : March 2019
 * E-Mail : smason@bristan.com
 */
trigger accountFieldUpdates on Account (before insert, before update) {
      try {
          schema.describesobjectresult resultAcc = Account.sobjecttype.getdescribe();
          Map<string, schema.recordtypeinfo> accRecTypeId = resultAcc.getrecordtypeinfosbyname();
          Id accRec = accRecTypeId.get('Direct').getrecordtypeid();
          Account accOld = null;
          for(Account acc: trigger.new) {
             if(!Trigger.isInsert) {
                  accOld = System.Trigger.oldMap.get(acc.id);
              } else {
                  accOld = null;
              }
              if(acc.Cleanse_Complete__c && !accOld.Cleanse_Complete__c) {
                  acc.Cleanse_Complete_Date__c = System.today();  // Set cleanse complete date
              }
              if(acc.Data_Cleanse__c && !accOld.Data_Cleanse__c) {
                  acc.Data_Cleanse_Date__c = System.today();  // Set data cleanse date
              }
              if(acc.Deactivate_Account__c && !accOld.Deactivate_Account__c) {
                  acc.Deactivate_Account_Date__c = System.today();  // Set date deactivated
              }
              if(acc.RecordTypeId == accRec  && acc.Heritage_Customer__c && !accOld.Heritage_Customer__c && !acc.Heritage_New_Customer_Pack_Sent__c) {
                  acc.Heritage_New_Customer_Pack_Sent__c = true; // Set heritage customer from date
              }            
              if(acc.RecordTypeId == accRec && acc.Heritage_Customer__c && !accOld.Heritage_Customer__c) {
                  acc.Heritage_Customer_From__c = System.today(); // Set customer pack sent field
              }
              if(!acc.IsPersonAccount) {
                  acc.BillingStreet = acc.Address_Line_1__c  + ', ' + acc.Address_Line_2__c ;
                  acc.BillingCity = acc.Town__c;
                  acc.BillingState = acc.County__c;                  // Copy custom address fields to billing address (for FindNearby app)
                  acc.BillingPostalCode = acc.Postcode__c;
                  acc.BillingCountry = acc.Countrynew__c;
              }
              
              if(acc.IsPersonAccount) {
                  if(Trigger.isInsert) {
                      if(acc.GDPR_Confirmed__pc != '') {
                          acc.GDPR_Confirmed_Date__pc = System.today();
                      }
                  }
                  if(Trigger.isUpdate) {
                      if(acc.GDPR_Confirmed__pc != accOld.GDPR_Confirmed__pc ) {
                          acc.GDPR_Confirmed_Date__pc = System.today();
                      }
                  }    
                  if(acc.PersonMobilePhone != '' && acc.PersonMobilePhone != null) {
                    acc.Mobile_Phone_Email__pc = acc.PersonMobilePhone.replace(' ','') + '@textmarketer.biz';
                  } else {
                    acc.Mobile_Phone_Email__pc = '';
                  }
              }
          }
      }
      Catch(Exception e) {
          System.debug('************************** Exception in trigger on Accounts:'+e);
      }
}