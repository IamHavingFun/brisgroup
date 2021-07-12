public with sharing class Constants {

public static Spares_Revision__c[] spareRevisions;

static{
	spareRevisions = [select Master_Product__c, Product_Descr__c, Product_Code__c, Revision__c, Name, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r) from Spares_Revision__c Limit :Limits.getLimitQueryRows()];
}
}