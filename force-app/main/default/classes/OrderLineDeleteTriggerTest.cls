@istest(seealldata=true)
public class OrderLineDeleteTriggerTest {

public static Account newacc;
public static Contact ct;
public static Case c;
public static Product2 newprod;
public static Delivery_Term__c newdel;
public static Order__c ord;
public static Order_Line__c ordline;
public static Order_Line__c ordline2;
public static Order_Line__c ordline3;
public static Order_Line__c ordline4;
public static User u;
public static User u2;
public static User u3;
public static User u4;
public static User u5;
public static User u6;
public static Profile p;

static{  
    newacc = new Account(Name = 'Test');
    insert newacc;
    ct = new Contact(LastName = 'Test', FirstName = 'Test', AccountID = newacc.Id, MobilePhone = '0784784994943', Email = 'Test.User@User.com');
    insert ct;
    c = new Case(Subject = 'Test',Description = 'Test',Status = 'New', AccountId = newacc.Id, ContactId = ct.Id);
    insert c;
    newprod = new Product2(Name = 'Test', IsActive = true, Base_Price__c = 100, ProductCode = '1111', Site__c = '01');
    insert newprod;
    newdel = new Delivery_Term__c(Name = 'AM', Value__c = 50, Delivery_Term__c = '67673');
    insert newdel;
    ord = new Order__c(Order_Type__c = 'SC',Ship_Via__c = 'PO', Delivery_Term__c = newdel.Id, Case__c = c.Id, Case_Account__c = newacc.Id);
    insert ord;
    ordline = new Order_Line__c(Order__c = ord.Id, Product__c = newprod.Id, Quantity__c = 1);
    ordline2 = new Order_Line__c(Order__c = ord.Id, Product__c = newprod.Id, Quantity__c = 1);
    ordline3 = new Order_Line__c(Order__c = ord.Id, Product__c = newprod.Id, Quantity__c = 1);
    ordline4 = new Order_Line__c(Order__c = ord.Id, Product__c = newprod.Id, Quantity__c = 1);        
    insert ordline;
    insert ordline2;
    insert ordline3;
    insert ordline4;
    p = [SELECT Id FROM Profile WHERE Name='Service User']; 
    u = [SELECT Id FROM User WHERE ProfileId = :p.Id and IsActive = true LIMIT 1];
    u2 = [SELECT Id, Level__c FROM User WHERE IsActive = true and Level__c = 'Coach' LIMIT 1];
    u4 = [SELECT Id, Level__c FROM User WHERE IsActive = true and Level__c = 'Team Leader' LIMIT 1];
    u5 = [SELECT Id, Level__c FROM User WHERE IsActive = true and Level__c = 'SysAdmin' LIMIT 1];
    u6 = [SELECT Id, Level__c FROM User WHERE IsActive = true and Level__c = 'Head of Customer Service' LIMIT 1];                
}

    static testMethod void OrderLineDeleteTriggerTest(){
        Test.startTest();
            System.runAs(u) {
              try {
                delete ordline;
              }
              catch(Exception e) {}
            }
            system.assert(ordline.Quantity__c == 1);

            System.runAs(u2) {
              try {            
               delete ordline;
              }
              catch(Exception e) {}
            }
            system.assert(u2.Level__c == 'Coach');
            
            System.runAs(u4) {
              try {            
               delete ordline2;
              }
              catch(Exception e) {}
            }
            system.assert(u4.Level__c == 'Team Leader');
            
            System.runAs(u6) {
              try {            
               delete ordline3;
              }
              catch(Exception e) {}
            }
            system.assert(u6.Level__c == 'Head of Customer Service');
            
            System.runAs(u5) {
              try {            
               delete ordline4;
              }
              catch(Exception e) {}
            }
            system.assert(u5.Level__c == 'SysAdmin');                                                
        Test.stopTest();        
    }
}