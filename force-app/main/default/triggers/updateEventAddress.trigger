/* Trigger to update address on Event with the related contact address if it is left blank on event page.
 * Author - Bhushan Adhikari
 * since - May 2012
 * e-mail :badhikari@innoveer.com    
 *
 */

trigger updateEventAddress on Event (before insert, before update) {
    
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
    
    //Map to store Id prefix and the corresponding sObject Name
    Map<String,String> keyPrefixMap = new Map<String,String>{};
    
    Set<String> keyPrefixSet = gd.keySet();
    //Iterating through set of Objects in the environment to get their keyPrefix,Name and putting them in the keyPrefixMap    
    for(String sObj : keyPrefixSet){
    
       Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
              
       //getting the Name of the SObject
       String tempName = r.getName(); 
       
       //getting the keyPrefix of the sObject
       String tempPrefix = r.getKeyPrefix();
       
       System.debug('Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']');
       //adding the sObject keyPrefix and its corresponding sObject Name to the Map
       keyPrefixMap.put(tempPrefix,tempName);
    }
    
    
    //List to store all contact ids 
    List<Id> EvtCon = new List<Id>();
    
    for(Event e: trigger.new)
    {
        if(e.WhoId!=null){
            String ePrefix = e.WhoId;
            ePrefix = ePrefix.subString(0,3);
            if(keyPrefixMap.get(ePrefix) == 'Contact')
            {
                EvtCon.add(e.whoId);
            }
        }
    }
    system.debug('********** EvtCon : ' + EvtCon);
    List<Event> eventlist=[SELECT id,Address_Line_1__c,Address_Line_2__c,Country__c,County__c,Postcode__c,Town__c,Whoid FROM Event WHERE id IN : Trigger.New];
    system.debug('********** eventlist : ' + eventlist);
    List<contact> con = new List<contact>();
    if(!EvtCon.isEmpty()){
        con = [SELECT Id, Name,Account_Address_Line_1__c,Account_Address_Line_2__c,Account_Country__c,Account_County__c,Account_Postcode__c ,Account_Town__c FROM Contact WHERE ID IN:EvtCon];        system.debug('****************Contact : ' + con);
    }
   
    
    /* Following block of code iterates through list of records in trigger.new , checks for the particular contact in contact list 
       and also checks for the Address fields on event are blank or not, if address is left blank it updates it with the related contact address. */
       
    for(Event e1 : trigger.new)
    {
        for(Contact c : con)
        {
            if(e1.whoId == c.id && (e1.Address_Line_1__c == null && e1.Address_Line_2__c==null && e1.Country__c==null && e1.Town__c==null &&e1.Postcode__c ==null &&e1.County__c == null ))
            {
                e1.Address_Line_1__c = c.Account_Address_Line_1__c;
                e1.Address_Line_2__c = c.Account_Address_Line_2__c;
                e1.Country__c = c.Account_Country__c;
                e1.County_State__c = c.Account_County__c;
                e1.Postcode__c = c.Account_Postcode__c;
                e1.Town__c = c.Account_Town__c;
              
             }
  
         }
     }    
    
}