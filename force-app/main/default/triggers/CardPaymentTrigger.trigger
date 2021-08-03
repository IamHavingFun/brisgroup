trigger CardPaymentTrigger on Income_Card_Payment__c (before insert) {


    if (Trigger.isBefore && Trigger.isInsert){
        CardPaymentTriggerHandler.setPaymentFromConsoleView(Trigger.new);
    }

      
}