/**
 * @author  PolSource
 */

public with sharing class TaskTriggerHandler {
    
    public TaskTriggerHandler() {}

    public static void sendEmailToCreator(List<Task> oldRecords, List<Task> newRecords){
        map<id,user> usrMap=new map<id,user>([select id, name, email from user]);//User map to get the email id of users
        list<Messaging.SingleEmailMessage> allMails = new list<Messaging.SingleEmailMessage>();
        for(task t : newRecords)
        {
            for(Task tOld : oldRecords){
                if(t.Id == tOld.Id && tOld.Status != null){

                    if((t.status != tOld.status) && t.status == 'Completed' && t.Notify_Assignee__c== true) //If status is completed and notify assignee is checked then only a email message is sent to task owner.
                    {
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                        
                        String[] toAddresses = new String[] {usrMap.get(t.createdbyid).email}; 
                        system.debug('************************************** toAddresses '+ toAddresses);
                        mail.setToAddresses(toAddresses);             
                        mail.setSaveAsActivity(False); 
                        mail.setsubject(t.Subject);
                        mail.setPlainTextBody('The Task '  + ' assigned to ' + usrMap.get(t.ownerid ).name + ' has been completed.'); 
                        allMails.add(mail);
                        
                    }

                }
            }
        }
        
        if(allMails.size() > 0)
        {
            Messaging.sendEmail(allMails); 
        }
    }
}