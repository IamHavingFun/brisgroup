public without sharing class CARExtension {
    // Variables
    private ApexPages.StandardController ctrl;
    public Case corr {get;set;}
    public String myCon {set; get;}
    public String myAcc {set; get;}
    public Attachment attachment {
      get {
        if (attachment == null)
          attachment = new Attachment();
        return attachment;
      }
      set;
    }    

    public CARExtension (ApexPages.StandardController controllerParam) {
      // Get correspondence record
      ctrl = controllerParam;
      corr = (Case) ctrl.getRecord();
    }
    
    public PageReference customsave() {
      // Any custom save routines can go here
      try {
        corr.Reason = 'BIRS';
        corr.Origin = 'BIRS';        
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
        // Check attachment size BEFORE saving case
        //if(attachment.Name != null && attachment.Body != null) {
        //  system.debug('####### ATTACHMENT FOUND');
        //  system.debug('####### ATTACHMENT LENGTH: '  + String.valueof(attachment.BodyLength));
          // check attachment size
        //  if(attachment.BodyLength > 5242880){ 
        //    system.debug('####### ATTACHMENT TOO BIG');          
            //maximum attachment size is 5MB.  Show an error
        //    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, 'Incident NOT submitted as file is too big (' + Decimal.valueOf(attachment.BodyLength/1048576).setScale(1) + ' MB): ' + attachment.Name)); 
        //    return null;
        //  }
        //}
        system.debug('####### BEFORE FIRST SAVE');
        insert corr;
        //ctrl.save();
        system.debug('####### AFTER FIRST SAVE');
        //corr = (Case) ctrl.getRecord();       
        system.debug('####### AFTER FETCH RECORD'); 
        // Attachment stuff here
        // check attachment added
        system.debug('####### BEFORE ATTACHMENT CHECK');  
        if(attachment.Name != null && attachment.Body != null) {
          //try {
          //  system.debug('####### SAVING ATTACHMENT');
          //  attachment.OwnerId = UserInfo.getUserId();
          //  attachment.ParentId = corr.Id;
          //  attachment.IsPrivate = false;
          //  insert attachment;
          //} catch (DMLException e) {
          //  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
          //  system.debug('####### FAILED TO SAVE ATTACHMENT');
          //  return null;
          string fileString=EncodingUtil.Base64Encode(attachment.Body);     
 
          ContentVersion conVer = new ContentVersion();
          conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
          conVer.PathOnClient = attachment.Name; // The files name, extension is very important here which will help the file in preview.
          conVer.Title = attachment.Description; // Display name of the files
          conVer.VersionData = EncodingUtil.base64Decode(fileString); // converting your binary string to Blob
          try {
              insert conVer;    //Insert ContentVersion
          }
          catch(DMLException e) {
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
              system.debug('####### FAILED TO SAVE ATTACHMENT');
              return null;
          } 
          // First get the Content Document Id from ContentVersion Object
          Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
          //create ContentDocumentLink  record 
          ContentDocumentLink conDocLink = New ContentDocumentLink();
          conDocLink.LinkedEntityId = corr.Id; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
          conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
          conDocLink.shareType = 'V';
          try {
              insert conDocLink; 
          }
          catch(DMLException e) {
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment (document link)!'));
              system.debug('####### FAILED TO SAVE ATTACHMENT');
              return null;
          }  
          attachment = new Attachment(); 
         }
        corr.CAR_Saved__c = true;
        system.debug('####### BEFORE FINAL SAVE');  
        update corr;
        //ctrl.save();
        system.debug('####### CASE FINAL SAVE COMPLETE');        
        PageReference thanksPage = Page.CAR_Thanks; 
        thanksPage.setRedirect(true); 
        return thanksPage; 
      }
      catch(DMLException e){
        ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, e.getdmlMessage(0) );
        ApexPages.addMessage(msg);
        return null;
      } 

    }
    
    public PageReference doCancel() {
        PageReference intranet = new PageReference('http://intranet');
        intranet.setRedirect(true); 
        return intranet; 
    }
}