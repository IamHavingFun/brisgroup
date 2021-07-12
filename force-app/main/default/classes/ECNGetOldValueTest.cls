@isTest
public class ECNGetOldValueTest {

public static Sales_Group__c sg;
public static Supplier__c sup;
public static Product__c prod;
public static ECN__c ecn;
public static ECN_Line__c newline;
public static User u;
public static List<ECN_Line__c> ECNLineList = new List<ECN_Line__c>();
public static string ECNId;  //
public static string ProductId; //
public static string objectName; //
public static string query; //

    @TestSetup static void Setup() {
        // Create PAS User
        u = CreatePASUser();
        
        // Create related records        
        System.runAs ( new User(Id = UserInfo.getUserId()) ) {          
            // Create Sales Group
            sg = new Sales_Group__c();
            sg.Key__c = '000000';
            sg.Name = '000000';
            sg.Sales_Group_Name__c = 'Test';
            INSERT sg;
        
            // Create Supplier
            sup = new Supplier__c();
            sup.Key__c = '000000';
            sup.Name = '000000';
            sup.Supplier_Name__c = 'Test';
            INSERT sup;
        }
        
        // Create Product
        System.runAs (u) {  
            // Create PAS Product record
            prod = new Product__c();
            prod.Long_Part_Description__c = 'Old';
            prod.Short_Part_Description__c = 'Old';
            prod.Lead_Time__c = 100;
            prod.Additional_Comment_and_Information__c = 'Old';
            prod.Accounting_Group__c = '0001 Basin Taps';
            prod.BEAB__c = 'Required';
            prod.BEABC__c = 'Required';        
            prod.Case_Quantity__c = 100;
            prod.CE_Marking__c = 'Required';
            prod.CHECK__c = 'Y';
            prod.Commodity_Code__c = '00 Contemporary';
            prod.COMC2__c = 'Old';
            prod.INLET__c = 'Old';
            prod.OUTLT__c = 'Old';
            prod.MOUNT__c = 'Deck';
            prod.DFLOW__c = 'Single';
            prod.EAN_Number__c = '123451234512345';
            prod.FT1__c = 'Old';
            prod.FT10__c = 'Old';
            prod.FT11__c = 'Old';
            prod.FT2__c = 'Old';
            prod.FT3__c = 'Old';
            prod.FT4__c = 'Old';
            prod.FT5__c = 'Old';
            prod.FT6__c = 'Old';
            prod.FT7__c = 'Old';
            prod.FT8__c = 'Old';
            prod.FT9__c = 'Old';
            prod.Fitting_Instructions_Brand__c = 'Bristan';
            prod.FR0_1__c = 100;
            prod.FR0_2__c = 100;
            prod.FR0_5__c = 100;
            prod.FR1_0__c = 100;
            prod.FR2_0__c = 100;
            prod.FR3_0__c = 100;
            prod.FR4_0__c = 100;
            prod.FR5_0__c = 100;
            prod.FLOW__c = 100;
            prod.Glass__c = 100;
            prod.Guarantee__c = '0';
            prod.HEAL__c = 'Y';
            prod.HOSP__c = 'Y';
            prod.ISO__c = 'Y';
            prod.Label_Required__c = 'Bristan';
            prod.HAND__c = 'Left';
            prod.MANTH__c = 'Manual';
            prod.Manufactured_Structure__c = 'Old';
            prod.MDP__c = 100;
            prod.MXHOT__c = 100;
            prod.MSP__c = 100;
            prod.Minimum_Order_Quantity__c = 100;
            prod.PRJCT__c = 'Old';
            prod.PRJYR__c = 'Old';
            prod.CONTS__c = 10;
            prod.Other_Materials__c = 'Old';
            prod.Own_Label__c = 'Yes';
            prod.Packaging_Specification__c = 'Boxed';
            prod.Pallet_Quantity__c = 100;
            prod.Paper_Cardboard__c = 100;
            prod.Parent_Products__c = 'Old';
            prod.PSHUT__c = 'Y';
            prod.Planner_Code__c = 'Old';
            prod.Plastic__c = 100;
            prod.SYSTM__c = 'Suitable for all plumbing systems';
            prod.Product_Kg__c = 100;
            prod.Product_Classification__c = 'Essential';
            prod.Product_Family__c = '00 Bathroom Taps';
            prod.Product_Finish__c = '00 Chrome Plated';
            prod.Single_Height__c = 100;
            prod.Single_Length__c = 100;
            prod.Single_Width__c = 100;
            prod.PTYPE__c = 'Old';
            prod.Project_No__c = 'Old';
            prod.Range__c = '1010 X-TOP';
            prod.RRP_Gross__c = 100;
            prod.RUB__c = 'Y';
            prod.Sales_Group__c = sg.Id;
            prod.Sales_Part_Active__c = true;
            prod.TTYPE__c = 'Old';
            prod.Source__c = 'Purchased';
            prod.SPLES__c = 'Y';
            prod.Supplier__c  = sup.Id;
            prod.TMV2__c = 'Old';
            prod.TMV3__c = 'Old';
            prod.VTYPE__c = 'Isolation Valve';
            prod.WEEE__c = 'Not Required';
            prod.Water_Label_Scheme_WEPLS__c = 'Required';
            prod.WFLOW__c = 100;
            prod.Wood__c = 100;
            prod.WRAS__c = 'Old';
            prod.BEAB_Care_Required__c = 'Required';
            prod.BEAB_Control_Required__c = 'Required';
            prod.Low_Voltage__c = 'Required';
            prod.EMC_Directive__c = 'Required';
            prod.RED_Directive__c = 'Required';
            prod.ECO_Design__c = 'Required';
            prod.EU_Timber_Regulations__c = 'Required';
            prod.Show_on_Web__c = true;
            prod.Web_Title__c = 'Old';
            prod.Web_Short_Title__c = 'Old';
            prod.Web_Variant_Description__c = 'Old';
            prod.Web_Additional_Information__c = 'Old';
            prod.Wishlist_Description__c = 'Old';
            prod.Finish_Value__c = 'Old';
            prod.Finish_SKUs__c = 'Old';
            prod.Size_Value__c = 'Old';
            prod.Size_SKUs__c = 'Old';
            prod.Height_Value__c = 'Old';
            prod.Height_SKUs__c = 'Old';
            prod.Taphole_Value__c = 'Old';
            prod.Taphole_SKUs__c = 'Old';
            prod.Hinge_Finish_Value__c = 'Old';
            prod.Hinge_Finish_SKUs__c = 'Old';
            prod.Hinge_Function_Value__c = 'Old';
            prod.Hinge_Function_SKUs__c = 'Old';
            prod.Left_Right_Handed_Value__c = 'Old';
            prod.Left_Right_Handed_SKUs__c = 'Old';
            prod.Required_Products_Search__c = 'Old';
            prod.Related_Products_Search__c = 'Old';
            prod.Optional_Products_Search__c = 'Old';
            prod.Cross_Sell_Products_Search__c = 'Old';
            prod.Water_Label__c = 'ERC 3.5 Flush';
            prod.Water_Capacity__c  = 100;
            prod.Flush_Volume__c = 100;
            prod.Product_Use__c = 'Basin';
            prod.Sanitaryware_Shape__c = 'Round';
            prod.Matching_Products__c = 'Y';
            prod.Easyfit__c = 'Y';
            prod.Shower_Head_Type__c = 'Adjustable';
            prod.Valve_Control_Type__c = 'Exposed';
            prod.Handle_Shape__c = 'Round';
            prod.Power_Rating__c = '8.5kW (Standard)';
            prod.Handset_Type__c = 'Single Mode';
            prod.Safety__c = 'Thermostatic';
            prod.Sector__c = 'Social Housing';
            prod.What_Style__c = 'Hotel';
            prod.Sink_Shape__c = 'Round';
            prod.TMV2_Web__c = 'Y';
            prod.TMV3_Web__c = 'Y';
            prod.DO8__c = 'Y';
            prod.LANTAC__c = 'Y';
            prod.Variant_Label_1__c = 'Old';
            prod.Variant_SKUs_1__c = 'Old';
            prod.Variant_Value_1__c = 'Old';
            prod.Variant_Label_2__c = 'Old';
            prod.Variant_SKUs_2__c = 'Old';
            prod.Variant_Value_2__c = 'Old';
            prod.Variant_Label_3__c = 'Old';
            prod.Variant_SKUs_3__c = 'Old';
            prod.Variant_Value_3__c = 'Old';
            prod.Variant_Label_4__c = 'Old';
            prod.Variant_SKUs_4__c = 'Old';
            prod.Variant_Value_4__c = 'Old';
            prod.Variant_Label_5__c = 'Old';
            prod.Variant_SKUs_5__c = 'Old';
            prod.Variant_Value_5__c = 'Old';
            prod.Cost_Delivered__c = 100;
            prod.Cost_in_GBP__c = 100;
            prod.Cost_Delivered_Currency__c = 'GBP';
            prod.Product_Depth_mm__c = 100;
            prod.Product_Height_mm__c = 100;
            prod.Product_Width_mm__c = 100;
            prod.Riser_Length_mm__c = 100;
            prod.Spout_Height_mm__c = 100;
            prod.QC_Sheet_Required__c = 'Yes';
            prod.ROHS__c = 'Required';
            prod.Supplier_Drawing_Required__c = 'Yes';
            prod.Supplier_Etching__c = 'A';
            prod.Supplier_Etching_ID_Marking__c = 'Yes';
            prod.Technical_Construction_File_Required__c = 'Yes';
            prod.Technical_Data_Sheet_Required__c = 'Yes';
            prod.Test_Report_Required__c = 'Yes';
            prod.TMV2_Required__c = 'Required';
            prod.TMV3_Required__c = 'Required';
            prod.WEEE_Required__c = 'Required';
            prod.WRAS_Approval_Required__c = 'Required';
            prod.Supersede_Code__c = 'Old';
            prod.Sales_Price_Group__c = '0 - Bristan';
            prod.Video_Content_1__c = 'Old';
            prod.Video_Content_2__c = 'Old';
            prod.Video_Content_3__c = 'Old';
            prod.USP_Icon_1__c = 'Old';
            prod.USP_Icon_2__c = 'Old';
            prod.USP_Icon_3__c = 'Old';
            prod.USP_Icon_4__c = 'Old';
            prod.USP_Icon_5__c = 'Old';
            prod.USP_Icon_6__c = 'Old';
            prod.USP_Icon_7__c = 'Old';        
            prod.USP_Icon_8__c = 'Old';       
            prod.USP_Icon_9__c = 'Old';       
            prod.USP_Icon_10__c = 'Old';       
            prod.USP_Icon_1_Description__c = 'Old';
            prod.USP_Icon_2_Description__c = 'Old';
            prod.USP_Icon_3_Description__c = 'Old';
            prod.USP_Icon_4_Description__c = 'Old';
            prod.USP_Icon_5_Description__c = 'Old';
            prod.USP_Icon_6_Description__c = 'Old';
            prod.USP_Icon_7_Description__c = 'Old';        
            prod.USP_Icon_8_Description__c = 'Old';        
            prod.USP_Icon_9_Description__c = 'Old';        
            prod.USP_Icon_10_Description__c = 'Old';        
            prod.Customs_Stat_No__c = 'Old';
            prod.Country_of_Origin__c = 'GB - UNITED KINGDOM';
            prod.FT12__c = 'Old';
            prod.FT13__c = 'Old';
            prod.FT14__c = 'Old';
            prod.Web_Tap_Holes__c = 'Old';
            prod.Commercial_Product__c = 'N';
            prod.Spares_Category__c = 'Old';
            prod.Web_Finish__c = 'Old';
            prod.Hero_Copy__c = 'Old';        
            prod.Product_Type__c = 'Full Product';
            prod.Web_Range__c = 'Old';
            prod.DIV__c = 'Trade';
            prod.Heat_and_Plumb_URL__c = 'test.bristan.com';
            prod.Victorian_URL__c = 'test.bristan.com';
            prod.Tapstore_URL__c = 'test.bristan.com';
            prod.Trading_Depot_URL__c = 'test.bristan.com';   
            prod.BIM__c = true;
            prod.NBS_Specification__c = true;    
            prod.Web_Ready__c = true;        
            prod.Add_to_Website__c = true;  
            prod.Component__c = true;  
            prod.Inventory_Only__c = true;  
            prod.Engineering_Part_Description__c = 'Old';
            prod.Product_Weight_Kg__c = 100;
            prod.TSTOP__c = 100;
            prod.Shower_Kit__c = 'Adjustable Riser';
            prod.Main_Construction_Material__c = 'Brass';
            prod.Minimum_dynamic_Pressure__c = 100;
            prod.Whats_in_the_Box__c = 'Old';
            prod.Assembly_Required__c = 'Y';
            prod.Flow_through_Fixed_Head_l_min_FR0_2__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR0_5__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR1_0__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR2_0__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR3_0__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR4_0__c = 100;
            prod.Flow_through_Fixed_Head_l_min_FR5_0__c = 100;
            prod.Flow_through_Fixed_Head_l_min_Min__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR0_2__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR0_5__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR1_0__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR2_0__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR3_0__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR4_0__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_FR5_0__c = 100;
            prod.Flow_through_Flow_Limiter_l_min_Min__c = 100;
            prod.Flow_through_Handset_l_min_FR0_2__c = 100;
            prod.Flow_through_Handset_l_min_FR0_5__c = 100;
            prod.Flow_through_Handset_l_min_FR1_0__c = 100;
            prod.Flow_through_Handset_l_min_FR2_0__c = 100;
            prod.Flow_through_Handset_l_min_FR3_0__c = 100;
            prod.Flow_through_Handset_l_min_FR4_0__c = 100;
            prod.Flow_through_Handset_l_min_FR5_0__c = 100;
            prod.Flow_through_Handset_l_min_Min__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR0_2__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR0_5__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR1_0__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR2_0__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR3_0__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR4_0__c = 100;
            prod.Flow_through_Open_Outlet_l_min_FR5_0__c = 100;
            prod.Flow_through_Open_Outlet_l_min_Min__c = 100;
            prod.Internal_Length__c = 'Old';
            prod.Internal_Width__c = 'Old';
            prod.Height_Inc_Feet__c = 'Old';
            prod.Height_Max__c = 'Old';
            prod.Height_Min__c = 'Old';
            prod.Full_Height__c = 'Old';
            prod.Full_Projection__c = 'Old';
            prod.Overflow_to_Waste__c = 'Old';
            prod.Spout_Projection__c = 'Old';
            prod.Valve__c = 'Old';
            prod.Inlet_Centres__c = 'Old';
            prod.Hose_Length__c = 'Old';
            prod.Surface_Mounted__c = 'Y';
            prod.Recessed__c = 'Y';
            prod.Valve_Centres__c = 100;
            prod.Wall_to_Valve_Centre__c = 100;
            prod.Output__c = 'Old';
            prod.Description__c = 'Old';
            prod.Additional_Information__c = 'Old';
            prod.P_P_Range__c = 'Old';
            prod.Section__c = 'Old';
            prod.Sub_Section__c = 'Old';
            prod.Variant_Header__c = 'Old';
            prod.Accelerator_Product__c = true;
            prod.Accelerator_Category__c = 'Bathroom Taps';
            prod.Accelerator_Range__c = '1901';
            prod.Accelerator_Title__c = 'Old';
            prod.Accelerator_Title_2__c = 'Old';
            prod.Description_Line_1__c = 'Brass backnut';
            prod.Description_Line_2__c = 'Brass backnut';
            prod.Description_Line_3__c = 'Brass backnut';
            prod.Description_Line_4__c = 'Brass backnut';
            prod.Description_Line_5__c = 'Brass backnut';
            prod.Accelerator_Intro_Paragraph__c = 'Old';
            prod.Paragraph_Line_1__c = 'Old';
            prod.Paragraph_Line_2__c = 'Old';
            prod.Paragraph_Line_3__c = 'Old';
            prod.Bath_Feet_Type__c = 'Old';
            prod.Bath_Feet_Type_2__c = 'Old';
            prod.Solid_Skin__c = true;
            prod.Single_or_Double_Ended__c = 'Single Ended';
            prod.A4_Description__c = 'Old';
            prod.Product_Benefits__c = 'Old';
            prod.Title__c = 'Old';
            prod.Title_Short__c = 'Old';
            prod.Variant_Description__c = 'Old';
            prod.P_P_New_Price_inc_VAT__c = 100;
            prod.P_P_New_Price_ex_VAT__c = 100;
            prod.Specifier_Title__c = 'Old';
            prod.Specify_Description__c = 'Old';
            prod.Specify_As__c = 'Old';
            prod.Recommended_Items__c = 'Old';
            prod.Build_Timings__c = 100;
            prod.Ireland_Euro_inc_VAT__c = 100;
            prod.Northern_Ireland_GBP_inc_VAT__c = 100;
            prod.EU_REACH_Regulation__c = 'Required';
            prod.UK_Water_Regulation_Compliance__c = 'Required';
            prod.Low_Voltage_Compliant__c = true;
            prod.EMC_Directive_Compliant__c = true;
            prod.Red_Directive_Compliant__c = true;
            prod.ECO_Design_Compliant__c = true;
            prod.Energy_Label_Check__c = true;
            prod.REACH_Statement__c = true;
            prod.UK_Water_Regulation_Approved__c = true;
            prod.CE_Approval_Certificate_No__c = 'Old';
            prod.EUTR_Certificate_No__c = 'Old';
            prod.Energy_Label__c = 'Required';
            prod.Product_Code__c = 'Test Product';
            prod.Site__c = '01';
            prod.Status__c = 'Complete';
            INSERT prod;

            // Create ECN
            ecn = new ECN__c();
            ecn.Product__c = prod.Id;
            ecn.Type__c = 'Discontinuation';
            ecn.Notes__c = 'TEST ECN';
            ecn.Status__c = 'New';
            ecn.Effective_Date__c = date.today();
            ecn.Value_of_Obsolete_Stock__c = 10;
            ecn.Quantity_of_Obsolete_Stock__c = 10;
            ecn.Last_Sales_Date__c = date.today();
            INSERT ecn;
        }
    }
    
    static testMethod void Test1() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Long Part Description',New_Value__c='New');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Short Part Description',New_Value__c='New');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Lead Time (Days)',New_Value__c='99');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accounting Group',New_Value__c='0002 Bath Taps');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Engineering Part Description',New_Value__c='New');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Additional Comments and Information',New_Value__c='Test');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Control (BEAB)',New_Value__c='Not Required');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Care (BEABC)',New_Value__c='Not Required');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB EMC Certificate Expiry (BEABE)',New_Value__c=null);
            ECNLineList.add(newline9);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals('New', prod.Long_Part_Description__c);
            System.assertEquals('New', prod.Short_Part_Description__c);
            System.assertEquals('New', prod.Engineering_Part_Description__c);
            System.assertEquals(99, prod.Lead_Time__c);
            System.assertEquals('0002 Bath Taps', prod.Accounting_Group__c);
            System.assertEquals('Test', prod.Additional_Comment_and_Information__c);
            System.assertEquals('Not Required', prod.BEAB__c);
            System.assertEquals('Not Required', prod.BEABC__c);
            System.assertEquals(null, prod.BEABE__c);
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();  
        }
    }
    
    static testMethod void Test2() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Weight (Kg)',New_Value__c='99');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Pre-set Outlet Temperature',New_Value__c='99');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Shower Kit',New_Value__c='Adjustable Riser');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Case Quantity',New_Value__c='99');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='CE Marking Required',New_Value__c='Not Required');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Main Construction Material',New_Value__c='Brass');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Minimum Dynamic Pressure',New_Value__c='99');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='What\'s in the Box?',New_Value__c='New');
            ECNLineList.add(newline8);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals(99, prod.Product_Weight_Kg__c);
            System.assertEquals(99, prod.TSTOP__c);
            System.assertEquals('Adjustable Riser', prod.Shower_Kit__c);
            System.assertEquals('Brass', prod.Main_Construction_Material__c);
            System.assertEquals(99, prod.Minimum_dynamic_Pressure__c);
            System.assertEquals('New', prod.Whats_in_the_Box__c);
            System.assertEquals(99, prod.Case_Quantity__c);
            System.assertEquals('Not Required', prod.CE_Marking__c);
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();  
        }
    }
    
    static testMethod void Test3() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Check Valve Supplied (CHECK)',New_Value__c='N');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Commodity Code',New_Value__c='00 Contemporary');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Commodity Code 2 (COMC2)',New_Value__c='New');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Connection Inlet (INLET)',New_Value__c='New');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Connection Outlet (OUTLT)',New_Value__c='New');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Minimum Flow Rate',New_Value__c='99');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR0.2)',New_Value__c='99');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR0.5)',New_Value__c='99');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Assembly Required',New_Value__c='N');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Internal Length',New_Value__c='New');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals('N', prod.CHECK__c);
            System.assertEquals('00 Contemporary', prod.Commodity_Code__c);
            System.assertEquals('New', prod.COMC2__c);
            System.assertEquals('New', prod.INLET__c);
            System.assertEquals('New', prod.OUTLT__c);   
            System.assertEquals('N', prod.Assembly_Required__c);
            System.assertEquals('New', prod.Internal_Length__c);
            System.assertEquals(99, prod.FR0_1__c);
            System.assertEquals(99, prod.FR0_2__c);
            System.assertEquals(99, prod.FR0_5__c);  
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test4() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Safety Certificate Expiry (BEABS)',New_Value__c=null);
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Mounting Type',New_Value__c=null);
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Type',New_Value__c=null);
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='EAN Number',New_Value__c='5555555555555');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 1 (FT1)',New_Value__c='New');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 10 (FT10)',New_Value__c='New');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 11 (FT11)',New_Value__c='New');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 2 (FT2)',New_Value__c='New');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 3 (FT3)',New_Value__c='New');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 4 (FT4)',New_Value__c='New');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals(null, prod.BEABS__c);
            System.assertEquals(null, prod.MOUNT__c);
            System.assertEquals(null, prod.DFLOW__c);
            System.assertEquals('5555555555555', prod.EAN_Number__c);
            System.assertEquals('New', prod.FT1__c);
            System.assertEquals('New', prod.FT10__c);
            System.assertEquals('New', prod.FT11__c);
            System.assertEquals('New', prod.FT2__c);
            System.assertEquals('New', prod.FT3__c);
            System.assertEquals('New', prod.FT4__c);
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test5() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR1.0)',New_Value__c='99');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR2.0)',New_Value__c='99');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR3.0)',New_Value__c='99');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR4.0)',New_Value__c='99');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR5.0)',New_Value__c='99');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate l/m (Open Outlet) (FLOW)',New_Value__c='99');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Internal Width',New_Value__c='New');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Inc Feet',New_Value__c='New');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Glass Content',New_Value__c='99');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Guarantee',New_Value__c='10');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals(99, prod.FR1_0__c);
            System.assertEquals(99, prod.FR2_0__c);
            System.assertEquals(99, prod.FR3_0__c);
            System.assertEquals(99, prod.FR4_0__c);
            System.assertEquals(99, prod.FR5_0__c);   
            System.assertEquals('New', prod.Internal_Width__c);
            System.assertEquals('New', prod.Height_Inc_Feet__c);
            System.assertEquals(99, prod.FLOW__c);
            System.assertEquals(99, prod.Glass__c);
            System.assertEquals('10', prod.Guarantee__c);
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test6() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Healthcare (HEAL)',New_Value__c='N');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Max',New_Value__c='New');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Min',New_Value__c='New');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hospitality Sector (HOSP)',New_Value__c='N');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Isolation Included (ISO)',New_Value__c='N');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Full Height',New_Value__c='New');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Full Projection',New_Value__c='New');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Other Materials',New_Value__c='New');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Own Label',New_Value__c='Yes');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Packaging Specification',New_Value__c='Boxed');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals('New', prod.Height_Max__c);
            System.assertEquals('New', prod.Height_Min__c);
            System.assertEquals('N', prod.HEAL__c);
            System.assertEquals('N', prod.HOSP__c);
            System.assertEquals('N', prod.ISO__c); 
            System.assertEquals('New', prod.Full_Height__c);
            System.assertEquals('New', prod.Full_Projection__c);
            System.assertEquals('New', prod.Other_Materials__c);
            System.assertEquals('Yes', prod.Own_Label__c);
            System.assertEquals('Boxed', prod.Packaging_Specification__c); 
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test7() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Pallet Quantity',New_Value__c='99');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Overflow to Waste',New_Value__c='New');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Paper / Cardboard Content',New_Value__c='99');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Parent Products',New_Value__c='New');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Phased Shutdown (PSHUT)',New_Value__c='N');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Planner Code',New_Value__c='New');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Plastic/Foam Content',New_Value__c='99');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Plumbing Systems (SYSTM)',New_Value__c='Suitable for all plumbing systems');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Packaged Product Weight (Kg)',New_Value__c='99');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Classification',New_Value__c='Essential');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals(99, prod.Pallet_Quantity__c);
            System.assertEquals('New', prod.Overflow_to_Waste__c);
            System.assertEquals(99, prod.Paper_Cardboard__c);
            System.assertEquals('New', prod.Parent_Products__c);
            System.assertEquals('N', prod.PSHUT__c);  
            System.assertEquals('New', prod.Planner_Code__c);
            System.assertEquals(99, prod.Plastic__c);
            System.assertEquals('Suitable for all plumbing systems', prod.SYSTM__c);
            System.assertEquals(99, prod.Product_Kg__c);
            System.assertEquals('Essential', prod.Product_Classification__c);  
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test8() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Family',New_Value__c='00 Bathroom Taps');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Finish',New_Value__c='00 Chrome Plated');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Spout Projection',New_Value__c='New');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Package Height (mm)',New_Value__c='99');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Package Length (mm)',New_Value__c='99');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Source',New_Value__c='Purchased');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sport & Leisure (SPLES)',New_Value__c='N');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supplier',New_Value__c='000000');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Valve',New_Value__c='New');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Inlet Centres',New_Value__c='New');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals('00 Bathroom Taps', prod.Product_Family__c);
            System.assertEquals('00 Chrome Plated', prod.Product_Finish__c);
            System.assertEquals('New', prod.Spout_Projection__c);
            System.assertEquals(99, prod.Single_Height__c);
            System.assertEquals(99, prod.Single_Length__c);
            System.assertEquals('Purchased', prod.Source__c);
            System.assertEquals('N', prod.SPLES__c);
            System.assertEquals('000000', prod.Supplier_Number__c);
            System.assertEquals('New', prod.Valve__c);
            System.assertEquals('New', prod.Inlet_Centres__c); 
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test9() {
        // Set ECN back to 'New' status
        ecn = ResetECN();
        // Create PAS user
        System.runAs ( new User(Id = UserInfo.getUserId()) ) { 
            u = CreatePASUser();
        }
        System.runAs(u){
            test.StartTest();
        
            // Create ECN Lines
            ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV2 Expiry Date (TMV2)',New_Value__c='New');
            ECNLineList.add(newline);
            ECN_Line__c newline2 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV3 Expiry Date (TMV3)',New_Value__c='New');
            ECNLineList.add(newline2);
            ECN_Line__c newline3 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hose Length',New_Value__c='New');
            ECNLineList.add(newline3);
            ECN_Line__c newline4 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Surface Mounted',New_Value__c='N');
            ECNLineList.add(newline4);
            ECN_Line__c newline5 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Recessed',New_Value__c='N');
            ECNLineList.add(newline5);
            ECN_Line__c newline6 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Control Valve Type',New_Value__c='Isolation Valve');
            ECNLineList.add(newline6);
            ECN_Line__c newline7 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Waste of Electrical Equipment (WEEE)',New_Value__c='Required');
            ECNLineList.add(newline7);
            ECN_Line__c newline8 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Valve Centres',New_Value__c='99');
            ECNLineList.add(newline8);
            ECN_Line__c newline9 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Wall to Valve Centre',New_Value__c='99');
            ECNLineList.add(newline9);
            ECN_Line__c newline10 = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Output',New_Value__c='New');
            ECNLineList.add(newline10);
            if(ECNLineList !=null && ECNLineList.size()>0){
                insert ECNLineList;
            }
            // Complete ECN to fire trigger
            ecn = CompleteECN();
            // Fetch updated product
            prod = GetProduct();
            // Asserts
            System.assertEquals('New', prod.TMV2__c);
            System.assertEquals('New', prod.TMV3__c);
            System.assertEquals('New', prod.Hose_Length__c);
            System.assertEquals('N', prod.Surface_Mounted__c);
            System.assertEquals('N', prod.Recessed__c);
            System.assertEquals('Isolation Valve', prod.VTYPE__c);
            System.assertEquals('Required', prod.WEEE__c);      
            System.assertEquals(99, prod.Valve_Centres__c);  
            System.assertEquals(99, prod.Wall_to_Valve_Centre__c);  
            System.assertEquals('New', prod.Output__c);  
            System.assertEquals('Complete', prod.Status__c);

            test.StopTest();    
        }
    }
    
    static testMethod void Test16() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Unified Water Label (UWL) Required';
        newline.New_Value__c = 'Required';
        INSERT newline;

//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Web Collection 1';
//        newline.New_Value__c = 'Old';
//        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'UWL Flow(l/min)/Capacity(ltrs)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Additional Information';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'P&P Range';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.Water_Label_Scheme_WEPLS__c);
//        System.assertEquals('Old', prod.WCAT1__c);
        System.assertEquals(100, prod.WFLOW__c);        
        System.assertEquals('Old', prod.Description__c);     
        System.assertEquals('Old', prod.Additional_Information__c);     
        System.assertEquals('Old', prod.P_P_Range__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test17() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Size Value';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Size SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Height Value';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Height SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Taphole Value';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Size_Value__c);
        System.assertEquals('Old', prod.Size_SKUs__c);
        System.assertEquals('Old', prod.Height_Value__c);
        System.assertEquals('Old', prod.Height_SKUs__c);
        System.assertEquals('Old', prod.Taphole_Value__c);      
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test18() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Taphole SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Hinge Finish Value';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Hinge Finish SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Hinge Function Value';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Hinge Function SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Taphole_SKUs__c);
        System.assertEquals('Old', prod.Hinge_Finish_Value__c);
        System.assertEquals('Old', prod.Hinge_Finish_SKUs__c);
        System.assertEquals('Old', prod.Hinge_Function_Value__c);
        System.assertEquals('Old', prod.Hinge_Function_SKUs__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test19() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Left/Right Handed Value';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Left/Right Handed SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Required Products Search';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Related Products Search';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Optional Products Search';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Left_Right_Handed_Value__c);
        System.assertEquals('Old', prod.Left_Right_Handed_SKUs__c);
        System.assertEquals('Old', prod.Required_Products_Search__c);
        System.assertEquals('Old', prod.Related_Products_Search__c);
        System.assertEquals('Old', prod.Optional_Products_Search__c);       
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test20() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Cross Sell Products Search';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Water Label';
        newline.New_Value__c = 'ERC 3.5 Flush';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Water Capacity';
        newline.New_Value__c = '100';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flush Volume';
        newline.New_Value__c = '100';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Use';
        newline.New_Value__c = 'Basin';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Cross_Sell_Products_Search__c);
        System.assertEquals('ERC 3.5 Flush', prod.Water_Label__c);
        System.assertEquals(100, prod.Water_Capacity__c);
        System.assertEquals(100, prod.Flush_Volume__c);
        System.assertEquals('Basin', prod.Product_Use__c);      
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test21() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Label 2';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant SKUs 2';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Value 2';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Label 3';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant SKUs 3';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Variant_Label_2__c);
        System.assertEquals('Old', prod.Variant_SKUs_2__c);
        System.assertEquals('Old', prod.Variant_Value_2__c);
        System.assertEquals('Old', prod.Variant_Label_3__c);
        System.assertEquals('Old', prod.Variant_SKUs_3__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test22() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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

        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Value 3';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Label 4';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant SKUs 4';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Value 4';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Label 5';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Variant_Value_3__c);
        System.assertEquals('Old', prod.Variant_Label_4__c);
        System.assertEquals('Old', prod.Variant_SKUs_4__c);
        System.assertEquals('Old', prod.Variant_Value_4__c);
        System.assertEquals('Old', prod.Variant_Label_5__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test23() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant SKUs 5';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Value 5';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Mounting Type';
        newline.New_Value__c = 'Deck';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Section';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sub Section';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Variant_SKUs_5__c);
        System.assertEquals('Old', prod.Variant_Value_5__c);
        System.assertEquals('Deck', prod.MOUNT__c);
        System.assertEquals('Old', prod.Section__c);
        System.assertEquals('Old', prod.Sub_Section__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test24() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow Type';
        newline.New_Value__c = 'Single';
        INSERT newline;

//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Fast Fix (FSTFX)';
//        newline.New_Value__c = 'Y';
//        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 1 (FT1)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Header';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Product';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Category';
        newline.New_Value__c = 'Bathroom Taps';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Single', prod.DFLOW__c);
//        System.assertEquals('Y', prod.FSTFX__c);
        System.assertEquals('Old', prod.FT1__c);        
        System.assertEquals('Old', prod.Variant_Header__c);       
        System.assertEquals(true, prod.Accelerator_Product__c);       
        System.assertEquals('Bathroom Taps', prod.Accelerator_Category__c);       
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test25() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 10 (FT10)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 11 (FT11)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 2 (FT2)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 3 (FT3)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 4 (FT4)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.FT10__c);
        System.assertEquals('Old', prod.FT11__c);
        System.assertEquals('Old', prod.FT2__c);
        System.assertEquals('Old', prod.FT3__c);
        System.assertEquals('Old', prod.FT4__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test26() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 5 (FT5)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 6 (FT6)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 7 (FT7)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 8 (FT8)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 9 (FT9)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.FT5__c);
        System.assertEquals('Old', prod.FT6__c);
        System.assertEquals('Old', prod.FT7__c);
        System.assertEquals('Old', prod.FT8__c);
        System.assertEquals('Old', prod.FT9__c);    
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test27() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Fitting Instructions Brand';
        newline.New_Value__c = 'Bristan';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Brand Label Required';
        newline.New_Value__c = 'Bristan';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Orientation';
        newline.New_Value__c = 'Left';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Range';
        newline.New_Value__c = '1901';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Title';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Bristan', prod.Fitting_Instructions_Brand__c);     
        System.assertEquals('Bristan', prod.Label_Required__c);
        System.assertEquals('Left', prod.HAND__c);      
        System.assertEquals('1901', prod.Accelerator_Range__c);     
        System.assertEquals('Old', prod.Accelerator_Title__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test28() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Manual or Thermostatic (MANTH)';
        newline.New_Value__c = 'Manual';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Manufactured Structure';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Maximum Dynamic Pressure (MDP)';
        newline.New_Value__c = '100';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Maximum Hot Water Supply Temp (MXHOT)';
        newline.New_Value__c = '100';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Title 2';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Manual', prod.MANTH__c);
        System.assertEquals('Old', prod.Manufactured_Structure__c);
        System.assertEquals(100, prod.MDP__c);
        System.assertEquals(100, prod.MXHOT__c);        
        System.assertEquals('Old', prod.Accelerator_Title_2__c);  
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test29() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Maximum Static Pressure (MSP)';
        newline.New_Value__c = '100';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Minimum Order Quantity';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description Line 1';
        newline.New_Value__c = 'Brass backnut';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description Line 2';
        newline.New_Value__c = 'Brass backnut';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description Line 3';
        newline.New_Value__c = 'Brass backnut';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals(100, prod.MSP__c);
        System.assertEquals(100, prod.Minimum_Order_Quantity__c);
        System.assertEquals('Brass backnut', prod.Description_Line_1__c);
        System.assertEquals('Brass backnut', prod.Description_Line_2__c);
        System.assertEquals('Brass backnut', prod.Description_Line_3__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test30() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'New Product Project (PRJCT)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'New Product Project Year (PRJYR)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Number of Handles/Controls';
        newline.New_Value__c = '10';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description Line 4';
        newline.New_Value__c = 'Brass backnut';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Description Line 5';
        newline.New_Value__c = 'Brass backnut';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.PRJCT__c);
        System.assertEquals('Old', prod.PRJYR__c);
        System.assertEquals(10, prod.CONTS__c);
        System.assertEquals('Brass backnut', prod.Description_Line_4__c);
        System.assertEquals('Brass backnut', prod.Description_Line_5__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test31() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Number of Tap Holes (TAPHO)';
//        newline.New_Value__c = '10';
//        INSERT newline;         

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Package Width (mm)';
        newline.New_Value__c = '100';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Type (PTYPE)';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Project No';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Accelerator Intro Paragraph';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Paragraph Line 1';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
//        System.assertEquals(10, prod.TAPHO__c);     
        System.assertEquals(100, prod.Single_Width__c);
        System.assertEquals('Old', prod.PTYPE__c);
        System.assertEquals('Old', prod.Project_No__c);
        System.assertEquals('Old', prod.Accelerator_Intro_Paragraph__c);
        System.assertEquals('Old', prod.Paragraph_Line_1__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test32() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Range';
        newline.New_Value__c = '1010 X-TOP';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Paragraph Line 2';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Paragraph Line 3';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Bath Feet Type';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Bath Feet Type 2';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('1010 X-TOP', prod.Range__c);
        System.assertEquals('Old', prod.Paragraph_Line_2__c);
        System.assertEquals('Old', prod.Paragraph_Line_3__c);
        System.assertEquals('Old', prod.Bath_Feet_Type__c);
        System.assertEquals('Old', prod.Bath_Feet_Type_2__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test33() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'RRP Inc VAT';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Solid Skin';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Single or Double Ended';
        newline.New_Value__c = 'Single Ended';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'A4 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Benefits';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals(100, prod.RRP_Gross__c);      
        System.assertEquals(true, prod.Solid_Skin__c);      
        System.assertEquals('Single Ended', prod.Single_or_Double_Ended__c);      
        System.assertEquals('Old', prod.A4_Description__c);      
        System.assertEquals('Old', prod.Product_Benefits__c);      
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test34() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Rub Clean Handset (RUB)';
        newline.New_Value__c = 'Y';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sales Group';
        newline.New_Value__c = '000000';
        INSERT newline;


        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Shower Technology Type (TTYPE)';
        newline.New_Value__c = 'Old';
        INSERT newline;

//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Single Flow (SFLOW)';
//        newline.New_Value__c = 'Y';
//        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Y', prod.RUB__c);
        System.assertEquals('000000', prod.Sales_Group_Number__c);
        System.assertEquals('Old', prod.TTYPE__c);
//        System.assertEquals('Y', prod.SFLOW__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test35() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        
//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'With Waste (WWSTE)';
//        newline.New_Value__c = 'Y';
//        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Wood Content';
        newline.New_Value__c = '100';
        INSERT newline;

//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Working Pressure Range BAR (PRESS)';
//        newline.New_Value__c = 'Old';
//        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'WRAS Certificate Expiry (WRAS)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
//        System.assertEquals('Y', prod.WWSTE__c);
        System.assertEquals(100, prod.Wood__c);
//        System.assertEquals('Old', prod.PRESS__c);
        System.assertEquals('Old', prod.WRAS__c);       
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test36() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB Care Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB Control Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Low Voltage Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EMC Directive Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'RED Directive Required';
        newline.New_Value__c = 'Required';
        INSERT newline; 
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.BEAB_Care_Required__c);
        System.assertEquals('Required', prod.BEAB_Control_Required__c);
        System.assertEquals('Required', prod.Low_Voltage__c);
        System.assertEquals('Required', prod.EMC_Directive__c);
        System.assertEquals('Required', prod.RED_Directive__c);         
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test37() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'ECO Design Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EU Timber Regulations Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Show on Web';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Title';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Short Title';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.ECO_Design__c);
        System.assertEquals('Required', prod.EU_Timber_Regulations__c);
        System.assertEquals(true, prod.Show_on_Web__c);
        System.assertEquals('Old', prod.Web_Title__c);
        System.assertEquals('Old', prod.Web_Short_Title__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test38() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Variant Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Additional Information';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Wishlist Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Finish Value';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Finish SKUs';
        newline.New_Value__c = 'Old';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Web_Variant_Description__c);
        System.assertEquals('Old', prod.Web_Additional_Information__c);
        System.assertEquals('Old', prod.Wishlist_Description__c);
        System.assertEquals('Old', prod.Finish_Value__c);
        System.assertEquals('Old', prod.Finish_SKUs__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test39() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sanitaryware Shape';
        newline.New_Value__c = 'Round';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Matching Products';
        newline.New_Value__c = 'Y';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Easyfit';
        newline.New_Value__c = 'Y';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Shower Head Type';
        newline.New_Value__c = 'Adjustable';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Valve/Control Type';
        newline.New_Value__c = 'Exposed';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Round', prod.Sanitaryware_Shape__c);
        System.assertEquals('Y', prod.Matching_Products__c);
        System.assertEquals('Y', prod.Easyfit__c);
        System.assertEquals('Adjustable', prod.Shower_Head_Type__c);
        System.assertEquals('Exposed', prod.Valve_Control_Type__c);       
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test40() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Handle Shape';
        newline.New_Value__c = 'Round';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Power Rating';
        newline.New_Value__c = '8.5kw (standard)';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Handset Type';
        newline.New_Value__c = 'Single Mode';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Safety';
        newline.New_Value__c = 'Thermostatic';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sector';
        newline.New_Value__c = 'Social Housing';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Round', prod.Handle_Shape__c);
        System.assertEquals('8.5kW (standard)', prod.Power_Rating__c);
        System.assertEquals('Single Mode', prod.Handset_Type__c);
        System.assertEquals('Thermostatic', prod.Safety__c);
        System.assertEquals('Social Housing', prod.Sector__c);      
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test41() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'What Style?';
        newline.New_Value__c = 'Hotel';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sink Shape';
        newline.New_Value__c = 'Round';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'TMV2';
        newline.New_Value__c = 'Y';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'TMV3';
        newline.New_Value__c = 'Y';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'DO8';
        newline.New_Value__c = 'Y';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Hotel', prod.What_Style__c);
        System.assertEquals('Round', prod.Sink_Shape__c);
        System.assertEquals('Y', prod.TMV2_Web__c);
        System.assertEquals('Y', prod.TMV3_Web__c);
        System.assertEquals('Y', prod.DO8__c);        
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test42() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'LANTAC';
        newline.New_Value__c = 'Y';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Label 1';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant SKUs 1';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Value 1';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Y', prod.LANTAC__c);
        System.assertEquals('Old', prod.Variant_Label_1__c);
        System.assertEquals('Old', prod.Variant_SKUs_1__c);
        System.assertEquals('Old', prod.Variant_Value_1__c);            
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test43() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EAN Number';
        newline.New_Value__c = '123451234512345';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sales Part Active?';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Cost Delivered';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Cost Delivered Currency';
        newline.New_Value__c = 'GBP';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Cost in GBP';
        newline.New_Value__c = '100';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals(true, prod.Sales_Part_Active__c);
        System.assertEquals('123451234512345', prod.EAN_Number__c);
        System.assertEquals(100, prod.Cost_Delivered__c);
        System.assertEquals(100, prod.Cost_in_GBP__c);  
        System.assertEquals('GBP', prod.Cost_Delivered_Currency__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test44() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB EMC Approval Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB EMC Certificate Expiry (BEABE)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB Safety Approval Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BEAB Safety Certificate Expiry (BEABS)';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Brass Product (BRASS)';
//        newline.New_Value__c = 'Y';
//        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.BEAB_EMC_Approval_Required__c);
        System.assertEquals('Old', prod.BEABE__c);
        System.assertEquals('Required', prod.BEAB_Safety_Approval_Required__c);
        System.assertEquals('Old', prod.BEABS__c);  
//        System.assertEquals('Y', prod.BRASS__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test45() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'CS Drawing Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Declaration of Conformity Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Fitting Instructions Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Image Required';
        newline.New_Value__c = 'Yes';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Depth (mm)';
        newline.New_Value__c = '100';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Yes', prod.CS_Drawing_Required__c);
        System.assertEquals('Yes', prod.Declaration_of_Conformity_Required__c);
        System.assertEquals('Yes', prod.Fitting_Instructions_Required__c);
        System.assertEquals('Yes', prod.Image_Required__c);  
        System.assertEquals(100, prod.Product_Depth_mm__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test46() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Height (mm)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Product Width (mm)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'QC Sheet Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Riser Length (mm)';
        newline.New_Value__c = '100';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'ROHS Expiry Date (ROHS)';
        newline.New_Value__c = 'Old';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals(100, prod.Product_Height_mm__c);
        System.assertEquals(100, prod.Product_Width_mm__c);
        System.assertEquals('Yes', prod.QC_Sheet_Required__c);
        System.assertEquals(100, prod.Riser_Length_mm__c);  
        System.assertEquals('Old', prod.ROHS__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test47() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'ROHS Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Spare Parts Required';
//        newline.New_Value__c = 'Yes';
//        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Spout Height (mm)';
        newline.New_Value__c = '100';
        INSERT newline;
        
//        newline = new ECN_Line__c();
//        newline.ECN__c = ecn.Id;
//        newline.Field_to_Change__c = 'Spout Projection (mm)';
//        newline.New_Value__c = '100';
//        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Supplier Drawing Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.ROHS_Required__c);
//        System.assertEquals('Yes', prod.Spare_Parts_Required__c);
        System.assertEquals(100, prod.Spout_Height_mm__c);
//        System.assertEquals(100, prod.Spout_Projection_mm__c);  
        System.assertEquals('Yes', prod.Supplier_Drawing_Required__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test50() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Supplier Etching';
        newline.New_Value__c = 'A';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Supplier Etching ID Marking';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Technical Construction File Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Technical Data Sheet Required';
        newline.New_Value__c = 'Yes';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Test Report Required';
        newline.New_Value__c = 'Yes';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('A', prod.Supplier_Etching__c);
        System.assertEquals('Yes', prod.Supplier_Etching_ID_Marking__c);
        System.assertEquals('Yes', prod.Technical_Construction_File_Required__c);
        System.assertEquals('Yes', prod.Technical_Data_Sheet_Required__c);  
        System.assertEquals('Yes', prod.Test_Report_Required__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test51() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'TMV2 Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'TMV3 Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'WEEE Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'WRAS Approval Required';
        newline.New_Value__c = 'Required';
        INSERT newline; 
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Required', prod.TMV2_Required__c);
        System.assertEquals('Required', prod.TMV3_Required__c);
        System.assertEquals('Required', prod.WEEE_Required__c);
        System.assertEquals('Required', prod.WRAS_Approval_Required__c);  
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test52() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Supersede Code';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sales Price Group';
        newline.New_Value__c = '0 - Bristan';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Video Content 1';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Video Content 2';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Video Content 3';
        newline.New_Value__c = 'Old';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Supersede_Code__c);
        System.assertEquals('0 - Bristan', prod.Sales_Price_Group__c);
        System.assertEquals('Old', prod.Video_Content_1__c);
        System.assertEquals('Old', prod.Video_Content_2__c);  
        System.assertEquals('Old', prod.Video_Content_3__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test53() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 1';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 2';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 3';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 4';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 5';
        newline.New_Value__c = 'Old';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.USP_Icon_1__c);
        System.assertEquals('Old', prod.USP_Icon_2__c);
        System.assertEquals('Old', prod.USP_Icon_3__c);
        System.assertEquals('Old', prod.USP_Icon_4__c);  
        System.assertEquals('Old', prod.USP_Icon_5__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }       
    
    static testMethod void Test54() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 6';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 1 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 2 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 3 Description';
        newline.New_Value__c = 'Old';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 4 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.USP_Icon_6__c);
        System.assertEquals('Old', prod.USP_Icon_1_Description__c);
        System.assertEquals('Old', prod.USP_Icon_2_Description__c);
        System.assertEquals('Old', prod.USP_Icon_3_Description__c);  
        System.assertEquals('Old', prod.USP_Icon_4_Description__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }           

    static testMethod void Test55() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 5 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 6 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Customs Stat No';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Country of Origin';
        newline.New_Value__c = 'GB - UNITED KINGDOM';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 12 (FT12)';
        newline.New_Value__c = 'Old';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.USP_Icon_5_Description__c);
        System.assertEquals('Old', prod.USP_Icon_6_Description__c);
        System.assertEquals('Old', prod.Customs_Stat_No__c);
        System.assertEquals('GB - UNITED KINGDOM', prod.Country_of_Origin__c);  
        System.assertEquals('Old', prod.FT12__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }       
    
    static testMethod void Test56() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 13 (FT13)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Feature 14 (FT14)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Tap Holes';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Commercial Product';
        newline.New_Value__c = 'N';
        INSERT newline; 
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Type';
        newline.New_Value__c = 'Full Product';
        INSERT newline; 
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.FT13__c);
        System.assertEquals('Old', prod.FT14__c);
        System.assertEquals('Old', prod.Web_Tap_Holes__c);
        System.assertEquals('N', prod.Commercial_Product__c);  
        System.assertEquals('Full Product', prod.Product_Type__c);         
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }       
    
    static testMethod void Test57() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Spares Category';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Finish';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 7';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 7 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;       
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Hero Copy';
        newline.New_Value__c = 'Old';
        INSERT newline;    
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
        
        System.assertEquals('Old', prod.Web_Finish__c);
        System.assertEquals('Old', prod.Spares_Category__c);
        System.assertEquals('Old', prod.USP_Icon_7__c);
        System.assertEquals('Old', prod.USP_Icon_7_Description__c);        
        System.assertEquals('Old', prod.Hero_Copy__c);         
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }    
    
    static testMethod void Test58() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Range';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 8';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 8 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 9';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 9 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals('Old', prod.Web_Range__c);         
        System.assertEquals('Old', prod.USP_Icon_8__c);     
        System.assertEquals('Old', prod.USP_Icon_8_Description__c);     
        System.assertEquals('Old', prod.USP_Icon_9__c);     
        System.assertEquals('Old', prod.USP_Icon_9_Description__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test59() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 10';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'USP Icon 10 Description';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Contemporary or Traditional (STYLE)';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sell on Web';
        newline.New_Value__c = 'N';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Sell on Web Price';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals('Old', prod.USP_Icon_10__c);     
        System.assertEquals('Old', prod.USP_Icon_10_Description__c);     
        System.assertEquals('Old', prod.STYLE__c);   
        System.assertEquals('N', prod.Sell_on_Web__c);   
        System.assertEquals(100, prod.Sell_on_Web_Price__c);   
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test60() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Division (DIV)';
        newline.New_Value__c = 'Trade';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Heat and Plumb URL';
        newline.New_Value__c = 'test.bristan.com';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Victorian URL';
        newline.New_Value__c = 'test.bristan.com';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Tapstore URL';
        newline.New_Value__c = 'test.bristan.com';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Trading Depot URL';
        newline.New_Value__c = 'test.bristan.com';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals('Trade', prod.DIV__c);     
        System.assertEquals('test.bristan.com', prod.Heat_and_Plumb_URL__c);     
        System.assertEquals('test.bristan.com', prod.Victorian_URL__c);   
        System.assertEquals('test.bristan.com', prod.Tapstore_URL__c);   
        System.assertEquals('test.bristan.com', prod.Trading_Depot_URL__c);   
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    } 
    
    static testMethod void Test61() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Additional Comments and Information';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'BIM';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'NBS Specification';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Web Ready';
        newline.New_Value__c = 'true';
        INSERT newline;     
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Add to Website';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals('Old', prod.Additional_Comment_and_Information__c); 
        System.assertEquals(true, prod.BIM__c);
        System.assertEquals(true, prod.NBS_Specification__c);    
        System.assertEquals(true, prod.Web_Ready__c);     
        System.assertEquals(true, prod.Add_to_Website__c);             
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }     
    
    static testMethod void Test62() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (Min)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (Min)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (Min)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (Min)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_Min__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_Min__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_Min__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_Min__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }     
    
    static testMethod void Test63() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR0.2)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR0.2)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR0.2)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR0.2)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR0_2__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR0_2__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR0_2__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR0_2__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }  
    
    static testMethod void Test64() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR0.5)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR0.5)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR0.5)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR0.5)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR0_5__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR0_5__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR0_5__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR0_5__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }  
    
    static testMethod void Test65() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR1.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR1.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR1.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR1.0)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR1_0__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR1_0__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR1_0__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR1_0__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test66() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR2.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR2.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR2.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR2.0)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR2_0__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR2_0__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR2_0__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR2_0__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test67() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR3.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR3.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR3.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR3.0)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR3_0__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR3_0__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR3_0__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR3_0__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test68() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR4.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR4.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR4.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR4.0)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR4_0__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR4_0__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR4_0__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR4_0__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test69() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Fixed Head l/min (FR5.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Flow Limiter l/min (FR5.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Handset l/min (FR5.0)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Flow through Open Outlet l/min (FR5.0)';
        newline.New_Value__c = '100';
        INSERT newline;     
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Flow_through_Fixed_Head_l_min_FR5_0__c); 
        System.assertEquals(100, prod.Flow_through_Flow_Limiter_l_min_FR5_0__c);
        System.assertEquals(100, prod.Flow_through_Handset_l_min_FR5_0__c);    
        System.assertEquals(100, prod.Flow_through_Open_Outlet_l_min_FR5_0__c);     
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test70() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Title';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Title Short';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Variant Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'P&P New Price (ex VAT)';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'P&P New Price (inc VAT)';
        newline.New_Value__c = '100';
        INSERT newline;         
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.P_P_New_Price_inc_VAT__c);      
        System.assertEquals(100, prod.P_P_New_Price_ex_VAT__c);         
        System.assertEquals('Old', prod.Title__c); 
        System.assertEquals('Old', prod.Title_Short__c);
        System.assertEquals('Old', prod.Variant_Description__c);    
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }    
    
    static testMethod void Test71() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Specifier Title';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Specify Description';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Specify As';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Recommended Items';
        newline.New_Value__c = 'Old';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals('Old', prod.Specifier_Title__c);      
        System.assertEquals('Old', prod.Specify_Description__c); 
        System.assertEquals('Old', prod.Specify_As__c);
        System.assertEquals('Old', prod.Recommended_Items__c);    
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }    
    
    static testMethod void Test72() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'P&P Ready';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Add to P&P';
        newline.New_Value__c = 'true';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Build Timings';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EU REACH Regulation';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Build_Timings__c);   
        System.assertEquals(true, prod.P_P_Ready__c);      
        System.assertEquals(true, prod.Add_to_P_P__c); 
        System.assertEquals('Required', prod.EU_REACH_Regulation__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }    

    static testMethod void Test73() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Component?';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Inventory Only?';
        newline.New_Value__c = 'true';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Northern Ireland GBP (£) inc VAT';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Ireland Euro (€) inc VAT';
        newline.New_Value__c = '100';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'UK Water Regulation Compliance';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(100, prod.Ireland_Euro_inc_VAT__c);   
        System.assertEquals(100, prod.Northern_Ireland_GBP_inc_VAT__c);   
        System.assertEquals(true, prod.Component__c);      
        System.assertEquals(true, prod.Inventory_Only__c); 
        System.assertEquals('Required', prod.UK_Water_Regulation_Compliance__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }     
    
    static testMethod void Test74() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Low Voltage Compliant';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'CE Approval Certificate No';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EMC Directive Compliant';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Red Directive Compliant';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'ECO Design Compliant';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(true, prod.Low_Voltage_Compliant__c);   
        System.assertEquals('Old', prod.CE_Approval_Certificate_No__c);   
        System.assertEquals(true, prod.EMC_Directive_Compliant__c);      
        System.assertEquals(true, prod.Red_Directive_Compliant__c); 
        System.assertEquals(true, prod.ECO_Design_Compliant__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }     
    
    static testMethod void Test75() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Energy Label';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'EUTR Certificate No';
        newline.New_Value__c = 'Old';
        INSERT newline;

        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'REACH Statement';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'UK Water Regulation Approved (Y/N)';
        newline.New_Value__c = 'true';
        INSERT newline;
        
        newline = new ECN_Line__c();
        newline.ECN__c = ecn.Id;
        newline.Field_to_Change__c = 'Energy Label Required';
        newline.New_Value__c = 'Required';
        INSERT newline;
        
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);
        ProductId = prod.Id;
        system.debug('*****PRODUCT ID: ' + ProductId);
        ECNId = ecn.Id;
        system.debug('*****ECN ID: ' + ECNId);
       
        System.assertEquals(true, prod.Energy_Label_Check__c);   
        System.assertEquals('Old', prod.EUTR_Certificate_No__c);   
        System.assertEquals(true, prod.REACH_Statement__c);      
        System.assertEquals(true, prod.UK_Water_Regulation_Approved__c); 
        System.assertEquals('Required', prod.Energy_Label__c); 
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }

    static testMethod void Test80() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 5 (FT5)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 6 (FT6)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 7 (FT7)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 8 (FT8)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 9 (FT9)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.FT5__c);
        System.assertEquals(null, prod.FT6__c);
        System.assertEquals(null, prod.FT7__c);
        System.assertEquals(null, prod.FT8__c);
        System.assertEquals(null, prod.FT9__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test81() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Fitting Instructions Brand',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Minimum Flow Rate',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR0.2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR0.5)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR1.0)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Fitting_Instructions_Brand__c);
        System.assertEquals(null, prod.FR0_1__c);
        System.assertEquals(null, prod.FR0_2__c);
        System.assertEquals(null, prod.FR0_5__c);
        System.assertEquals(null, prod.FR1_0__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test82() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR2.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR3.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR4.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate (FR5.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Rate l/m (Open Outlet) (FLOW)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.FR2_0__c);
        System.assertEquals(null, prod.FR3_0__c);
        System.assertEquals(null, prod.FR4_0__c);
        System.assertEquals(null, prod.FR5_0__c);
        System.assertEquals(null, prod.FLOW__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test83() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Healthcare (HEAL)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hospitality Sector (HOSP)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Isolation Included (ISO)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Brand Label Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Orientation',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.HEAL__c);
        System.assertEquals(null, prod.HOSP__c);
        System.assertEquals(null, prod.ISO__c);
        System.assertEquals(null, prod.Label_Required__c);
        System.assertEquals(null, prod.HAND__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test84() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Manual or Thermostatic (MANTH)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Manufactured Structure',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Maximum Dynamic Pressure (MDP)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Maximum Hot Water Supply Temp (MXHOT)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Maximum Static Pressure (MSP)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.MANTH__c);
        System.assertEquals(null, prod.Manufactured_Structure__c);
        System.assertEquals(null, prod.MDP__c);
        System.assertEquals(null, prod.MXHOT__c);
        System.assertEquals(null, prod.MSP__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test85() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='New Product Project (PRJCT)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='New Product Project Year (PRJYR)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Number of Handles/Controls',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Own Label',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Parent Products',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.PRJCT__c);
        System.assertEquals(null, prod.PRJYR__c);
        System.assertEquals(null, prod.CONTS__c);
        System.assertEquals(null, prod.Own_Label__c);
        System.assertEquals(null, prod.Parent_Products__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test86() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Phased Shutdown (PSHUT)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Plumbing Systems (SYSTM)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Type (PTYPE)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Project No',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Rub Clean Handset (RUB)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.PSHUT__c);
        System.assertEquals(null, prod.SYSTM__c);
        System.assertEquals(null, prod.PTYPE__c);
        System.assertEquals(null, prod.Project_No__c);
        System.assertEquals(null, prod.RUB__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }   
    
    static testMethod void Test87() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Shower Technology Type (TTYPE)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sport & Leisure (SPLES)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supplier',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV2 Expiry Date (TMV2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV3 Expiry Date (TMV3)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.TTYPE__c);
        System.assertEquals(null, prod.SPLES__c);
        System.assertEquals(null, prod.Supplier__c);
        System.assertEquals(null, prod.TMV2__c);
        System.assertEquals(null, prod.TMV3__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test88() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow Control Valve Type',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Waste of Electrical Equipment (WEEE)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Unified Water Label (UWL) Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='UWL Flow(l/min)/Capacity(ltrs)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='WRAS Certificate Expiry (WRAS)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.VTYPE__c);
        System.assertEquals(null, prod.WEEE__c);
        System.assertEquals(null, prod.Water_Label_Scheme_WEPLS__c);
        System.assertEquals(null, prod.WFLOW__c);
        System.assertEquals(null, prod.WRAS__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test89() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Care Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Control Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB EMC Approval Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='BEAB Safety Approval Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='CS Drawing Required',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.BEAB_Care_Required__c);
        System.assertEquals(null, prod.BEAB_Control_Required__c);
        System.assertEquals(null, prod.BEAB_EMC_Approval_Required__c);
        System.assertEquals(null, prod.BEAB_Safety_Approval_Required__c);
        System.assertEquals(null, prod.CS_Drawing_Required__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test90() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Fitting Instructions Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Declaration of Conformity Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Image Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Low Voltage Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='EMC Directive Required',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Fitting_Instructions_Required__c);
        System.assertEquals(null, prod.Declaration_of_Conformity_Required__c);
        System.assertEquals(null, prod.Image_Required__c);
        System.assertEquals(null, prod.Low_Voltage__c);
        System.assertEquals(null, prod.EMC_Directive__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test91() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='RED Directive Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='ECO Design Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='EU Timber Regulations Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Title',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Short Title',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.RED_Directive__c);
        System.assertEquals(null, prod.ECO_Design__c);
        System.assertEquals(null, prod.EU_Timber_Regulations__c);
        System.assertEquals(null, prod.Web_Title__c);
        System.assertEquals(null, prod.Web_Short_Title__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test92() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Variant Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Additional Information',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Wishlist Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Finish Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Finish SKUs',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Web_Variant_Description__c);
        System.assertEquals(null, prod.Web_Additional_Information__c);
        System.assertEquals(null, prod.Wishlist_Description__c);
        System.assertEquals(null, prod.Finish_Value__c);
        System.assertEquals(null, prod.Finish_SKUs__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test93() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Size Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Size SKUs',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height SKUs',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Taphole Value',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Size_Value__c);
        System.assertEquals(null, prod.Size_SKUs__c);
        System.assertEquals(null, prod.Height_Value__c);
        System.assertEquals(null, prod.Height_SKUs__c);
        System.assertEquals(null, prod.Taphole_Value__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }   
    
    static testMethod void Test94() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Taphole SKUs',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hinge Finish Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hinge Finish SKUs',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hinge Function Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hinge Function SKUs',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Taphole_SKUs__c);
        System.assertEquals(null, prod.Hinge_Finish_Value__c);
        System.assertEquals(null, prod.Hinge_Finish_SKUs__c);
        System.assertEquals(null, prod.Hinge_Function_Value__c);
        System.assertEquals(null, prod.Hinge_Function_SKUs__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }       
    
    static testMethod void Test95() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Left/Right Handed Value',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Left/Right Handed SKUs',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Required Products Search',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Related Products Search',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Optional Products Search',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Left_Right_Handed_Value__c);
        System.assertEquals(null, prod.Left_Right_Handed_SKUs__c);
        System.assertEquals(null, prod.Required_Products_Search__c);
        System.assertEquals(null, prod.Related_Products_Search__c);
        System.assertEquals(null, prod.Optional_Products_Search__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test96() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Cross Sell Products Search',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Water Label',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Water Capacity',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flush Volume',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Use',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Cross_Sell_Products_Search__c);
        System.assertEquals(null, prod.Water_Label__c);
        System.assertEquals(null, prod.Water_Capacity__c);
        System.assertEquals(null, prod.Flush_Volume__c);
        System.assertEquals(null, prod.Product_Use__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test97() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sanitaryware Shape',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Matching Products',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Easyfit',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Shower Head Type',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Valve/Control Type',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Sanitaryware_Shape__c);
        System.assertEquals(null, prod.Matching_Products__c);
        System.assertEquals(null, prod.Easyfit__c);
        System.assertEquals(null, prod.Shower_Head_Type__c);
        System.assertEquals(null, prod.Valve_Control_Type__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test98() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Handle Shape',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Power Rating',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Handset Type',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Safety',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sector',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Handle_Shape__c);
        System.assertEquals(null, prod.Power_Rating__c);
        System.assertEquals(null, prod.Handset_Type__c);
        System.assertEquals(null, prod.Safety__c);
        System.assertEquals(null, prod.Sector__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test99() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='What Style?',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sink Shape',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='DO8',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.What_Style__c);
        System.assertEquals(null, prod.Sink_Shape__c);
        System.assertEquals(null, prod.TMV2_Web__c);
        System.assertEquals(null, prod.TMV3_Web__c);
        System.assertEquals(null, prod.DO8__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test100() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='LANTAC',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Label 1',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Label 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Label 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Label 4',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.LANTAC__c);
        System.assertEquals(null, prod.Variant_Label_1__c);
        System.assertEquals(null, prod.Variant_Label_2__c);
        System.assertEquals(null, prod.Variant_Label_3__c);
        System.assertEquals(null, prod.Variant_Label_4__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test101() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Label 5',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant SKUs 1',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant SKUs 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant SKUs 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant SKUs 4',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Variant_Label_5__c);
        System.assertEquals(null, prod.Variant_SKUs_1__c);
        System.assertEquals(null, prod.Variant_SKUs_2__c);
        System.assertEquals(null, prod.Variant_SKUs_3__c);
        System.assertEquals(null, prod.Variant_SKUs_4__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test102() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant SKUs 5',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Value 1',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Value 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Value 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Value 4',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Variant_SKUs_5__c);
        System.assertEquals(null, prod.Variant_Value_1__c);
        System.assertEquals(null, prod.Variant_Value_2__c);
        System.assertEquals(null, prod.Variant_Value_3__c);
        System.assertEquals(null, prod.Variant_Value_4__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test103() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Value 5',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Cost Delivered',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Cost in GBP',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Cost Delivered Currency',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Depth (mm)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Variant_Value_5__c);
        System.assertEquals(null, prod.Cost_Delivered__c);
        System.assertEquals(null, prod.Cost_in_GBP__c);
        System.assertEquals(null, prod.Cost_Delivered_Currency__c);
        System.assertEquals(null, prod.Product_Depth_mm__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test104() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Height (mm)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Width (mm)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Riser Length (mm)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Spout Height (mm)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Spout Projection',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Product_Height_mm__c);
        System.assertEquals(null, prod.Product_Width_mm__c);
        System.assertEquals(null, prod.Riser_Length_mm__c);
        System.assertEquals(null, prod.Spout_Height_mm__c);
        System.assertEquals(null, prod.Spout_Projection__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test105() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='QC Sheet Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='ROHS Expiry Date (ROHS)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='ROHS Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supplier Drawing Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supplier Etching',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.QC_Sheet_Required__c);
        System.assertEquals(null, prod.ROHS__c);
        System.assertEquals(null, prod.ROHS_Required__c);
        System.assertEquals(null, prod.Supplier_Drawing_Required__c);
        System.assertEquals(null, prod.Supplier_Etching__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test106() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supplier Etching ID Marking',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Technical Construction File Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Technical Data Sheet Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Test Report Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV2 Required',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Supplier_Etching_ID_Marking__c);
        System.assertEquals(null, prod.Technical_Construction_File_Required__c);
        System.assertEquals(null, prod.Technical_Data_Sheet_Required__c);
        System.assertEquals(null, prod.Test_Report_Required__c);
        System.assertEquals(null, prod.TMV2_Required__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test107() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='TMV3 Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='WEEE Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='WRAS Approval Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Supersede Code',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.TMV3_Required__c);
        System.assertEquals(null, prod.WEEE_Required__c);
        System.assertEquals(null, prod.WRAS_Approval_Required__c);
        System.assertEquals(null, prod.Supersede_Code__c);
        System.assertEquals(null, prod.Supersede_Date__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test108() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sales Price Group',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Video Content 1',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Video Content 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Video Content 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 1',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Sales_Price_Group__c);
        System.assertEquals(null, prod.Video_Content_1__c);
        System.assertEquals(null, prod.Video_Content_2__c);
        System.assertEquals(null, prod.Video_Content_3__c);
        System.assertEquals(null, prod.USP_Icon_1__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test109() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 4',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 5',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 6',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.USP_Icon_2__c);
        System.assertEquals(null, prod.USP_Icon_3__c);
        System.assertEquals(null, prod.USP_Icon_4__c);
        System.assertEquals(null, prod.USP_Icon_5__c);
        System.assertEquals(null, prod.USP_Icon_6__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test110() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 7',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 8',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 9',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 10',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 1 Description',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.USP_Icon_7__c);
        System.assertEquals(null, prod.USP_Icon_8__c);
        System.assertEquals(null, prod.USP_Icon_9__c);
        System.assertEquals(null, prod.USP_Icon_10__c);
        System.assertEquals(null, prod.USP_Icon_1_Description__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test111() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 2 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 3 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 4 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 5 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 6 Description',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.USP_Icon_2_Description__c);
        System.assertEquals(null, prod.USP_Icon_3_Description__c);
        System.assertEquals(null, prod.USP_Icon_4_Description__c);
        System.assertEquals(null, prod.USP_Icon_5_Description__c);
        System.assertEquals(null, prod.USP_Icon_6_Description__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test112() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 7 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 8 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 9 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='USP Icon 10 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Customs Stat No',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.USP_Icon_7_Description__c);
        System.assertEquals(null, prod.USP_Icon_8_Description__c);
        System.assertEquals(null, prod.USP_Icon_9_Description__c);
        System.assertEquals(null, prod.USP_Icon_10_Description__c);
        System.assertEquals(null, prod.Customs_Stat_No__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test113() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Country of Origin',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 12 (FT12)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 13 (FT13)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Feature 14 (FT14)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Tap Holes',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Country_of_Origin__c);
        System.assertEquals(null, prod.FT12__c);
        System.assertEquals(null, prod.FT13__c);
        System.assertEquals(null, prod.FT14__c);
        System.assertEquals(null, prod.Web_Tap_Holes__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test114() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Commercial Product',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Spares Category',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Finish',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hero Copy',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Web Range',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Commercial_Product__c);
        System.assertEquals(null, prod.Spares_Category__c);
        System.assertEquals(null, prod.Web_Finish__c);
        System.assertEquals(null, prod.Hero_Copy__c);
        System.assertEquals(null, prod.Web_Range__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test115() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Contemporary or Traditional (STYLE)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sell on Web',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sell on Web Price',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Division (DIV)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Heat and Plumb URL',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.STYLE__c);
        System.assertEquals(null, prod.Sell_on_Web__c);
        System.assertEquals(null, prod.Sell_on_Web_Price__c);
        System.assertEquals(null, prod.DIV__c);
        System.assertEquals(null, prod.Heat_and_Plumb_URL__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test116() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Victorian URL',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Tapstore URL',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Trading Depot URL',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Engineering Part Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Weight (Kg)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Victorian_URL__c);
        System.assertEquals(null, prod.Tapstore_URL__c);
        System.assertEquals(null, prod.Trading_Depot_URL__c);
        System.assertEquals(null, prod.Engineering_Part_Description__c);
        System.assertEquals(null, prod.Product_Weight_Kg__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }

    static testMethod void Test117() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Pre-set Outlet Temperature',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Shower Kit',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Main Construction Material',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Minimum Dynamic Pressure',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='What\'s in the Box?',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.TSTOP__c);
        System.assertEquals(null, prod.Shower_Kit__c);
        System.assertEquals(null, prod.Main_Construction_Material__c);
        System.assertEquals(null, prod.Minimum_dynamic_Pressure__c);
        System.assertEquals(null, prod.Whats_in_the_Box__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test118() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Assembly Required',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (Min)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (Min)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (Min)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (Min)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Assembly_Required__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_Min__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_Min__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_Min__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_Min__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test119() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR0.2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR0.2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR0.2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR0.2)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR0.5)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR0_2__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR0_2__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR0_2__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR0_2__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR0_5__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test120() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR0.5)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR0.5)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR0.5)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR1.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR1.0)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR0_5__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR0_5__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR0_5__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR1_0__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR1_0__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test121() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR1.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR1.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR2.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR2.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR2.0)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR1_0__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR1_0__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR2_0__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR2_0__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR2_0__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test122() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR2.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR3.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR3.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR3.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR3.0)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR2_0__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR3_0__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR3_0__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR3_0__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR3_0__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test123() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR4.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR4.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR4.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR4.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Handset l/min (FR5.0)',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR4_0__c);
        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR4_0__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR4_0__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR4_0__c);
        System.assertEquals(null, prod.Flow_through_Handset_l_min_FR5_0__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test124() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Open Outlet l/min (FR5.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Flow Limiter l/min (FR5.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Flow through Fixed Head l/min (FR5.0)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Internal Length',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Internal Width',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Flow_through_Open_Outlet_l_min_FR5_0__c);
        System.assertEquals(null, prod.Flow_through_Flow_Limiter_l_min_FR5_0__c);
        System.assertEquals(null, prod.Flow_through_Fixed_Head_l_min_FR5_0__c);
        System.assertEquals(null, prod.Internal_Length__c);
        System.assertEquals(null, prod.Internal_Width__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test125() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Inc Feet',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Max',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Height Min',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Full Height',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Full Projection',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Height_Inc_Feet__c);
        System.assertEquals(null, prod.Height_Max__c);
        System.assertEquals(null, prod.Height_Min__c);
        System.assertEquals(null, prod.Full_Height__c);
        System.assertEquals(null, prod.Full_Projection__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test126() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Overflow to Waste',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Valve',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Inlet Centres',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Hose Length',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Surface Mounted',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Overflow_to_Waste__c);
        System.assertEquals(null, prod.Valve__c);
        System.assertEquals(null, prod.Inlet_Centres__c);
        System.assertEquals(null, prod.Hose_Length__c);
        System.assertEquals(null, prod.Surface_Mounted__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test127() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Recessed',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Valve Centres',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Wall to Valve Centre',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Output',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Recessed__c);
        System.assertEquals(null, prod.Valve_Centres__c);
        System.assertEquals(null, prod.Wall_to_Valve_Centre__c);
        System.assertEquals(null, prod.Output__c);
        System.assertEquals(null, prod.Description__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test128() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Additional Information',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='P&P Range',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Section',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Sub Section',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Header',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Additional_Information__c);
        System.assertEquals(null, prod.P_P_Range__c);
        System.assertEquals(null, prod.Section__c);
        System.assertEquals(null, prod.Sub_Section__c);
        System.assertEquals(null, prod.Variant_Header__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test129() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accelerator Category',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accelerator Range',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accelerator Title',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accelerator Title 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description Line 1',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Accelerator_Category__c);
        System.assertEquals(null, prod.Accelerator_Range__c);
        System.assertEquals(null, prod.Accelerator_Title__c);
        System.assertEquals(null, prod.Accelerator_Title_2__c);
        System.assertEquals(null, prod.Description_Line_1__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test130() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description Line 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description Line 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description Line 4',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Description Line 5',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Accelerator Intro Paragraph',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Description_Line_2__c);
        System.assertEquals(null, prod.Description_Line_3__c);
        System.assertEquals(null, prod.Description_Line_4__c);
        System.assertEquals(null, prod.Description_Line_5__c);
        System.assertEquals(null, prod.Accelerator_Intro_Paragraph__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test131() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Paragraph Line 1',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Paragraph Line 2',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Paragraph Line 3',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Bath Feet Type',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Bath Feet Type 2',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Paragraph_Line_1__c);
        System.assertEquals(null, prod.Paragraph_Line_2__c);
        System.assertEquals(null, prod.Paragraph_Line_3__c);
        System.assertEquals(null, prod.Bath_Feet_Type__c);
        System.assertEquals(null, prod.Bath_Feet_Type_2__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test132() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Single or Double Ended',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='A4 Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Product Benefits',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Title',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Title Short',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Single_or_Double_Ended__c);
        System.assertEquals(null, prod.A4_Description__c);
        System.assertEquals(null, prod.Product_Benefits__c);
        System.assertEquals(null, prod.Title__c);
        System.assertEquals(null, prod.Title_Short__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest(); 
        }       
    }
    
    static testMethod void Test133() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Variant Description',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='P&P New Price (ex VAT)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='P&P New Price (inc VAT)',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Specifier Title',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Specify Description',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Variant_Description__c);
        System.assertEquals(null, prod.P_P_New_Price_ex_VAT__c);
        System.assertEquals(null, prod.P_P_New_Price_inc_VAT__c);
        System.assertEquals(null, prod.Specifier_Title__c);
        System.assertEquals(null, prod.Specify_Description__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test134() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Specify As',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Recommended Items',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Build Timings',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Ireland Euro (€) inc VAT',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Northern Ireland GBP (£) inc VAT',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.Specify_As__c);
        System.assertEquals(null, prod.Recommended_Items__c);
        System.assertEquals(null, prod.Build_Timings__c);
        System.assertEquals(null, prod.Ireland_Euro_inc_VAT__c);
        System.assertEquals(null, prod.Northern_Ireland_GBP_inc_VAT__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
    
    static testMethod void Test135() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ECNId = ecn.Id;  
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
        
        u = CreatePASUser();
        System.runAs(u){
        test.StartTest();
        
        // Create ECN Lines
        ECN_Line__c newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='EU REACH Regulation',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='UK Water Regulation Compliance',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='CE Approval Certificate No',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='EUTR Certificate No',New_Value__c=null);
        INSERT newline;
        newline = new ECN_Line__c(ECN__c=ecn.Id,Field_to_Change__c='Energy Label Required',New_Value__c=null);
        INSERT newline;
                
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' and Id =: ECNId LIMIT 1];
        prod = database.query(query);

        System.assertEquals(null, prod.EU_REACH_Regulation__c);
        System.assertEquals(null, prod.UK_Water_Regulation_Compliance__c);
        System.assertEquals(null, prod.CE_Approval_Certificate_No__c);
        System.assertEquals(null, prod.EUTR_Certificate_No__c);
        System.assertEquals(null, prod.Energy_Label__c);
        System.assertEquals('Complete', prod.Status__c);
        test.StopTest();  
        }
    }
      
    public static User CreatePASUser() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            UserName = 'Cpt.Awesome.' + DateTime.now().getTime() + '@awesomesauce.com',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'NPW_Originator' limit 1];
        PermissionSetAssignment psa =  new PermissionSetAssignment(AssigneeId = u.id, PermissionSetId = ps.Id);
        insert psa;
        return u;
    }

    public static Product__c GetProduct() {
        // Query all PAS product fields
        string objectName = 'Product__c';
        string query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
            query += ' ' + s + ',';
        }
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        } 
        query += ' FROM ' + objectName;
        query += ' WHERE Product_Code__c = \'Test Product\' LIMIT 1'; 
        Product__c prod = database.query(query);
        return prod;
    }

    public static ECN__c ResetECN() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ecn.Status__c = 'New';
        UPDATE ecn;
        return ecn;
    }

    public static ECN__c CompleteECN() {
        ecn = [SELECT Id, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Discontinuation' LIMIT 1];
        ecn.Status__c = 'Completed';
        UPDATE ecn;
        return ecn;
    }   
}