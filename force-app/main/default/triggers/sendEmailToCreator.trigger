/* This trigger is used to send an email notification to task creator when a task is completed by another user.
* Author-Hema Kulkarni
* Since- may 2012
* Email-hkulkarni@innoveer.com
*/

trigger sendEmailToCreator on task(after update)
{
map<id,user> usrMap=new map<id,user>([select id, name, email from user]);//User map to get the email id of users
   list<Messaging.SingleEmailMessage> allMails = new list<Messaging.SingleEmailMessage>();
   for(task t : trigger.new)
   {
      if(Trigger.oldMap.get(t.id).status != null)
      {
          if((t.status != Trigger.oldMap.get(t.id).status) && t.status == 'Completed' && t.Notify_Assignee__c== true) //If status is completed and notify assignee is checked then only a email message is sent to task owner.
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
   
   if(allMails.size() > 0)
   {
       Messaging.sendEmail(allMails); 
   }
}