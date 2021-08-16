public without sharing class TestDataCreation {

public static Account CreateAccount(String accName){
    Account newacc = new Account(Name = accName);
    insert newacc;

    return newacc;
}

public static Contact createContact(String fName, String lName, Id accId){
    Contact ct = new Contact(LastName = lName, FirstName = fName, AccountID = accId, MobilePhone = '0784784994943', Email = 'Test.User@User.com');
    insert ct;
    
    return ct;
}

public static Case CreateCase(String name,ID accId,ID contactID){
    Case c = new Case(Subject = name,Description = 'Test',Status = 'New', AccountId = accId, ContactId = contactID);
    insert c;
    
    return c;
}

public static Application_Config__c CreateAppConfig(String Nm, String val) {
    Application_Config__c ac = new Application_Config__c(Name=Nm, Value__c = val);
    insert ac;
    return ac;
}

public static Product_Revision__c CreateProductRevision(String revName, String code, String rev, ID prod){
    Product_Revision__c newpRev = new Product_Revision__c(Name = revName, Product_Code__c = code, Revision__c = rev, Master_Product__c = prod);
    insert newpRev;

    return newpRev;
}

public static Catalogue_Junction__c CreateCatalogueJunction(ID prodRev, ID spr){
    Catalogue_Junction__c newCat = new Catalogue_Junction__c(Product_Revision__c = prodRev, Spares_Revision__c = spr, Junction_Key__c = 'XXXX');
    insert newCat;

    return newCat;
}

public static Product2 CreateProduct(String prodName){
    Product2 newprod = new Product2(Name = prodName, IsActive = true, Base_Price__c = 100, ProductCode = '1111', Site__c = '01');
    insert newprod;

    return newprod;
}

public static Spares_Revision__c CreateSparesRevision(String spName, String code, String rev, ID prod){
    Spares_Revision__c newsp = new Spares_Revision__c(Name = spName, Product_Code__c = code, Revision__c = rev, Master_Product__c = prod);
    insert newsp;

    return newsp;
}

public static Delivery_Term__c CreateDeliveryTermPST(){
    Delivery_Term__c newdel = new Delivery_Term__c(Name = 'PST', Value__c = 50, Delivery_Term__c = '6767');
    insert newdel;

    return newdel;
}

public static Delivery_Term__c CreateDeliveryTerm(){
    Delivery_Term__c newdel = new Delivery_Term__c(Name = 'AM', Value__c = 50, Delivery_Term__c = '67673');
    insert newdel;

    return newdel;
}

public static EmailTemplate CreateEmailTemplate(String tmplName, String html){
    EmailTemplate newTmpl = new EmailTemplate(Name = tmplName, HtmlValue = html, DeveloperName = 'Test84845', folderid = [select Id from Folder where Name != 'Shared Documents' limit 1].id, TemplateType = 'text');
    insert newTmpl;

    return newTmpl;
}

}