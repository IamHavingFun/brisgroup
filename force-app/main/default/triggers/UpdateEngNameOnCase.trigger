trigger UpdateEngNameOnCase on Engineer_Work_Order__c (after update) {

  Set<id> caseId=new Set<id>();
  Map<Id,case> caseMap=new Map<Id,case>();  
  Set<string> caseSet = new Set<string>();
  List<case> updateThisCase = new List<case>();
        
  for(Engineer_Work_Order__c WO :trigger.new) 
  {
      caseId.add(WO.Case__c);// Add case id to set
  }
  
  for(Case CS :[SELECT Id,CaseNumber,IFS_Eng_Name__c, Service_Agent__c, WO_Status__c FROM Case WHERE Id in:caseId])
  {
    caseMap.put(CS.id,CS); // Adding case to map
  }
  
  for(Engineer_Work_Order__c WO1 :trigger.new)
  {
    if(caseMap.containsKey(WO1.Case__c)) //Checking Map of Case if it contains the Case Id
    {  
      case CS1 =  caseMap.get(WO1.Case__c); //Getting the Case to be updated into a variable
      system.debug('**** CS1.id =' + CS1.Id);
      if(WO1.Assigned_engineer__c != null)
      {
        system.debug('**** WO1.Assigned_Engineer__c =' + WO1.Assigned_Engineer__c); 
        user US1 = [SELECT Name from User where Id = :WO1.Assigned_engineer__c];
        system.debug('**** US1.Name =' + US1.Name);        
        CS1.IFS_Eng_Name__c = US1.Name; //WO1.Assigned_Engineer__r.Name; //Update the field
        CS1.Service_Agent__c = null;
        system.debug('**** IFS_Eng_Name Updated');        
      }
      else
      {
        if(WO1.Service_Agent__c != null)
        {
          system.debug('**** WO1.Assigned_Engineer__c =' + WO1.Service_Agent__c); 
          CS1.Service_Agent__c = WO1.Service_Agent__c; //WO1.Assigned_Engineer__r.Name; //Update the field
          CS1.IFS_Eng_Name__c = null;
          system.debug('**** IFS_Eng_Name Updated');          
        }
        else
        { 
          CS1.IFS_Eng_Name__c = null;
          CS1.Service_Agent__c = null;          
        }  
      }
      CS1.WO_Status__c = WO1.Status__c;
      if(!caseSet.contains(WO1.Case__c)) //If the list of Cases is not containing the Case Id
      {            
        caseSet.add(WO1.Case__c); // Add it to the list of Cases
        updateThisCase.add(CS1); // Add to the list of Cases which needs to be updated
      }
    } 
  } 
  
  if(!updateThisCase.isEmpty())// If list of updating case is not empty
  {
    try {
      update updateThisCase; // Updating Case
      system.debug('**** Case Updated');        
    }
    Catch(Exception e){}
  }
}