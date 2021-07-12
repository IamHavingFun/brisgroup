/**This trigger will set the Last_Survey_Date_del__c field on case contact
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since July 2014
**/
trigger updateLastSurveyDate on Case (before update) {
    for(case cs :trigger.new) { 
        case oldCase = Trigger.oldMap.get(cs.ID);
        if(cs.Survey_Sent__c == true && oldCase.Survey_Sent__c != true) {
            date myDate = date.today();
            Contact c = [select id, Last_Survey_Date_del__c, dupcheck__dc3DisableDuplicateCheck__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            if(c != null) {
                if(c.IsPersonAccount) {
                    Account a = [select id, Last_Survey_Date_del__pc,dupcheck__dc3DisableDuplicateCheck__c from account where id = :c.AccountId];
                    a.Last_Survey_Date_del__pc = myDate;
                    a.dupcheck__dc3DisableDuplicateCheck__c= true;
                    UPDATE a;
                }
                else {
                    c.Last_Survey_Date_del__c = myDate;
                    c.dupcheck__dc3DisableDuplicateCheck__c = true;
                    UPDATE c;
                }
            }
            //Contact c = [select id, Last_Survey_Date_del__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            //if(c != null) {
            //    if(c.IsPersonAccount) {
            //        Account a = [select id, Last_Survey_Date_del__pc from account where id = :c.AccountId];
            //        a.Last_Survey_Date_del__pc = myDate;
            //        UPDATE a;
            //    }
            //    else {
            //        c.Last_Survey_Date_del__c = myDate;
            //        UPDATE c;
            //    }
            //}
        }
        if(cs.Indirect_Survey_Sent__c == true && oldCase.Indirect_Survey_Sent__c != true) {
            date myDate = date.today();
            Contact c = [select id, Last_Indirect_Survey_Date__c, dupcheck__dc3DisableDuplicateCheck__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            if(c != null) {
                if(c.IsPersonAccount) {
                    Account a = [select id, Last_Indirect_Survey_Date__pc ,dupcheck__dc3DisableDuplicateCheck__c from account where id = :c.AccountId];
                    a.Last_Indirect_Survey_Date__pc = myDate;
                    a.dupcheck__dc3DisableDuplicateCheck__c = true;
                    UPDATE a;
                }
                else {
                    c.Last_Indirect_Survey_Date__c = myDate;
                    c.dupcheck__dc3DisableDuplicateCheck__c = true;
                    UPDATE c;
                }
            }
            //Contact c = [select id, Last_Indirect_Survey_Date__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            //if(c != null) {
            //    if(c.IsPersonAccount) {
            //       Account a = [select id, Last_Indirect_Survey_Date__pc from account where id = :c.AccountId];
            //        a.Last_Indirect_Survey_Date__pc = myDate;
            //        UPDATE a;
            //    }
            //    else {
            //        c.Last_Indirect_Survey_Date__c = myDate;
            //        UPDATE c;
            //    }
            //}
        } 
        if(cs.Bristancare_Survey_Sent__c == true && oldCase.Bristancare_Survey_Sent__c != true) {
            date myDate = date.today();
            Contact c = [select id, Last_Bristancare_Survey_Date__c, dupcheck__dc3DisableDuplicateCheck__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            if(c != null) {
                if(c.IsPersonAccount) {
                    Account a = [select id, Last_Bristancare_Survey_Date__pc ,dupcheck__dc3DisableDuplicateCheck__c from account where id = :c.AccountId];
                    a.Last_Bristancare_Survey_Date__pc = myDate;
                    a.dupcheck__dc3DisableDuplicateCheck__c = true;
                    UPDATE a;
                }
                else {
                    c.Last_Bristancare_Survey_Date__c = myDate;
                    c.dupcheck__dc3DisableDuplicateCheck__c = true;
                    UPDATE c;
                }
            }
            //Contact c = [select id, Last_Bristancare_Survey_Date__c, IsPersonAccount, AccountId from contact where id = :cs.contactid];
            //if(c != null) {
            //    if(c.IsPersonAccount) {
            //        Account a = [select id, Last_Bristancare_Survey_Date__pc from account where id = :c.AccountId];
            //        a.Last_Bristancare_Survey_Date__pc = myDate;
            //        UPDATE a;
            //    }
            //    else {
            //        c.Last_Bristancare_Survey_Date__c = myDate;
            //        UPDATE c;
            //    }
            //}
        }        
    }
}