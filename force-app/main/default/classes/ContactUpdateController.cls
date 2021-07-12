public with sharing class ContactUpdateController {

    PageReference newPage;
    Contact con; 

    public ContactUpdateController (ApexPages.StandardController stdController) { 
        con = (Contact)stdController.getRecord(); 
    }

    public PageReference save() {
        try {
            // Code for Duplicate Check
            dupcheck.dc3Api api = new dupcheck.dc3Api();
            ApexPages.Message prevention = api.doDuplicatePrevention(con);
            if (prevention != null && !con.dupcheck__dc3DisableDuplicateCheck__c) {
               ApexPages.addMessage(prevention);
               return null;
            }   
            // End Duplicate Check
            con.dupcheck__dc3DisableDuplicateCheck__c = false;
            upsert(con);     
            newPage = New PageReference('/'+con.id);
            newPage.setRedirect(true);
            return newPage;
        }
        catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }  
    }
}