@istest
public class ECNLineExtensionTest {
  public static Sales_Group__c sg;
  public static Supplier__c sup;
  public static Product__c prod;
  public static ECN__c ecn;
  public static ECN_Line__c newline;
  public static string ECNId;
  public static string ProductId;
  public static string objectName;
  public static string query;

  public static testMethod void Test1() {
      /**** CREATE TEST DATA ****/
      // Create Sales Group
      sg = new Sales_Group__c();
      sg.Key__c = '000000';
      sg.Name = '000000';
      sg.Sales_Group_Name__c = 'Test';
      INSERT sg;
      sg = [SELECT Id, Name, Sales_Group_Name__c from Sales_Group__c WHERE Key__c = '000000' LIMIT 1];
        
      // Create Supplier
      sup = new Supplier__c();
      sup.Key__c = '000000';
      sup.Name = '000000';
      sup.Supplier_Name__c = 'Test';
      INSERT sup;
      sup = [SELECT Id, Name, Supplier_Name__c from Supplier__c WHERE Key__c = '000000' LIMIT 1];
        
      // Create PAS Product record
      prod = new Product__c();
      prod.Long_Part_Description__c = 'Old';
      prod.Short_Part_Description__c = 'Old';
      prod.Lead_Time__c = 100;
      prod.Accounting_Group__c = '0001 Basin Taps';
      prod.BEAB__c = 'Required';
      prod.Case_Quantity__c = 100;
      prod.CHECK__c = 'Y';
      prod.Commodity_Code__c = '00 Contemporary';
      prod.COMC2__c = 'Old';
      prod.INLET__c = 'Old';
      prod.EAN_Number__c = '123451234512345';
      prod.FT1__c = 'Old';
      prod.Fitting_Instructions_Brand__c = 'Bristan';
      prod.FR0_1__c = 100;
      prod.FLOW__c = 100;
      prod.Glass__c = 100;
      prod.Label_Required__c = 'Bristan';
      prod.MSP__c = 100;
      prod.Minimum_Order_Quantity__c = 100;
      prod.Pallet_Quantity__c = 100;
      prod.Paper_Cardboard__c = 100;
      prod.Planner_Code__c = 'Old';
      prod.Plastic__c = 100;
      prod.SYSTM__c = 'Suitable for all plumbing systems';
      prod.Product_Kg__c = 100;
      prod.Product_Classification__c = 'Essential';
      prod.Product_Family__c = '00 Bathroom Taps';
      prod.Product_Finish__c = '00 Chrome Plated';
      prod.Single_Height__c = 100;
      prod.Range__c = '1010 X-TOP';
      prod.RRP_Gross__c = 100;
      prod.Sales_Group__c = sg.Id;
      prod.Sales_Part_Active__c = true;
      prod.TTYPE__c = 'Old';
      prod.Source__c = 'Purchased';
      prod.Supplier__c  = sup.Id;
      prod.TMV2__c = 'Old';
      prod.BEAB_Care_Required__c = 'Required';
      prod.Show_on_Web__c = true;
      prod.Web_Title__c = 'Old';
      prod.Finish_Value__c = 'Old';
      prod.Finish_SKUs__c = 'Old';
      prod.Product_Use__c = 'Basin';
      prod.Sanitaryware_Shape__c = 'Round';
      prod.Variant_Label_1__c = 'Old';
      prod.Variant_SKUs_1__c = 'Old';
      prod.Cost_Delivered__c = 100;
      prod.Cost_in_GBP__c = 100;
      prod.Cost_Delivered_Currency__c = 'GBP';
      prod.Product_Depth_mm__c = 100;
      prod.QC_Sheet_Required__c = 'Yes';
      prod.ROHS__c = 'Required';
      prod.Supplier_Drawing_Required__c = 'Yes';
      prod.Supplier_Etching__c = 'A';
      prod.Supplier_Etching_ID_Marking__c = 'Yes';
      prod.TMV2_Required__c = 'Required';
      prod.Sales_Price_Group__c = '0 - Bristan';
      prod.Customs_Stat_No__c = 'Old';
      prod.Country_of_Origin__c = 'GB - UNITED KINGDOM';
      prod.DIV__c = 'Trade';
      prod.Web_Ready__c = true;        
      prod.Add_to_Website__c = true;  
      prod.Component__c = true;  
      prod.Inventory_Only__c = true;  
      prod.Engineering_Part_Description__c = 'Old';
      prod.Product_Weight_Kg__c = 100;
      prod.Minimum_dynamic_Pressure__c = 100;
      prod.Whats_in_the_Box__c = 'Old';
      prod.Flow_through_Fixed_Head_l_min_FR0_2__c = 100;
      prod.Flow_through_Flow_Limiter_l_min_FR0_2__c = 100;
      prod.Flow_through_Handset_l_min_FR0_2__c = 100;
      prod.Flow_through_Open_Outlet_l_min_FR0_2__c = 100;
      prod.Internal_Length__c = 'Old';
      prod.Height_Max__c = 'Old';
      prod.Surface_Mounted__c = 'Y';
      prod.Recessed__c = 'Y';
      prod.Valve_Centres__c = 100;
      prod.Wall_to_Valve_Centre__c = 100;
      prod.Description__c = 'Old';
      prod.P_P_Range__c = 'Old';
      prod.Accelerator_Title__c = 'Old';
      prod.P_P_New_Price_inc_VAT__c = 100;
      prod.P_P_New_Price_ex_VAT__c = 100;
      prod.EU_REACH_Regulation__c = 'Required';
      prod.UK_Water_Regulation_Compliance__c = 'Required';
      prod.Low_Voltage_Compliant__c = true;
      prod.CE_Approval_Certificate_No__c = 'Old';
      prod.EUTR_Certificate_No__c = 'Old';
      prod.Energy_Label__c = 'Required';
      prod.Product_Code__c = 'Test Product';
      prod.Site__c = '01';
      prod.Status__c = 'Complete';
      INSERT prod;
        
      // Query all PAS product fields
      objectName = 'Product__c';
      query = 'SELECT';
      Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
      for(String s : objectFields.keySet()) {
          query += ' ' + s + ',';
      }
      if (query.subString(query.Length()-1,query.Length()) == ','){
          query = query.subString(0,query.Length()-1);
      }
      query += ' FROM ' + objectName;
      query += ' WHERE Product_Code__c = \'Test Product\' LIMIT 1'; 
      prod = database.query(query);
      ProductId = prod.Id;
      system.debug('*****PRODUCT ID: ' + ProductId);

      // Create ECN
      ecn = new ECN__c();
      ecn.Product__c = prod.Id;
      ecn.Type__c = 'Discontinuation';
      ecn.Notes__c = 'TEST ECN';
      ecn.Area_to_Change__c = 'Discontinuation';
      ecn.Status__c = 'New';
      ecn.Effective_Date__c = date.today();
      ecn.Value_of_Obsolete_Stock__c = 10;
      ecn.Quantity_of_Obsolete_Stock__c = 10;
      ecn.Last_Sales_Date__c = date.today();
      INSERT ecn;
      ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
      ECNId = ecn.Id;      
      system.debug('*****ECN ID: ' + ECNId);
      /**** END CREATE TEST DATA ****/

      Test.startTest();
      // Create ECN Line linked to ECN
      newline = new ECN_Line__c(ECN__c=ECNId);
      // Test constructor for new ECN line
      PageReference pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ApexPages.StandardController ctrl = new ApexPages.StandardController(newline);
      ECNLineExtension ext = new ECNLineExtension(ctrl);
      // Get picklist options for text field
      newline.Field_to_Change__c = 'Short Part Description';
      ext.getOptions();      
      // Get picklist options for boolean field
      newline.Field_to_Change__c = 'Sales Part Active?';
      ext.getOptions();
      // Set new value
      newline.Picklist_Value__c = 'true';
      ext.setNewValue();
      // Test successful save
      ext.save();
      // Test non matching areas - Discontinuation (other)
      newline.Area_to_Change__c = 'Purchasing';  
      ext.save();
      
      // Test constructor for existing ECN line
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      
      // Test save with invalid supersede code
      newline = new ECN_Line__c(ECN__c=ECNId);
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      newline.Field_to_Change__c = 'Supersede Code';
      newline.New_Value__c = 'ABC'; // this is an invalid part code
      ext.save();
      
      // Test non matching areas - Originator
      ecn = new ECN__c();
      ecn.Product__c = prod.Id;
      ecn.Type__c = 'Change';
      ecn.Notes__c = 'TEST ECN';
      ecn.Area_to_Change__c = 'Originator';
      ecn.Status__c = 'New';
      ecn.Effective_Date__c = date.today();
      INSERT ecn;
      ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' LIMIT 1];
      ECNId = ecn.Id; 
      newline = new ECN_Line__c(ECN__c=ECNId);
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      newline.Area_to_Change__c = 'Purchasing';
      ext.save();
      
      // Test non matching areas - Purchasing
      ecn = new ECN__c();
      ecn.Product__c = prod.Id;
      ecn.Type__c = 'Purchasing/Supplier Change';
      ecn.Notes__c = 'TEST ECN';
      ecn.Area_to_Change__c = 'Purchasing';
      ecn.Status__c = 'New';
      ecn.Effective_Date__c = date.today();
      INSERT ecn;
      ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Purchasing/Supplier Change' LIMIT 1];
      ECNId = ecn.Id; 
      newline = new ECN_Line__c(ECN__c=ECNId);
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      newline.Area_to_Change__c = 'Originator';
      ext.save();
      
      // Test non matching areas - Technical
      ecn = new ECN__c();
      ecn.Product__c = prod.Id;
      ecn.Type__c = 'Change';
      ecn.Notes__c = 'TEST ECN';
      ecn.Area_to_Change__c = 'Technical';
      ecn.Status__c = 'New';
      ecn.Effective_Date__c = date.today();
      INSERT ecn;
      ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' and Area_to_Change__c = 'Technical' LIMIT 1];
      ECNId = ecn.Id; 
      newline = new ECN_Line__c(ECN__c=ECNId);
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      newline.Area_to_Change__c = 'Purchasing';
      ext.save();
      
      // Test incorrect ECN status
      ecn = new ECN__c();
      ecn.Product__c = prod.Id;
      ecn.Type__c = 'Change';
      ecn.Notes__c = 'TEST ECN';
      ecn.Area_to_Change__c = 'Sales';
      ecn.Status__c = 'Awaiting Technical Check';
      ecn.Effective_Date__c = date.today();
      INSERT ecn;
      ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' and Area_to_Change__c = 'Sales' LIMIT 1];
      ECNId = ecn.Id; 
      newline = new ECN_Line__c(ECN__c=ECNId);
      pr = new PageReference('/apex/ECNLine');
      Test.setcurrentPage(pr);  
      ctrl = new ApexPages.StandardController(newline);
      ext = new ECNLineExtension(ctrl);
      ext.save();
      
      // Get picklist options for picklist field
      newline.Field_to_Change__c = 'Sales Price Group';
      ext.getOptions();

      Test.stopTest();
  }  
}