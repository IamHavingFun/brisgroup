/**
 * 
 * @author PolSource
 */
public with sharing class CaseTriggerHandler {

    private CaseTriggerHandler() {}
    /**
     * @param records `List<Case>` List of all cases we want to copy all comments from
     */
    public static void copyAllCommentsFromCase(List<Case> records) {
        List<String> caseIds = new List<String>();
        for (Case cs : records) {
            if (cs.isClone()) {
                caseIds.add(cs.getCloneSourceId());
            }
        }
        Map<String, List<CaseComment>> commentsByCase = new Map<String, List<CaseComment>>();
        for (CaseComment cc : [SELECT ParentId, CommentBody FROM CaseComment WHERE ParentId IN :caseIds ORDER BY CreatedDate ASC]) {
            if (commentsByCase.containsKey(cc.ParentId)) {
                List<CaseComment> comments = commentsByCase.get(cc.ParentId);
                comments.add(cc);
                commentsByCase.put(cc.ParentId, comments);                
            } else {
                commentsByCase.put(cc.ParentId, new List<CaseComment>{cc});
            }
        }
        List<CaseComment> clonedComments = new List<CaseComment>();
        for (Case cs : records) {
            if (cs.isClone()) {
                String csId = cs.getCloneSourceId();
                List<CaseComment> comments = commentsByCase.get(csId);
    
                for (CaseComment comment : comments) {
                    CaseComment cc = new CaseComment();
                    cc.CommentBody = comment.CommentBody;
                    cc.ParentId = cs.Id;
                    clonedComments.add(cc);
                }
            }
        }
    
        if (!clonedComments.isEmpty()) {
            insert clonedComments;
        }
    }

    /**
     * @param records `List<Case>` we need to update their Closed By fields
     */
    public static void updateClosedBy(List<Case> records) {
        List<String> caseIds = new List<String>();
        for (Case cs : records) {
            caseIds.add(cs.Id);
        }
        Map<String, Case> cases = new Map<String, Case>([SELECT Id, Owner.Type, Owner.Name FROM Case WHERE Id IN :caseIds]);
        User usertemp = [SELECT Id, Name FROM User WHERE Id = :UserInfo.getUserId()];

        for (Case cs : records) { 
            if (Trigger.isUpdate) {
                Case oldCase = (Case) Trigger.oldMap.get(cs.ID);
                Case c = cases.get(cs.Id);
    
                if (cs.Status == 'Closed' && (oldCase.Status != 'Closed' || oldCase.Status == null || oldCase.Status == '') && (cs.Closed_By__c == '' || cs.Closed_By__c == null) && (c.owner.type == 'User')) {
                    cs.Closed_By__c = c.Owner.Name;
                    cs.Closed_by_SFID__c = cs.OwnerId;
                    system.debug('CaseID : ' + cs.id);
                    system.debug('Closed_By__c : ' + cs.Closed_By__c);
                    system.debug('Closed_by_SFID__c : ' + cs.Closed_by_SFID__c);
                }
            }
            if (Trigger.isInsert && cs.Status == 'Closed') {
                cs.Closed_By__c = usertemp.Name;
                cs.Closed_by_SFID__c = usertemp.Id;
                system.debug('CaseID : ' + cs.id);
                system.debug('Closed_By__c : ' + cs.Closed_By__c);
                system.debug('Closed_by_SFID__c : ' + cs.Closed_by_SFID__c);
            }
        }        
    }

    /**
     * @param records `List<Case>` we need to update whether the contact or account related records
     */
    public static void updateDatesOnContactAndAccounts(List<Case> records) {
        List<String> accountIds = new List<String>();
        List<String> contactIds = new List<String>();    
        for (Case cs : records) {
            contactIds.add(cs.ContactId);
        }
        Map<String, Contact> contacts = new Map<String, Contact>([SELECT Id, IsPersonAccount, AccountId FROM Contact WHERE Id IN :contactIds]);
        for (Contact c : contacts.values()) {
            accountIds.add(c.AccountId);
        }
        Map<String, Account> accounts = new Map<String, Account>([SELECT Id FROM Account WHERE Id IN :accountIds]);
        List<Account> accountsUpdate = new List<Account>();
        List<Contact> contactsUpdate = new List<Contact>();
        Date myDate = Date.today();

        for (Case cs : records) {
            if (contacts.containsKey(cs.contactid)) {
                Contact c = contacts.get(cs.contactid);
                Case oldCase = (Case) Trigger.oldMap.get(cs.ID);
                if (cs.Survey_Sent__c && !oldCase.Survey_Sent__c) {
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Survey_Date_del__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c= true;
                        accountsUpdate.add(a);
                    } else {
                        c.Last_Survey_Date_del__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }

                if (cs.Indirect_Survey_Sent__c && !oldCase.Indirect_Survey_Sent__c) {
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Indirect_Survey_Date__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c = true;
                        accountsUpdate.add(a);
                    } else {
                        c.Last_Indirect_Survey_Date__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }

                if (cs.Bristancare_Survey_Sent__c && !oldCase.Bristancare_Survey_Sent__c ) {
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Bristancare_Survey_Date__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c = true;
                        accountsUpdate.add(a);
                    } else {
                        c.Last_Bristancare_Survey_Date__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }
            }
        }

        update contactsUpdate;
        update accountsUpdate;
    }
}
