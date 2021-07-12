@isTest
public class SabioSfdcSoftphoneUmCuCallsTest {
    private static String name = 'APEX-TEST-12345';
    
    static testMethod void getCallsTest() {
        String output = SabioSfdcSoftphoneUmCuCalls.getCalls();
        System.assertEquals(true, String.isBlank(output));
        String userId = new SabioSfdcSoftphoneUmGetUserInfo().getUserId();
        Contact contact = insertTestContact();
        Boolean output2 = SabioSfdcSoftphoneUmCuCalls.saveCallForContact(name, contact.id, userId, '1382277584', '1382277584', '23456', '34567');
        output = SabioSfdcSoftphoneUmCuCalls.getCalls();
        System.assertEquals(false, String.isBlank(output));
        Calls__c call = [SELECT ID FROM Calls__c WHERE Name = :(name)];
        if (call != null) {
            delete call;
        }
    }
    
    static testMethod void saveCallForContactTest() {
        String userId = new SabioSfdcSoftphoneUmGetUserInfo().getUserId();
        Contact contact = insertTestContact();
        Boolean output = SabioSfdcSoftphoneUmCuCalls.saveCallForContact(name, contact.id, userId, '1382277584', '1382277584', '23456', '34567');
        System.assertEquals(true, output);
        Calls__c call = [SELECT ID FROM Calls__c WHERE Name = :(name)];
        if (call != null) {
            delete call;
        }
    }   

    static testMethod void saveCallForAccountTest() {
        String userId = new SabioSfdcSoftphoneUmGetUserInfo().getUserId();
        Account account = insertTestAccount();
        Boolean output = SabioSfdcSoftphoneUmCuCalls.saveCallForAccount(name, account.id, userId, '1382277584', '1382277584', '23456', '34567');
        System.assertEquals(true, output);
        Calls__c call = [SELECT ID FROM Calls__c WHERE Name = :(name)];
        if (call != null) {
            delete call;
        }
    }
    
    static testMethod void saveCallUnknownTest() {
        Boolean output = SabioSfdcSoftphoneUmCuCalls.saveCallUnknown('12345', null, '', '1382277584', '1382277584', '23456', '34567');
        System.assertEquals(false, output);
        Contact contact = insertTestContact();
        String userId = new SabioSfdcSoftphoneUmGetUserInfo().getUserId();
        Boolean output2 = SabioSfdcSoftphoneUmCuCalls.saveCallUnknown('12345', contact.id, userId, '1382277584', '1382277584', '23456', '34567');
        System.assertEquals(true, output2);
        Calls__c call = [SELECT ID FROM Calls__c WHERE Name = '12345'];
        if (call != null) {
            delete call;
        }
    }
        
    private static Account insertTestAccount() {
        //Account obj = new Account(recordTypeId = queryForPersonRecType());
        //Account obj = new Account(recordTypeId = '012c0000000Cq3k');
        Account obj = new Account(recordTypeId = '012D00000007IS4IAM');        
        obj.firstName = name;
        obj.lastname = name;
        insert obj;
        return obj;
    }
    
    private static Contact insertTestContact() {
        Contact obj = new Contact();
        obj.firstName = name;
        obj.lastname = name;
        insert obj;
        return obj;
    }

    private static Id queryForPersonRecType() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Account;
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();        
        return AccountRecordTypeInfo.get('Person Accounts').getRecordTypeId();
        //return [SELECT ID FROM RecordType WHERE Name = 'Person Accounts'].id;
    }
}