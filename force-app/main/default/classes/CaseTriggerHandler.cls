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
        // store all ids from cloned cases
        List<String> caseIds = new List<String>();
        for (Case cs : records) {
            // Returns true if an entity is cloned from something, even if the entity hasn’t been saved.
            if (cs.isClone()) {
                // Returns the ID of the entity from which an object was cloned (Original Case record)
                caseIds.add(cs.getCloneSourceId());
            }
        }

        // create a map that returns a list of comment records for each Case Parent Id
        Map<String, List<CaseComment>> commentsByCase = new Map<String, List<CaseComment>>();
        // get all comment records from the original case records
        for (CaseComment cc : [SELECT ParentId, CommentBody FROM CaseComment WHERE ParentId IN :caseIds ORDER BY CreatedDate ASC]) {
            // if this parentId already has any comments on its list, add a new record to it
            if (commentsByCase.containsKey(cc.ParentId)) {
                List<CaseComment> comments = commentsByCase.get(cc.ParentId);
                comments.add(cc);
                commentsByCase.put(cc.ParentId, comments);                
            } else {
                // the first time the iteration finds the parentId, create a list including the case comment record to it
                commentsByCase.put(cc.ParentId, new List<CaseComment>{cc});
            }
        }
        List<CaseComment> clonedComments = new List<CaseComment>();
        for (Case cs : records) {
            // Returns true if an entity is cloned from something, even if the entity hasn’t been saved.
            if (cs.isClone()) {
                // Returns the ID of the entity from which an object was cloned (Original Case record)
                String csId = cs.getCloneSourceId();
                List<CaseComment> comments = commentsByCase.get(csId);
                // no comments found on case, skip record and continue with next one
                if (comments == null) {
                    continue;
                }
                // loop through all comment records from original case record
                for (CaseComment comment : comments) {
                    CaseComment cc = new CaseComment();
                    cc.CommentBody = comment.CommentBody;
                    cc.ParentId = cs.Id;
                    // add recod to list
                    clonedComments.add(cc);
                }
            }
        }
    
        // check if any case comment record is present on the list
        if (!clonedComments.isEmpty()) {
            // perform DML Insert operation using a List of SOBjects
            insert clonedComments;
        }
    }

    /**
     * @param records `List<Case>` we need to update their Closed By fields
     */
    public static void updateClosedBy(List<Case> records) {
        // Holds a list of all cases id
        List<String> caseIds = new List<String>();
        for (Case cs : records) {
            caseIds.add(cs.Id);
        }
        // query case object and get Owner Type and Name from the list of updated cases
        Map<String, Case> cases = new Map<String, Case>([SELECT Id, Owner.Type, Owner.Name FROM Case WHERE Id IN :caseIds]);
        // Based on the context user's ID, get its name and ID
        User usertemp = [SELECT Id, Name FROM User WHERE Id = :UserInfo.getUserId()];

        for (Case cs : records) {
            // if method was triggered from an update operation 
            if (Trigger.isUpdate) {
                // get old record's version
                Case oldCase = (Case) Trigger.oldMap.get(cs.ID);
                Case c = cases.get(cs.Id);
    
                if (cs.Status == 'Closed' && (oldCase.Status != 'Closed' || oldCase.Status == null || oldCase.Status == '') && (cs.Closed_By__c == '' || cs.Closed_By__c == null) && (c.owner.type == 'User')) {
                    // set Owner Name as closed by field value
                    cs.Closed_By__c = c.Owner.Name;
                    // set Owner Id as Closed by SFID field value
                    cs.Closed_by_SFID__c = cs.OwnerId;
                    system.debug('CaseID : ' + cs.id);
                    system.debug('Closed_By__c : ' + cs.Closed_By__c);
                    system.debug('Closed_by_SFID__c : ' + cs.Closed_by_SFID__c);
                }
            }
            // If a new case is inserted and its status equals 'Closed'
            if (Trigger.isInsert && cs.Status == 'Closed') {
                // Set context user's Name as Closed By field value
                cs.Closed_By__c = usertemp.Name;
                // Set context user's Id as Closed By SFID field value
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
        // list of case's account Id
        List<String> accountIds = new List<String>();
        // list of case's contact ids
        List<String> contactIds = new List<String>();    
        for (Case cs : records) {
            // add Id to List
            contactIds.add(cs.ContactId);
        }
        // Map that returns a contact record given its Id
        Map<String, Contact> contacts = new Map<String, Contact>([SELECT Id, IsPersonAccount, AccountId FROM Contact WHERE Id IN :contactIds]);
        // Iterate through contact list
        for (Contact c : contacts.values()) {
            // add Id to List
            accountIds.add(c.AccountId);
        }
        // Map that returns an Account record given its Id
        Map<String, Account> accounts = new Map<String, Account>([SELECT Id FROM Account WHERE Id IN :accountIds]);
        // List of Accounts to be updated
        List<Account> accountsUpdate = new List<Account>();
        // List of Contacts to be updated
        List<Contact> contactsUpdate = new List<Contact>();
        // Get today's date
        Date myDate = Date.today();

        for (Case cs : records) {
            if (contacts.containsKey(cs.contactid)) {
                Contact c = contacts.get(cs.contactid);
                Case oldCase = (Case) Trigger.oldMap.get(cs.ID);
                // if Case's Survey_Sent__c value went from FALSE to TRUE
                if (cs.Survey_Sent__c && !oldCase.Survey_Sent__c) {
                    // If contact is a person account, then we need to update its account record
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Survey_Date_del__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c= true;
                        accountsUpdate.add(a);
                    } else {
                        // If contact is not a person account, then we update the contact record
                        c.Last_Survey_Date_del__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }

                // if Case's Indirect_Survey_Sent__c value went from FALSE to TRUE
                if (cs.Indirect_Survey_Sent__c && !oldCase.Indirect_Survey_Sent__c) {
                    // If contact is a person account, then we need to update its account record
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Indirect_Survey_Date__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c = true;
                        accountsUpdate.add(a);
                    } else {
                        // If contact is not a person account, then we update the contact record
                        c.Last_Indirect_Survey_Date__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }

                // if Case's Bristancare_Survey_Sent__c value went from FALSE to TRUE
                if (cs.Bristancare_Survey_Sent__c && !oldCase.Bristancare_Survey_Sent__c ) {
                    // If contact is a person account, then we need to update its account record
                    if (c.IsPersonAccount) {
                        Account a = accounts.get(c.AccountId);
                        a.Last_Bristancare_Survey_Date__pc = myDate;
                        a.dupcheck__dc3DisableDuplicateCheck__c = true;
                        accountsUpdate.add(a);
                    } else {
                        // If contact is not a person account, then we update the contact record
                        c.Last_Bristancare_Survey_Date__c = myDate;
                        c.dupcheck__dc3DisableDuplicateCheck__c = true;
                        contactsUpdate.add(c);
                    }
                }
            }
        }

        // update list of contacts and Accounts if any changes were made.
        update contactsUpdate;
        update accountsUpdate;
    }
}
