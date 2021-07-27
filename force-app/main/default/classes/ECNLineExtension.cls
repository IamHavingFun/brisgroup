/**
 * @author PolSource
 */
public with sharing class ECNLineExtension{
    public ECN_Line__c line {get; set;}
    public ECN__c ecn {get; set;}
    public string area {get; set;}
    public string type {get; set;}
    public string ecnStatus {get; set;}
    public boolean areaOK {get; set;}

    /**
     * @param controller StandardController objects reference the pre-built Visualforce controllers provided by Salesforce
     */
    public ECNLineExtension(ApexPages.StandardController controller){
        line = (ECN_Line__c) controller.getrecord();
        Id recordId = controller.getId();
        if(recordId == null) {
            //  line = new ECN_Line__c();
            ecn = [SELECT Id, Area_to_Change__c, Status__c, Type__c FROM ECN__c WHERE Id = :line.ECN__c];
            area = ecn.Area_to_Change__c;
            line.Area_to_Change__c = ecn.Area_to_Change__c;
            type = ecn.Type__c;
            line.Type__c = ecn.Type__c;
            ecnStatus = ecn.Status__c;
        } else {
            line = [SELECT Id, ECN__c, ECN__r.Area_to_Change__c, ECN__r.Status__c, ECN__r.Type__c, Type__c, Name, Area_to_Change__c, Field_to_Change__c, Old_Value__c, Picklist_Value__c, New_Value__c FROM ECN_Line__c WHERE Id =:recordId];
            area = line.ECN__r.Area_to_Change__c;
            type = line.ECN__r.Type__c;
            ecnStatus = line.ECN__r.Status__c;
        }
    }
    
    /**
     * 
     * @return  `List<SelectOption>`
     */
    public List<SelectOption> getOptions() {
        Map<String, Schema.SObjectField> M = Schema.SObjectType.Product__c.fields.getMap();
        List<SelectOption> options = new List<SelectOption>();
        for(String key : M.KeySet()) {
            if(line.Field_to_Change__c == M.get(key).getDescribe().getLabel()) {
                Schema.DescribeFieldResult fieldResult = M.get(key).getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                options.add(new SelectOption('Please select','Please select'));
                line.New_Value__c = '';
                for(Schema.PicklistEntry f : ple) {
                    options.add(new SelectOption(f.getLabel(), f.getLabel()));
                }
                Schema.DisplayType fielddataType = M.get(key).getDescribe().getType();
                if(fielddataType == Schema.DisplayType.Boolean) {
                    options.add(new SelectOption('true','true'));
                    options.add(new SelectOption('false','false'));
                }
            }
        }
        return options;
    }
    
    /**
     * 
     */
    public void setNewValue() {
        line.New_Value__c = line.Picklist_Value__c;
    }
    
    /**
     * @return  `PageReference`
     */
    public PageReference save() {
        areaOK = true;
        if ((area == 'Originator' || area == 'Bristan Website Data' || area == 'Heritage Website Data' || area == 'Price' || area == 'Characteristics (Originator)') && 
            (line.Area_to_Change__c != 'Originator' && line.Area_to_Change__c != 'Bristan Website Data' && line.Area_to_Change__c != 'Heritage Website Data' && line.Area_to_Change__c != 'Price' && line.Area_to_Change__c != 'Characteristics (Originator)')) {
            areaOk = false;
        } else if ((area == 'Purchasing' || area == 'QC Sheet Details') && (line.Area_to_Change__c != 'Purchasing' && line.Area_to_Change__c != 'QC Sheet Details')) {
            areaOK = false;
        } else if ((area == 'Technical' || area == 'Characteristics (Technical)') && (line.Area_to_Change__c != 'Technical' && line.Area_to_Change__c != 'Characteristics (Technical)')) {
            areaOK = false;
        } else if (line.Area_to_Change__c != area) {
            areaOK = false;
        }
        if (ecnStatus != 'New' && ecnStatus != 'Rejected' && ecnStatus != 'Awaiting Finance Approval') {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'ECN Lines cannot be added to an in progress or complete ECN!'));
            return null;
        } else if(!areaOK) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'The \'Area to Change\' field cannot be changed!'));
            return null;
        } else if(line.Field_to_Change__c == 'Supersede Code') {
            String sCode = line.New_Value__c;
            String query = 'SELECT count() FROM Product__c WHERE Product_Code__c = :sCode';
            integer count = Database.countQuery(query);
            if (count <= 0) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Error: The Supercede Code you have entered does not exist as a product in PAS.'));
                return null;
            }
        }
        upsert line;
        return new PageReference('/' + line.ECN__c);
    }
}