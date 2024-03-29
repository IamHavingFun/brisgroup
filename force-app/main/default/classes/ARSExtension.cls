/**
 * @author PolSource
 */
public without sharing class ARSExtension {
    // Variables
    public Case corr {get;set;}
    public String myCon {set; get;}
    public String myAcc {set; get;}
    public List<Attachment> newAttachments {get; set;}
    public static final Integer NUM_ATTACHMENTS_TO_ADD=5;
    
    /**
     * @param controllerParam 
     */
    public ARSExtension (ApexPages.StandardController controllerParam) {
      // Get correspondence record
      ApexPages.StandardController ctrl = controllerParam;
      corr = (Case) ctrl.getRecord();
      newAttachments=new List<Attachment>{new Attachment()};
      for (Integer idx=0; idx<NUM_ATTACHMENTS_TO_ADD-1; idx++) {  
        newAttachments.add(new Attachment());
      }
    }
    
    /**
     * @return  `PageReference`
     */
    public PageReference customsave() {
      // Any custom save routines can go here
      try {
        corr.Reason = 'ARS';
        corr.Origin = 'ARS';        
        corr.Case_Channel__c = 'Internal';
        myCon = corr.SuppliedEmail;
        system.debug('####### Email : ' + corr.SuppliedEmail);
        List<Contact> conId = [SELECT Id, AccountId FROM Contact WHERE Email = :myCon limit 1];
        if(!conId.isEmpty()) {
          system.debug('####### ConId : ' + conId[0].Id);
          system.debug('####### AccId : ' + conId[0].AccountId);
          corr.ContactId = conId[0].Id;
          corr.AccountId = conId[0].AccountId;
          system.debug('####### corr.Contact : ' + corr.ContactId);                  
          system.debug('####### corr.Account : ' + corr.AccountId);          
        }

        // create new case record
        insert corr;
        insertContentVersionsForAttachments(corr.Id);

        newAttachments.clear();
        newAttachments.add(new Attachment());
        
        corr.CAR_Saved__c = true;
        update corr;

        system.debug('####### CASE FINAL SAVE COMPLETE');        
        PageReference thanksPage = Page.ARS_New_Thanks; 
        thanksPage.setRedirect(true); 
        return thanksPage; 
      } catch(DMLException e){
        ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, e.getdmlMessage(0) );
        ApexPages.addMessage(msg);
        return null;
      }
    }
    
    /**
     * @return  `PageReference`
     */
    public PageReference doCancel() {
        PageReference intranet = new PageReference('http://intranet');
        intranet.setRedirect(true); 
        return intranet; 
    }

    private void insertContentVersionsForAttachments(String caseId) {
      List<ContentVersion> contentVersions = new List<ContentVersion>();
      for (Attachment newAtt : newAttachments) {
          if (newAtt.Body!=null) {
              string fileString=EncodingUtil.Base64Encode(newAtt.Body);     

              ContentVersion conVer = new ContentVersion();
              conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
              conVer.PathOnClient = newAtt.Name; // The files name, extension is very important here which will help the file in preview.
              conVer.Title = newAtt.Description; // Display name of the files
              conVer.VersionData = EncodingUtil.base64Decode(fileString); // converting your binary string to Blob
              contentVersions.add(conVer);  
          }
      }
      // check if list has any item on it
      if (!contentVersions.isEmpty()) {
        try {
          // perform DML operation using a list of sobjects
          insert contentVersions;
          // get Ids from the newly inserted records
          Set<Id> contentVersionIds = (new Map<Id, ContentVersion>(contentVersions)).keySet();
          // list to hold new content document link records
          List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
          // get ContentDocumentId for all new records
          for (ContentVersion contentVersion : [SELECT ContentDocumentId FROM ContentVersion WHERE Id IN :contentVersionIds]) {
            ContentDocumentLink conDocLink = new ContentDocumentLink();
            conDocLink.LinkedEntityId = caseId; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
            conDocLink.ContentDocumentId = contentVersion.ContentDocumentId;  //ContentDocumentId Id from ContentVersion
            conDocLink.shareType = 'V';
            // adding new sobject record to list
            contentDocumentLinks.add(conDocLink);
          }
          // check if list has any item on it
          if (!contentDocumentLinks.isEmpty()) {
            // perform DML operation using a list of sobjects
            insert contentDocumentLinks;
          }
        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
        }
      }
    }
}