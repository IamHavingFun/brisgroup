public without sharing class ARSExtension {
    // Variables
    private ApexPages.StandardController ctrl;
    public Case corr {get;set;}
    public String myCon {set; get;}
    public String myAcc {set; get;}
    public List<Attachment> newAttachments {get; set;}
    public static final Integer NUM_ATTACHMENTS_TO_ADD=5;
    
    public ARSExtension (ApexPages.StandardController controllerParam) {
      // Get correspondence record
      ctrl = controllerParam;
      corr = (Case) ctrl.getRecord();
      newAttachments=new List<Attachment>{new Attachment()};
      for (Integer idx=0; idx<NUM_ATTACHMENTS_TO_ADD-1; idx++)
      {  newAttachments.add(new Attachment());  }
    }
    
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
        // Check attachment sizes BEFORE saving case
        //for (Attachment newAtt : newAttachments)
        //{
        //    if (newAtt.Body!=null)
        //    {
        //        system.debug('####### ATTACHMENT FOUND');
        //        system.debug('####### ATTACHMENT LENGTH: '  + String.valueof(newAtt.BodyLength));
        //        // check attachment size
        //        if(newAtt.BodyLength > 5242880){ 
        //            system.debug('####### ATTACHMENT TOO BIG');          
        //            //maximum attachment size is 5MB.  Show an error
        //            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, 'Incident NOT submitted as file is too big (' + Decimal.valueOf(newAtt.BodyLength/1048576).setScale(1) + ' MB)')); 
        //            return null;
        //        }
        //    }
        //}

        insert corr;
        //ctrl.save();
        //corr = (Case) ctrl.getRecord();        
        // Attachment stuff here
        //List<Attachment> toInsert=new List<Attachment>();
        for (Attachment newAtt : newAttachments)
        {
            if (newAtt.Body!=null)
            {
                //system.debug('####### SAVING ATTACHMENT');
                //newAtt.OwnerId = UserInfo.getUserId();
                //newAtt.parentId=corr.Id;
                //newAtt.IsPrivate = false;
                //toInsert.add(newAtt);
                
                //Blob b=newAtt.Body;
                //req1.setBodyAsBlob(b);
                string fileString=EncodingUtil.Base64Encode(newAtt.Body);     
 
                ContentVersion conVer = new ContentVersion();
                conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
                conVer.PathOnClient = newAtt.Name; // The files name, extension is very important here which will help the file in preview.
                conVer.Title = newAtt.Description; // Display name of the files
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
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
                    system.debug('####### FAILED TO SAVE ATTACHMENT');
                    return null;
                }    
            }
        }
        //try { insert toInsert; }
        //catch (DMLException e) {
        //    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
        //    system.debug('####### FAILED TO SAVE ATTACHMENT');
        //    return null;
        //}
        newAttachments.clear();
        newAttachments.add(new Attachment());
        
        corr.CAR_Saved__c = true;
        update corr;
        //ctrl.save();
        system.debug('####### CASE FINAL SAVE COMPLETE');        
        PageReference thanksPage = Page.ARS_New_Thanks; 
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