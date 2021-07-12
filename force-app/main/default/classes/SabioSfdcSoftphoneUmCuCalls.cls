global class SabioSfdcSoftphoneUmCuCalls {
    webService static String getCalls() {
        String output = null;
        
        for(Calls__c c : [SELECT Id, Name, Start_Time__c FROM Calls__c LIMIT 1]){
            output = JSON.serialize(c);
        }
    
        return output;
    }
    
    webservice static boolean saveCallForContact(String Name, String Contact, String Agent, String Start_Time, String End_Time, String Extension, String AcdAgentID) {
        Calls__c call = new Calls__C();
        
        call.Name = Name;
       	call.Contact__c = Contact;
        call.Agent__c = Agent;
        call.Start_Time__c = DateTime.newInstance(Long.valueOf(Start_Time));
        call.End_Time__c = DateTime.newInstance(Long.valueOf(End_Time));
        call.Extension__c = Extension;
        call.AcdAgentID__c = AcdAgentID;
        
        insert call;
        
        return true;
    }

    webservice static boolean saveCallForAccount(String Name, String Contact, String Agent, String Start_Time, String End_Time, String Extension, String AcdAgentID) {
        Calls__c call = new Calls__C();

        Contact contactObj = [SELECT Id FROM Contact Where AccountId = :Contact LIMIT 1];
                
        call.Name = Name;
       	call.Contact__c = contactObj.id;
        call.Agent__c = Agent;
        call.Start_Time__c = DateTime.newInstance(Long.valueOf(Start_Time));
        call.End_Time__c = DateTime.newInstance(Long.valueOf(End_Time));
        call.Extension__c = Extension;
        call.AcdAgentID__c = AcdAgentID;
        
        insert call;
        
        return true;
    }
    
    webservice static boolean saveCallUnknown(String Name, String Contact, String Agent, String Start_Time, String End_Time, String Extension, String AcdAgentID) {
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE Id = :(Contact)];
        
        if ((contacts != null) && (contacts.size() > 0)) {
            Calls__c call = new Calls__C();
            
            call.Name = Name;
            call.Contact__c = Contact;
            call.Agent__c = Agent;
            call.Start_Time__c = DateTime.newInstance(Long.valueOf(Start_Time));
            call.End_Time__c = DateTime.newInstance(Long.valueOf(End_Time));
            call.Extension__c = Extension;
            call.AcdAgentID__c = AcdAgentID;
            
            insert call;
            
            return true;
        } else {
        	return false;
        }
    }    
}