public class SessionController {

    @AuraEnabled
    public static User getUserDetails() {
        User u = [select Id, Level__c, Profile.Name from User where id=:userinfo.getuserid()];
        return u;
    }
    
    @AuraEnabled
    public static String makePaymentURL(Id orderId) {
        Order__c o = [select Id, Name, Account_Address_Line_1__c, Account_Postcode__c, Account_Town__c,
            Delivery_Email_Address__c, Delivery_First_Name__c, Delivery_Last_Name__c, 
            Card_Payment_Delivery_Address__c, Card_Payment_Delivery_Postcode__c, Card_Payment_Delivery_Town__c, 
            Total_Price__c, Partner_URL__c
            from Order__c where Id = :orderId];
        String url = 'https://test1.smarterpay.com/income-sagepay/default.aspx?' +
            'salesforceconnectionid=' + getSessionID() + '&' +
            'salesforceconnectionurl=' + (String.isBlank(o.Partner_URL__c) ? '' : o.Partner_URL__c) + '&' +
            'softwareversion=4&' +
            'salesforcecardpaymentrecordtype=Standard Card Payment&' +
            'firstsfreferenceobject=Order__c&' +
            'firstsfreferenceobjectname=Order&' +
            'firstsfreferenceid=' + o.Id + '&' +
            'firstsfreferencename=' + o.Name + '&' +
            'billingaddress=' + (String.isBlank(o.Account_Address_Line_1__c) ? '' : o.Account_Address_Line_1__c.escapeHtml4()) + '&' +
            'billingpostcode=' + (String.isBlank(o.Account_Postcode__c) ? '' : o.Account_Postcode__c) + '&' +
            'billingcity=' + (String.isBlank(o.Account_Town__c) ? '' : o.Account_Town__c.escapeHtml4()) + '&' +
            'billingcountrycode=GB&' +
            'billingemail=' + (String.isBlank(o.Delivery_Email_Address__c) ? '' : o.Delivery_Email_Address__c) + '&' +
            'billingfirstname=' + (String.isBlank(o.Delivery_First_Name__c) ? '' : o.Delivery_First_Name__c.escapeHtml4()) + '&' +
            'billingsurname=' + (String.isBlank(o.Delivery_Last_Name__c) ? '' : o.Delivery_Last_Name__c.escapeHtml4()) + '&' +
            'deliveryaddress=' + (String.isBlank(o.Card_Payment_Delivery_Address__c) ? '' : o.Card_Payment_Delivery_Address__c.escapeHtml4()) + '&' +
            'deliverypostcode=' + (String.isBlank(o.Card_Payment_Delivery_Postcode__c) ? '' : o.Card_Payment_Delivery_Postcode__c) + '&' +
            'deliverycity=' + (String.isBlank(o.Card_Payment_Delivery_Town__c) ? '' : o.Card_Payment_Delivery_Town__c.escapeHtml4()) + '&' +
            'deliverycountrycode=GB&' +
            'deliveryemail=' + (String.isBlank(o.Delivery_Email_Address__c) ? '' : o.Delivery_Email_Address__c) + '&' +
            'deliveryfirstname=' + (String.isBlank(o.Delivery_First_Name__c) ? '' : o.Delivery_First_Name__c.escapeHtml4()) + '&' +
            'deliverysurname=' + (String.isBlank(o.Delivery_Last_Name__c) ? '' : o.Delivery_Last_Name__c.escapeHtml4()) + '&' +
            'saleamount=' + String.ValueOf(o.Total_Price__c) + '&' +
            'salecurrencycode=GBP&' +
            'multicurrencymode=false&' +
            'sagepayvendor=bristangroup&' +
            'incomeusername=BRIST&' +
            'paymentreason=Only Payment&' +
            'paymentdescription=' + o.Name + '&' +
            'usebasket=false';
        return url;
    }
    
    @AuraEnabled
    public static String deferredPaymentURL(Id orderId) {
        Order__c o = [select Id, Name, Account_Address_Line_1__c, Account_Postcode__c, Account_Town__c,
            Delivery_Email_Address__c, Delivery_First_Name__c, Delivery_Last_Name__c, 
            Card_Payment_Delivery_Address__c, Card_Payment_Delivery_Postcode__c, Card_Payment_Delivery_Town__c, 
            Total_Price__c, Partner_URL__c
            from Order__c where Id = :orderId];
        String url = 'https://test1.smarterpay.com/income-sagepay/sagepaypreauthdeferredpayment.aspx?' +
            'salesforceconnectionid=' + getSessionID() + '&' +
            'salesforceconnectionurl=' + (String.isBlank(o.Partner_URL__c) ? '' : o.Partner_URL__c) + '&' +
            'softwareversion=4&' +
            'salesforcecardpaymentrecordtype=Standard Card Payment&' +
            'firstsfreferenceobject=Order__c&' +
            'firstsfreferenceobjectname=Order&' +
            'firstsfreferenceid=' + o.Id + '&' +
            'firstsfreferencename=' + o.Name + '&' +
            'billingaddress=' + (String.isBlank(o.Account_Address_Line_1__c) ? '' : o.Account_Address_Line_1__c.escapeHtml4()) + '&' +
            'billingpostcode=' + (String.isBlank(o.Account_Postcode__c) ? '' : o.Account_Postcode__c) + '&' +
            'billingcity=' + (String.isBlank(o.Account_Town__c) ? '' : o.Account_Town__c.escapeHtml4()) + '&' +
            'billingcountrycode=GB&' +
            'billingemail=' + (String.isBlank(o.Delivery_Email_Address__c) ? '' : o.Delivery_Email_Address__c) + '&' +
            'billingfirstname=' + (String.isBlank(o.Delivery_First_Name__c) ? '' : o.Delivery_First_Name__c.escapeHtml4()) + '&' +
            'billingsurname=' + (String.isBlank(o.Delivery_Last_Name__c) ? '' : o.Delivery_Last_Name__c.escapeHtml4()) + '&' +
            'deliveryaddress=' + (String.isBlank(o.Card_Payment_Delivery_Address__c) ? '' : o.Card_Payment_Delivery_Address__c.escapeHtml4()) + '&' +
            'deliverypostcode=' + (String.isBlank(o.Card_Payment_Delivery_Postcode__c) ? '' : o.Card_Payment_Delivery_Postcode__c) + '&' +
            'deliverycity=' + (String.isBlank(o.Card_Payment_Delivery_Town__c) ? '' : o.Card_Payment_Delivery_Town__c.escapeHtml4()) + '&' +
            'deliverycountrycode=GB&' +
            'deliveryemail=' + (String.isBlank(o.Delivery_Email_Address__c) ? '' : o.Delivery_Email_Address__c) + '&' +
            'deliveryfirstname=' + (String.isBlank(o.Delivery_First_Name__c) ? '' : o.Delivery_First_Name__c.escapeHtml4()) + '&' +
            'deliverysurname=' + (String.isBlank(o.Delivery_Last_Name__c) ? '' : o.Delivery_Last_Name__c.escapeHtml4()) + '&' +
            'saleamount=' + String.ValueOf(o.Total_Price__c) + '&' +
            'salecurrencycode=GBP&' +
            'multicurrencymode=false&' +
            'sagepayvendor=bristangroup&' +
            'incomeusername=BRIST&' +
            'paymentreason=Only Payment&' +
            'paymentdescription=' + o.Name + '&' +
            'usebasket=false';
        return url;
    }
    
    @AuraEnabled
    public static String refundURL(Id paymentId) {
        Income_Card_Payment__c o = [select Id, Name, Card_Number_Ending__c, Payment_Description__c, Total_Amount_Taken__c,
            Sagepay_Transaction_ID__c, Sagepay_Security_Key__c, Authorisation_Code__c, Authorisation_Date__c,
            Payment_Is_From_Console_View__c, Partner_URL__c
            from Income_Card_Payment__c where Id = :paymentId];
        String url = 'https://test1.smarterpay.com/income-sagepay/refundvoid.aspx?' +
            'salesforceconnectionid=' + getSessionID() + '&' +
            'salesforceconnectionurl=' + (String.isBlank(o.Partner_URL__c) ? '' : o.Partner_URL__c) + '&' +
            'salesforcepaymentrecordid=' + o.Id + '&' +
            'salesforcepaymentrecordname=' + o.Name + '&' +
            'cardnumber=' + (String.isBlank(o.Card_Number_Ending__c) ? '' : o.Card_Number_Ending__c) + '&' +
            'paymentdescription=' + (String.isBlank(o.Payment_Description__c) ? '' : o.Payment_Description__c) + '&' +
            'originalamount=' + String.ValueOf(o.Total_Amount_Taken__c) + '&' +
            'currency=GBP&' +
            'multicurrencymode=false&' +
            'refundreasonrequired=true&' +
            'RelatedVPSTxId=' + (String.isBlank(o.Sagepay_Transaction_ID__c) ? '' : o.Sagepay_Transaction_ID__c) + '&' +
            'RelatedVendorTxCode=' + o.Name + '&' +
            'RelatedSecurityKey=' + (String.isBlank(o.Sagepay_Security_Key__c) ? '' : o.Sagepay_Security_Key__c) + '&' +
            'RelatedTxAuthNo=' + (String.isBlank(o.Authorisation_Code__c) ? '' : o.Authorisation_Code__c) + '&' +
            'SagepayVendor=bristangroup&' +
            'RefundOnly=false&' +
            'RefundFullAmountOnly=false&' +
            'AuthorisationDate=' + o.Authorisation_Date__c + '&' +
            'paymentisfromconsoleview=' + o.Payment_Is_From_Console_View__c;
        return url;
    }
    
    @AuraEnabled
    public static String releaseURL(Id paymentId) {
        Income_Card_Payment__c o = [select Id, Name, Card_Number_Ending__c, Payment_Description__c, Immediate_Amount__c,
            Sagepay_Transaction_ID__c, Sagepay_Security_Key__c, Authorisation_Code__c, Authorisation_Date__c,
            Payment_Status__c, Transaction_Type__c, Payment_Is_From_Console_View__c, Partner_URL__c
            from Income_Card_Payment__c where Id = :paymentId];
        String url = 'https://test1.smarterpay.com/income-sagepay/sagepaypreauthreleaseabortpayment.aspx?' +
            'salesforceconnectionid=' + getSessionID() + '&' +
            'salesforceconnectionurl=' + (String.isBlank(o.Partner_URL__c) ? '' : o.Partner_URL__c) + '&' +
            'salesforcepaymentrecordid=' + o.Id + '&' +
            'salesforcepaymentrecordname=' + o.Name + '&' +
            'cardnumber=' + (String.isBlank(o.Card_Number_Ending__c) ? '' : o.Card_Number_Ending__c) + '&' +
            'paymentdescription=' + (String.isBlank(o.Payment_Description__c) ? '' : o.Payment_Description__c) + '&' +
            'originalamount=' + String.ValueOf(o.Immediate_Amount__c) + '&' +
            'currency=GBP&' +
            'multicurrencymode=false&' +
            'VendorTxCode=' + o.Name + '&' +
            'VPSTxId=' + (String.isBlank(o.Sagepay_Transaction_ID__c) ? '' : o.Sagepay_Transaction_ID__c) + '&' +
            'SecurityKey=' + (String.isBlank(o.Sagepay_Security_Key__c) ? '' : o.Sagepay_Security_Key__c) + '&' +
            'TxAuthNo=' + (String.isBlank(o.Authorisation_Code__c) ? '' : o.Authorisation_Code__c) + '&' +
            'SagepayVendor=bristangroup&' +
            'AuthorisationDate=' + o.Authorisation_Date__c + '&' +
            'PaymentStatus=' + (String.isBlank(o.Payment_Status__c) ? '' : o.Payment_Status__c) + '&' + 
            'TransactionType=' + (String.isBlank(o.Transaction_Type__c) ? '' : o.Transaction_Type__c) + '&' + 
            'paymentisfromconsoleview=' + o.Payment_Is_From_Console_View__c;
        return url;
    }
    
    public static String getSessionID() {
        PageReference visualforcePage = Page.SessionID;
        String content = '';
        try {
           content = visualforcePage.getContent().toString(); }
        catch (VisualforceException e) {
            content = 'Start_Of_Session_IdxabcdxEnd_Of_Session_Id'; }
        Integer s = content.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
                e = content.indexOf('End_Of_Session_Id');
        return content.substring(s, e);
    }
}