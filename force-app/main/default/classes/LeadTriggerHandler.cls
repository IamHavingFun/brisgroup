public with sharing class LeadTriggerHandler {
    public LeadTriggerHandler() {}

    public static void updateDivisionfield(List<Lead> records){

        //Declaration 
        Map<id,user> UsrMap=new Map<id,user>([SELECT id,Name,Division__c
        FROM user]); //Creating map of user ids and user record

        for(Lead Ld : records) {  
            //If Lead owner's division is not specified than lead record's division will also blank.  
            if( Ld.Division__c==Null)
            {
                if(Ld.ownerid==Null)
                {
                    Ld.Division__c='';
                }
                else {
                    if(UsrMap.get(Ld.ownerid).Division__c==Null) { 
                        Ld.Division__c='';
                    }//End of if statement
                    else { //If Lead owner's division is specified than lead record's division will be updated by lead owner's 'Division'.  
                        Ld.Division__c=UsrMap.get(Ld.ownerid).Division__c;
                    }//End of else statement               
                } 
            }
        }
    }
}