/* This class is called when the 'Apply Discount' button is press on the Quote detail page.
 * The Discount_Perc__c field is retrieved as is the IFS_Price__c and the discount price is then calculated.
 * The discounted price is added to the UnitPrice field.
 * 
 * Author - Steve Mason
 * Since - November 2012
 * E-mail - smason@bristan.com
 */

global class QuoteApplyDiscounts{
    //List to hold all the QuoteLineItems related to an Quote
    public List<QuoteLineItem> masterList = new List<QuoteLineItem>();
    public decimal disc;
    
    //Will be called from Button "Apply Discount" on Quote Detail Page
    webservice static void createList(Id qtId)
    {
        QuoteApplyDiscounts qup = new  QuoteApplyDiscounts();
        try{
            qup.createLists(qtId);
            qup.updateIfsPrice(qtId);
            }
        catch(Exception e){
        system.debug(e);
        }    
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id qId)
    {
        masterList = [SELECT Id, PricebookEntry.Product2.Name , PriceBookEntry.Product2.Site__c, QuoteId, IFS_Price__c, UnitPrice FROM QuoteLineItem WHERE QuoteId =: qId];         
        disc = [SELECT Discount_Perc__c FROM Quote WHERE Id =: qId].Discount_Perc__c;
    }
    
    //Method to Update the Prices of Quote Line Item
    public void updateIfsPrice(Id qId)
    {
        List<QuoteLineItem> updtIfsPrice = new List<QuoteLineItem>();
        for(QuoteLineItem qli : masterList)
        {
            qli.UnitPrice = qli.IFS_Price__c * ((100-disc)/100);
            updtIfsPrice.add(qli);
            System.debug('****BOOM****');
        }
        try{
            if(!updtIfsPrice.isEmpty()){
                update updtIfsPrice; 
            }
        }
        catch(Exception e){
            System.debug(e);
        }
    }
}