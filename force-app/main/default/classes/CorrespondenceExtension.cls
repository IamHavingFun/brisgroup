public with sharing class CorrespondenceExtension {
    // Variables
    private ApexPages.StandardController ctrl;
    public Correspondence__c corr {get;set;}
    public Id con {get;set;}
    public Id acc {get;set;}
    public string contactName {get;set;}
    public string contactFirstName {get;set;}    
    public string contactLastName {get;set;}    
    public string site {get;set;}     
    public string selectedRecTypeId{get;set;}
    public string selectedRecTypeName{get;set;} 
    public string selectedLimit{get;set;}     
    public List<Account> accountRecord{get;set;}    
    // Create formatted date for use in strings
    Datetime myDate = Datetime.now();
    String dateOutput = myDate.format('dd/MM/yyyy');  
    
    public CorrespondenceExtension (ApexPages.StandardController controllerParam) {
      // Get correspondence record
      ctrl = controllerParam;
      corr = (Correspondence__c) ctrl.getRecord();
      // Get contact Id
      con = corr.Contact__c;
      site = corr.Site__c;
      // Get contact and account fields
      for( Contact cn: [Select Id, Name, FirstName, LastName, AccountId from Contact where Id = :con limit 1] ) {
        contactName = cn.Name;
        contactFirstName = cn.FirstName;
        contactLastName = cn.LastName;
        acc = cn.AccountId;
      } 
    }
    
    public PageReference customsave() {
      // Any custom save routines can go here
      return ctrl.save();
    }
    
    
    public List<SelectOption> getRecType() {
      // Get record type
      List<SelectOption> recOptions= new List<SelectOption>();
      selectedRecTypeId = ApexPages.currentPage().getParameters().get('RecordType');
      for( RecordType rec: [select Id,name from RecordType where Id=:selectedRecTypeId limit 1] ) {
          selectedRecTypeName = rec.name;
          recOptions.add( new SelectOption(rec.Id,rec.name));
      }
      corr.Salutation__c = 'Dear ' + contactName;
      corr.Footer__c = 'Please find above your discounted prices excluding VAT. We look forward to receiving your order. Please note, however, small orders may be subject to an additional carriage charge.';
      corr.Content__c = 'Thank you for your enquiry on ' + dateOutput +'. Please find your quote below:\r\n\r\n';
      corr.Content_Formatted__c = 'Thank you for your enquiry on ' + dateOutput +'. Please find your quote below:<br /><br />';        
      return recOptions;
    }
}