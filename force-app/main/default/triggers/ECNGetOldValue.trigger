trigger ECNGetOldValue on ECN_Line__c (before insert, before update) {
    for (ECN_Line__c ecnl : Trigger.new)
    {
        String ecnId = ecnl.ECN__c;
        system.debug('*****Trigger GetOldValue ECN ID: ' + ecnId);
        String pasId = ecnl.PAS_Id__c;
        system.debug('*****Trigger GetOldValue PAS ID: ' + pasId);        
        String objectName = 'Product__c';

        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
        query += ' FROM ' + objectName;
        query += ' WHERE Id = :pasId LIMIT 1'; 
  
        Product__c prod = database.query(query);
        system.debug('*****Trigger GetOldValue Product ID: ' + prod.Id);
        
        String oldValue = '';
        if(ecnl.Field_to_Change__c == 'Long Part Description') {
          oldvalue = prod.Long_Part_Description__c;
        } else if(ecnl.Field_to_Change__c == 'Short Part Description') { 
          oldvalue = prod.Short_Part_Description__c;
        } else if(ecnl.Field_to_Change__c == 'Lead Time (Days)') { 
          oldvalue = String.valueOf(prod.Lead_Time__c);
        } else if(ecnl.Field_to_Change__c == 'Accounting Group') { 
          oldvalue = prod.Accounting_Group__c;
        } else if(ecnl.Field_to_Change__c == 'Additional Comments and Information') { 
          oldvalue = prod.Additional_Comment_and_Information__c;          
//        } else if(ecnl.Field_to_Change__c == 'Adjustable Brackets (ABRAC)') { 
//          oldvalue = prod.ABRAC__c;
        } else if(ecnl.Field_to_Change__c == 'BEAB Control (BEAB)') { 
          oldvalue = prod.BEAB__c;     
        } else if(ecnl.Field_to_Change__c == 'BEAB Care (BEABC)') { 
          oldvalue = prod.BEABC__c;          
        } else if(ecnl.Field_to_Change__c == 'Case Quantity') { 
          oldvalue = String.valueOf(prod.Case_Quantity__c);
        } else if(ecnl.Field_to_Change__c == 'CE Marking') { 
          oldvalue = prod.CE_Marking__c;
        } else if(ecnl.Field_to_Change__c == 'Check Valve Supplied (CHECK)') { 
          oldvalue = prod.CHECK__c;
        } else if(ecnl.Field_to_Change__c == 'Commodity Code') { 
          oldvalue = prod.Commodity_Code__c;
        } else if(ecnl.Field_to_Change__c == 'Commodity Code 2 (COMC2)') { 
          oldvalue = prod.COMC2__c;
        } else if(ecnl.Field_to_Change__c == 'Connection Inlet (INLET)') { 
          oldvalue = prod.INLET__c;
        } else if(ecnl.Field_to_Change__c == 'Connection Outlet (OUTLT)') { 
          oldvalue = prod.OUTLT__c;
        } else if(ecnl.Field_to_Change__c == 'Mounting Type') { 
          oldvalue = prod.MOUNT__c;
        } else if(ecnl.Field_to_Change__c == 'Flow Type') { 
          oldvalue = prod.DFLOW__c;
//        } else if(ecnl.Field_to_Change__c == 'Fast Fix (FSTFX)') { 
//          oldvalue = prod.FSTFX__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 1 (FT1)') { 
          oldvalue = prod.FT1__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 10 (FT10)') { 
          oldvalue = prod.FT10__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 11 (FT11)') { 
          oldvalue = prod.FT11__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 2 (FT2)') { 
          oldvalue = prod.FT2__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 3 (FT3)') { 
          oldvalue = prod.FT3__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 4 (FT4)') { 
          oldvalue = prod.FT4__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 5 (FT5)') { 
          oldvalue = prod.FT5__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 6 (FT6)') { 
          oldvalue = prod.FT6__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 7 (FT7)') { 
          oldvalue = prod.FT7__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 8 (FT8)') { 
          oldvalue = prod.FT8__c;
        } else if(ecnl.Field_to_Change__c == 'Feature 9 (FT9)') { 
          oldvalue = prod.FT9__c;
        } else if(ecnl.Field_to_Change__c == 'Fitting Instructions Brand') { 
          oldvalue = prod.Fitting_Instructions_Brand__c;
        } else if(ecnl.Field_to_Change__c == 'Minimum Flow Rate') { 
          oldvalue = String.valueOf(prod.FR0_1__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR0.2)') { 
          oldvalue = String.valueOf(prod.FR0_2__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR0.5)') { 
          oldvalue = String.valueOf(prod.FR0_5__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR1.0)') { 
          oldvalue = String.valueOf(prod.FR1_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR2.0)') { 
          oldvalue = String.valueOf(prod.FR2_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR3.0)') { 
          oldvalue = String.valueOf(prod.FR3_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR4.0)') { 
          oldvalue = String.valueOf(prod.FR4_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR5.0)') { 
          oldvalue = String.valueOf(prod.FR5_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow Rate l/m (Open Outlet) (FLOW)') { 
          oldvalue = String.valueOf(prod.FLOW__c);
        } else if(ecnl.Field_to_Change__c == 'Glass Content') { 
          oldvalue = String.valueOf(prod.Glass__c);
        } else if(ecnl.Field_to_Change__c == 'Guarantee') { 
          oldvalue = prod.Guarantee__c;
//        } else if(ecnl.Field_to_Change__c == 'Handle Type (HANDT)') { 
//          oldvalue = prod.HANDT__c;
        } else if(ecnl.Field_to_Change__c == 'Healthcare (HEAL)') { 
          oldvalue = prod.HEAL__c;
        } else if(ecnl.Field_to_Change__c == 'Hospitality Sector (HOSP)') { 
          oldvalue = prod.HOSP__c;
        } else if(ecnl.Field_to_Change__c == 'Isolation Included (ISO)') { 
          oldvalue = prod.ISO__c;
        } else if(ecnl.Field_to_Change__c == 'Brand Label Required') { 
          oldvalue = prod.Label_Required__c;
        } else if(ecnl.Field_to_Change__c == 'Product Orientation') { 
          oldvalue = prod.HAND__c;
        } else if(ecnl.Field_to_Change__c == 'Manual or Thermostatic (MANTH)') { 
          oldvalue = prod.MANTH__c;
        } else if(ecnl.Field_to_Change__c == 'Manufactured Structure') { 
          oldvalue = prod.Manufactured_Structure__c;
        } else if(ecnl.Field_to_Change__c == 'Maximum Dynamic Pressure (MDP)') { 
          oldvalue = String.valueOf(prod.MDP__c);
        } else if(ecnl.Field_to_Change__c == 'Maximum Hot Water Supply Temp (MXHOT)') { 
          oldvalue = String.valueOf(prod.MXHOT__c);
        } else if(ecnl.Field_to_Change__c == 'Maximum Static Pressure (MSP)') { 
          oldvalue = String.valueOf(prod.MSP__c);
        } else if(ecnl.Field_to_Change__c == 'Minimum Order Quantity') { 
          oldvalue = String.valueOf(prod.Minimum_Order_Quantity__c);
        } else if(ecnl.Field_to_Change__c == 'New Product Project (PRJCT)') { 
          oldvalue = prod.PRJCT__c;
        } else if(ecnl.Field_to_Change__c == 'New Product Project Year (PRJYR)') { 
          oldvalue = prod.PRJYR__c;
        } else if(ecnl.Field_to_Change__c == 'Number of Handles/Controls') { 
          oldvalue = String.valueOf(prod.CONTS__c);
//        } else if(ecnl.Field_to_Change__c == 'Number of Tap Holes (TAPHO)') { 
//          oldvalue = String.valueOf(prod.TAPHO__c);
        } else if(ecnl.Field_to_Change__c == 'Other Materials') { 
          oldvalue = prod.Other_Materials__c;
        } else if(ecnl.Field_to_Change__c == 'Own Label') { 
          oldvalue = prod.Own_Label__c;
        } else if(ecnl.Field_to_Change__c == 'Packaging Specification') { 
          oldvalue = prod.Packaging_Specification__c;
        } else if(ecnl.Field_to_Change__c == 'Pallet Quantity') { 
          oldvalue = String.valueOf(prod.Pallet_Quantity__c);
        } else if(ecnl.Field_to_Change__c == 'Paper / Cardboard Content') { 
          oldvalue = String.valueOf(prod.Paper_Cardboard__c);
        } else if(ecnl.Field_to_Change__c == 'Parent Products') { 
          oldvalue = prod.Parent_Products__c;
        } else if(ecnl.Field_to_Change__c == 'Phased Shutdown (PSHUT)') { 
          oldvalue = prod.PSHUT__c;
        } else if(ecnl.Field_to_Change__c == 'Planner Code') { 
          oldvalue = prod.Planner_Code__c;
        } else if(ecnl.Field_to_Change__c == 'Plastic/Foam Content') { 
          oldvalue = String.valueOf(prod.Plastic__c);
        } else if(ecnl.Field_to_Change__c == 'Plumbing Systems (SYSTM)') { 
          oldvalue = prod.SYSTM__c;
        } else if(ecnl.Field_to_Change__c == 'Packaged Product Weight (Kg)') { 
          oldvalue = String.valueOf(prod.Product_Kg__c);
        } else if(ecnl.Field_to_Change__c == 'Product Classification') { 
          oldvalue = prod.Product_Classification__c;
        } else if(ecnl.Field_to_Change__c == 'Product Family') { 
          oldvalue = prod.Product_Family__c;
        } else if(ecnl.Field_to_Change__c == 'Product Finish') { 
          oldvalue = prod.Product_Finish__c;
        } else if(ecnl.Field_to_Change__c == 'Product Package Height (mm)') { 
          oldvalue = String.valueOf(prod.Single_Height__c);
        } else if(ecnl.Field_to_Change__c == 'Product Package Length (mm)') { 
          oldvalue = String.valueOf(prod.Single_Length__c);
        } else if(ecnl.Field_to_Change__c == 'Product Package Width (mm)') { 
          oldvalue = String.valueOf(prod.Single_Width__c);
        } else if(ecnl.Field_to_Change__c == 'Product Type (PTYPE)') { 
          oldvalue = prod.PTYPE__c;
        } else if(ecnl.Field_to_Change__c == 'Project No') { 
          oldvalue = prod.Project_No__c;
        } else if(ecnl.Field_to_Change__c == 'Range') { 
          oldvalue = prod.Range__c;
        } else if(ecnl.Field_to_Change__c == 'RRP Inc VAT') { 
          oldvalue = String.valueOf(prod.RRP_Gross__c);
        } else if(ecnl.Field_to_Change__c == 'Rub Clean Handset (RUB)') { 
          oldvalue = prod.RUB__c;
        } else if(ecnl.Field_to_Change__c == 'Sales Group') { 
          oldvalue = prod.Sales_Group_Number__c;
        } else if(ecnl.Field_to_Change__c == 'Shower Technology Type (TTYPE)') { 
          oldvalue = prod.TTYPE__c;
//        } else if(ecnl.Field_to_Change__c == 'Single Flow (SFLOW)') { 
//          oldvalue = prod.SFLOW__c;
        } else if(ecnl.Field_to_Change__c == 'Source') { 
          oldvalue = prod.Source__c;
        } else if(ecnl.Field_to_Change__c == 'Sport & Leisure (SPLES)') { 
          oldvalue = prod.SPLES__c;
        } else if(ecnl.Field_to_Change__c == 'Supplier') { 
          oldvalue = prod.Supplier_Number__c;
        } else if(ecnl.Field_to_Change__c == 'TMV2 Expiry Date (TMV2)') { 
          oldvalue = prod.TMV2__c;
        } else if(ecnl.Field_to_Change__c == 'TMV3 Expiry Date (TMV3)') { 
          oldvalue = prod.TMV3__c;
        } else if(ecnl.Field_to_Change__c == 'Flow Control Valve Type') { 
          oldvalue = prod.VTYPE__c;
        } else if(ecnl.Field_to_Change__c == 'Waste of Electrical Equipment (WEEE)') { 
          oldvalue = prod.WEEE__c;
        } else if(ecnl.Field_to_Change__c == 'Unified Water Label (UWL) Required') { 
          oldvalue = prod.Water_Label_Scheme_WEPLS__c;
//        } else if(ecnl.Field_to_Change__c == 'Web Collection 1') { 
//          oldvalue = prod.WCAT1__c;
        } else if(ecnl.Field_to_Change__c == 'UWL Flow(l/min)/Capacity(ltrs)') { 
          oldvalue = String.valueOf(prod.WFLOW__c);
//        } else if(ecnl.Field_to_Change__c == 'With Waste (WWSTE)') { 
//          oldvalue = prod.WWSTE__c;
        } else if(ecnl.Field_to_Change__c == 'Wood Content') { 
          oldvalue = String.valueOf(prod.Wood__c);
//        } else if(ecnl.Field_to_Change__c == 'Working Pressure Range BAR (PRESS)') { 
//          oldvalue = prod.PRESS__c;
        } else if(ecnl.Field_to_Change__c == 'WRAS Certificate Expiry (WRAS)') { 
          oldvalue = prod.WRAS__c;              
        } else if(ecnl.Field_to_Change__c == 'BEAB Care Required') { 
          oldvalue = prod.BEAB_Care_Required__c;              
        } else if(ecnl.Field_to_Change__c == 'BEAB Control Required') { 
          oldvalue = prod.BEAB_Control_Required__c;              
        } else if(ecnl.Field_to_Change__c == 'Low Voltage Required') { 
          oldvalue = prod.Low_Voltage__c;   
        } else if(ecnl.Field_to_Change__c == 'EMC Directive Required') { 
          oldvalue = prod.EMC_Directive__c; 
        } else if(ecnl.Field_to_Change__c == 'RED Directive Required') { 
          oldvalue = prod.RED_Directive__c; 
        } else if(ecnl.Field_to_Change__c == 'ECO Design Required') { 
          oldvalue = prod.ECO_Design__c;
        } else if(ecnl.Field_to_Change__c == 'EU Timber Regulations Required') { 
          oldvalue = prod.EU_Timber_Regulations__c;       
        } else if(ecnl.Field_to_Change__c == 'Show on Web') { 
          oldvalue = String.ValueOf(prod.Show_on_Web__c);
        } else if(ecnl.Field_to_Change__c == 'Web Title') { 
          oldvalue = prod.Web_Title__c;
        } else if(ecnl.Field_to_Change__c == 'Web Short Title') { 
          oldvalue = prod.Web_Short_Title__c;         
        } else if(ecnl.Field_to_Change__c == 'Web Variant Description') { 
          oldvalue = prod.Web_Variant_Description__c;
        } else if(ecnl.Field_to_Change__c == 'Web Additional Information') { 
          oldvalue = prod.Web_Additional_Information__c;
        } else if(ecnl.Field_to_Change__c == 'Wishlist Description') { 
          oldvalue = prod.Wishlist_Description__c;
        } else if(ecnl.Field_to_Change__c == 'Finish Value') { 
          oldvalue = prod.Finish_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Finish SKUs') { 
          oldvalue = prod.Finish_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Size Value') { 
          oldvalue = prod.Size_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Size SKUs') { 
          oldvalue = prod.Size_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Height Value') { 
          oldvalue = prod.Height_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Height SKUs') { 
          oldvalue = prod.Height_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Taphole Value') { 
          oldvalue = prod.Taphole_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Taphole SKUs') { 
          oldvalue = prod.Taphole_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Hinge Finish Value') { 
          oldvalue = prod.Hinge_Finish_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Hinge Finish SKUs') { 
          oldvalue = prod.Hinge_Finish_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Hinge Function Value') { 
          oldvalue = prod.Hinge_Function_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Hinge Function SKUs') { 
          oldvalue = prod.Hinge_Function_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Left/Right Handed Value') { 
          oldvalue = prod.Left_Right_Handed_Value__c;
        } else if(ecnl.Field_to_Change__c == 'Left/Right Handed SKUs') { 
          oldvalue = prod.Left_Right_Handed_SKUs__c;
        } else if(ecnl.Field_to_Change__c == 'Required Products Search') { 
          oldvalue = prod.Required_Products_Search__c;
        } else if(ecnl.Field_to_Change__c == 'Related Products Search') { 
          oldvalue = prod.Related_Products_Search__c;
        } else if(ecnl.Field_to_Change__c == 'Optional Products Search') { 
          oldvalue = prod.Optional_Products_Search__c;
        } else if(ecnl.Field_to_Change__c == 'Cross Sell Products Search') { 
          oldvalue = prod.Cross_Sell_Products_Search__c;
        } else if(ecnl.Field_to_Change__c == 'Water Label') { 
          oldvalue = prod.Water_Label__c;
        } else if(ecnl.Field_to_Change__c == 'Water Capacity') { 
          oldvalue = String.valueOf(prod.Water_Capacity__c);
        } else if(ecnl.Field_to_Change__c == 'Flush Volume') { 
          oldvalue = String.valueOf(prod.Flush_Volume__c);
        } else if(ecnl.Field_to_Change__c == 'Product Use') { 
          oldvalue = prod.Product_Use__c;
        } else if(ecnl.Field_to_Change__c == 'Sanitaryware Shape') { 
          oldvalue = prod.Sanitaryware_Shape__c;
        } else if(ecnl.Field_to_Change__c == 'Matching Products') { 
          oldvalue = prod.Matching_Products__c;       
        } else if(ecnl.Field_to_Change__c == 'Easyfit') { 
          oldvalue = prod.Easyfit__c;   
        } else if(ecnl.Field_to_Change__c == 'Shower Head Type') { 
          oldvalue = prod.Shower_Head_Type__c;  
        } else if(ecnl.Field_to_Change__c == 'Valve/Control Type') { 
          oldvalue = prod.Valve_Control_Type__c;    
        } else if(ecnl.Field_to_Change__c == 'Handle Shape') { 
          oldvalue = prod.Handle_Shape__c;        
        } else if(ecnl.Field_to_Change__c == 'Power Rating') { 
          oldvalue = prod.Power_Rating__c;  
        } else if(ecnl.Field_to_Change__c == 'Handset Type') { 
          oldvalue = prod.Handset_Type__c;  
        } else if(ecnl.Field_to_Change__c == 'Safety') { 
          oldvalue = prod.Safety__c;    
        } else if(ecnl.Field_to_Change__c == 'Sector') { 
          oldvalue = prod.Sector__c;    
        } else if(ecnl.Field_to_Change__c == 'What Style?') { 
          oldvalue = prod.What_Style__c;    
        } else if(ecnl.Field_to_Change__c == 'Sink Shape') { 
          oldvalue = prod.Sink_Shape__c;    
        } else if(ecnl.Field_to_Change__c == 'TMV2') { 
          oldvalue = prod.TMV2_Web__c;  
        } else if(ecnl.Field_to_Change__c == 'TMV3') { 
          oldvalue = prod.TMV3_Web__c;  
        } else if(ecnl.Field_to_Change__c == 'DO8') { 
          oldvalue = prod.DO8__c;   
        } else if(ecnl.Field_to_Change__c == 'LANTAC') { 
          oldvalue = prod.LANTAC__c;          
        } else if(ecnl.Field_to_Change__c == 'Variant Label 1') { 
          oldvalue = prod.Variant_Label_1__c;       
        } else if(ecnl.Field_to_Change__c == 'Variant Label 2') { 
          oldvalue = prod.Variant_Label_2__c;   
        } else if(ecnl.Field_to_Change__c == 'Variant Label 3') { 
          oldvalue = prod.Variant_Label_3__c;   
        } else if(ecnl.Field_to_Change__c == 'Variant Label 4') { 
          oldvalue = prod.Variant_Label_4__c;   
        } else if(ecnl.Field_to_Change__c == 'Variant Label 5') { 
          oldvalue = prod.Variant_Label_5__c;             
        } else if(ecnl.Field_to_Change__c == 'Variant SKUs 1') { 
          oldvalue = prod.Variant_SKUs_1__c;          
        } else if(ecnl.Field_to_Change__c == 'Variant SKUs 2') { 
          oldvalue = prod.Variant_SKUs_2__c;    
        } else if(ecnl.Field_to_Change__c == 'Variant SKUs 3') { 
          oldvalue = prod.Variant_SKUs_3__c;    
        } else if(ecnl.Field_to_Change__c == 'Variant SKUs 4') { 
          oldvalue = prod.Variant_SKUs_4__c;    
        } else if(ecnl.Field_to_Change__c == 'Variant SKUs 5') { 
          oldvalue = prod.Variant_SKUs_5__c;              
        } else if(ecnl.Field_to_Change__c == 'Variant Value 1') { 
          oldvalue = prod.Variant_Value_1__c;                     
        } else if(ecnl.Field_to_Change__c == 'Variant Value 2') { 
          oldvalue = prod.Variant_Value_2__c;       
        } else if(ecnl.Field_to_Change__c == 'Variant Value 3') { 
          oldvalue = prod.Variant_Value_3__c;       
        } else if(ecnl.Field_to_Change__c == 'Variant Value 4') { 
          oldvalue = prod.Variant_Value_4__c;       
        } else if(ecnl.Field_to_Change__c == 'Variant Value 5') { 
          oldvalue = prod.Variant_Value_5__c;       
        } else if(ecnl.Field_to_Change__c == 'Cost Delivered Currency') { 
          oldvalue = prod.Cost_Delivered_Currency__c;       
        } else if(ecnl.Field_to_Change__c == 'Cost in GBP') { 
          oldvalue = String.ValueOf(prod.Cost_in_GBP__c);       
        } else if(ecnl.Field_to_Change__c == 'Cost Delivered') { 
          oldvalue = String.ValueOf(prod.Cost_Delivered__c);       
        } else if(ecnl.Field_to_Change__c == 'EAN Number') { 
          oldvalue = prod.EAN_Number__c;       
        } else if(ecnl.Field_to_Change__c == 'Sales Part Active?') { 
          oldvalue = String.ValueOf(prod.Sales_Part_Active__c);      
        } else if(ecnl.Field_to_Change__c == 'Supersede Code') { 
          oldvalue = String.ValueOf(prod.Supersede_Code__c);                  
        } else if(ecnl.Field_to_Change__c == 'Sales Price Group') { 
          oldvalue = String.ValueOf(prod.Sales_Price_Group__c);     
        } else if(ecnl.Field_to_Change__c == 'Video Content 1') { 
          oldvalue = prod.Video_Content_1__c;                 
        } else if(ecnl.Field_to_Change__c == 'Video Content 2') { 
          oldvalue = prod.Video_Content_2__c;                 
        } else if(ecnl.Field_to_Change__c == 'Video Content 3') { 
          oldvalue = prod.Video_Content_3__c;                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 1') { 
          oldvalue = prod.USP_Icon_1__c;                                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 2') { 
          oldvalue = prod.USP_Icon_2__c;                                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 3') { 
          oldvalue = prod.USP_Icon_3__c;                                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 4') { 
          oldvalue = prod.USP_Icon_4__c;                                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 5') { 
          oldvalue = prod.USP_Icon_5__c;                                     
        } else if(ecnl.Field_to_Change__c == 'USP Icon 6') { 
          oldvalue = prod.USP_Icon_6__c;                                                                                                                 
        } else if(ecnl.Field_to_Change__c == 'USP Icon 7') { 
          oldvalue = prod.USP_Icon_7__c;               
        } else if(ecnl.Field_to_Change__c == 'USP Icon 8') { 
          oldvalue = prod.USP_Icon_8__c;  
        } else if(ecnl.Field_to_Change__c == 'USP Icon 9') { 
          oldvalue = prod.USP_Icon_9__c;  
        } else if(ecnl.Field_to_Change__c == 'USP Icon 10') { 
          oldvalue = prod.USP_Icon_10__c;                                
        } else if(ecnl.Field_to_Change__c == 'USP Icon 1 Description') { 
          oldvalue = prod.USP_Icon_1_Description__c;                                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'USP Icon 2 Description') { 
          oldvalue = prod.USP_Icon_2_Description__c;                                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'USP Icon 3 Description') { 
          oldvalue = prod.USP_Icon_3_Description__c;                                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'USP Icon 4 Description') { 
          oldvalue = prod.USP_Icon_4_Description__c;                                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'USP Icon 5 Description') { 
          oldvalue = prod.USP_Icon_5_Description__c;                                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'USP Icon 6 Description') { 
          oldvalue = prod.USP_Icon_6_Description__c;                                                                                                                                                                             
        } else if(ecnl.Field_to_Change__c == 'USP Icon 7 Description') { 
          oldvalue = prod.USP_Icon_7_Description__c;                 
        } else if(ecnl.Field_to_Change__c == 'USP Icon 8 Description') { 
          oldvalue = prod.USP_Icon_8_Description__c;  
        } else if(ecnl.Field_to_Change__c == 'USP Icon 9 Description') { 
          oldvalue = prod.USP_Icon_9_Description__c;  
        } else if(ecnl.Field_to_Change__c == 'USP Icon 10 Description') { 
          oldvalue = prod.USP_Icon_10_Description__c;                                
        } else if(ecnl.Field_to_Change__c == 'Customs Stat No') { 
          oldvalue = prod.Customs_Stat_No__c;
        } else if(ecnl.Field_to_Change__c == 'Country of Origin') { 
          oldvalue = prod.Country_of_Origin__c;                    
        } else if(ecnl.Field_to_Change__c == 'Feature 12 (FT12)') { 
          oldvalue = prod.FT12__c;                    
        } else if(ecnl.Field_to_Change__c == 'Feature 13 (FT13)') { 
          oldvalue = prod.FT13__c;                    
        } else if(ecnl.Field_to_Change__c == 'Feature 14 (FT14)') { 
          oldvalue = prod.FT14__c;                    
        } else if(ecnl.Field_to_Change__c == 'Web Tap Holes') { 
          oldvalue = prod.Web_Tap_Holes__c;                    
        } else if(ecnl.Field_to_Change__c == 'Commercial Product') { 
          oldvalue = prod.Commercial_Product__c;                                                                      
        } else if(ecnl.Field_to_Change__c == 'Spares Category') { 
          oldvalue = prod.Spares_Category__c;                                                                      
        } else if(ecnl.Field_to_Change__c == 'Web Finish') { 
          oldvalue = prod.Web_Finish__c;                     
        } else if(ecnl.Field_to_Change__c == 'Hero Copy') { 
          oldvalue = prod.Hero_Copy__c;                     
        } else if(ecnl.Field_to_Change__c == 'Type') { 
          oldvalue = prod.Product_Type__c;                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Web Range') { 
          oldvalue = prod.Web_Range__c;                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Contemporary or Traditional (STYLE)') { 
          oldvalue = prod.STYLE__c;                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Sell on Web') { 
          oldvalue = prod.Sell_on_Web__c;                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Sell on Web Price') { 
          oldvalue = String.valueOf(prod.Sell_on_Web_Price__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Division (DIV)') { 
          oldvalue = String.valueOf(prod.DIV__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Heat and Plumb URL') { 
          oldvalue = String.valueOf(prod.Heat_and_Plumb_URL__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Victorian URL') { 
          oldvalue = String.valueOf(prod.Victorian_URL__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Tapstore URL') { 
          oldvalue = String.valueOf(prod.Tapstore_URL__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'Trading Depot URL') { 
          oldvalue = String.valueOf(prod.Trading_Depot_URL__c);                                                                                                           
        } else if(ecnl.Field_to_Change__c == 'BIM') { 
          oldvalue = String.ValueOf(prod.BIM__c);
        } else if(ecnl.Field_to_Change__c == 'NBS Specification') { 
          oldvalue = String.ValueOf(prod.NBS_Specification__c);
        } else if(ecnl.Field_to_Change__c == 'Add to Website') { 
          oldvalue = String.ValueOf(prod.Add_to_Website__c);            
        } else if(ecnl.Field_to_Change__c == 'Web Ready') { 
          oldvalue = String.ValueOf(prod.Web_Ready__c);   
        } else if(ecnl.Field_to_Change__c == 'Engineering Part Description') { 
          oldvalue = prod.Engineering_Part_Description__c; 
        } else if(ecnl.Field_to_Change__c == 'Product Weight (Kg)') { 
          oldvalue = String.ValueOf(prod.Product_Weight_Kg__c);   
        } else if(ecnl.Field_to_Change__c == 'Pre-set Outlet Temperature') { 
          oldvalue = String.ValueOf(prod.TSTOP__c);   
        } else if(ecnl.Field_to_Change__c == 'Shower Kit') { 
          oldvalue = prod.Shower_Kit__c;   
        } else if(ecnl.Field_to_Change__c == 'Main Construction Material') { 
          oldvalue = prod.Main_Construction_Material__c; 
        } else if(ecnl.Field_to_Change__c == 'Minimum Dynamic Pressure') { 
          oldvalue = String.ValueOf(prod.Minimum_dynamic_Pressure__c);        
        } else if(ecnl.Field_to_Change__c == 'What\'s in the Box?') { 
          oldvalue = prod.Whats_in_the_Box__c;       
        } else if(ecnl.Field_to_Change__c == 'Assembly Required') { 
          oldvalue = prod.Assembly_Required__c;     
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (Min)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_Min__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (Min)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_Min__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (Min)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_Min__c);   
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (Min)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_Min__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR0.2)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR0_2__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR0.2)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR0_2__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR0.2)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR0_2__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR0.2)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR0_2__c);         
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR0.5)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR0_5__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR0.5)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR0_5__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR0.5)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR0_5__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR0.5)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR0_5__c);   
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR1.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR1_0__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR1.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR1_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR1.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR1_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR1.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR1_0__c);   
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR2.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR2_0__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR2.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR2_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR2.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR2_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR2.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR2_0__c);         
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR3.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR3_0__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR3.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR3_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR3.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR3_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR3.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR3_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR4.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR4_0__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR4.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR4_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR4.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR4_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR4.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR4_0__c);
        } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR5.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Handset_l_min_FR5_0__c);      
        } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR5.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Open_Outlet_l_min_FR5_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR5.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Flow_Limiter_l_min_FR5_0__c); 
        } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR5.0)') { 
          oldvalue = String.ValueOf(prod.Flow_through_Fixed_Head_l_min_FR5_0__c);
        } else if(ecnl.Field_to_Change__c == 'Internal Length') { 
          oldvalue = prod.Internal_Length__c; 
        } else if(ecnl.Field_to_Change__c == 'Internal Width') { 
          oldvalue = prod.Internal_Width__c; 
        } else if(ecnl.Field_to_Change__c == 'Height Inc Feet') { 
          oldvalue = prod.Height_Inc_Feet__c;
        } else if(ecnl.Field_to_Change__c == 'Height Max') { 
          oldvalue = prod.Height_Max__c;
        } else if(ecnl.Field_to_Change__c == 'Height Min') { 
          oldvalue = prod.Height_Min__c;
        } else if(ecnl.Field_to_Change__c == 'Full Height') { 
          oldvalue = prod.Full_Height__c;
        } else if(ecnl.Field_to_Change__c == 'Full Projection') { 
          oldvalue = prod.Full_Projection__c;
        } else if(ecnl.Field_to_Change__c == 'Overflow to Waste') { 
          oldvalue = prod.Overflow_to_Waste__c;
        } else if(ecnl.Field_to_Change__c == 'Spout Projection') { 
          oldvalue = prod.Spout_Projection__c;
//        } else if(ecnl.Field_to_Change__c == 'Spout Projection (mm)') { 
//          oldvalue = String.valueOf(prod.Spout_Projection_mm__c);          
        } else if(ecnl.Field_to_Change__c == 'Valve') { 
          oldvalue = prod.Valve__c;
        } else if(ecnl.Field_to_Change__c == 'Inlet Centres') { 
          oldvalue = prod.Inlet_Centres__c;
        } else if(ecnl.Field_to_Change__c == 'Hose Length') { 
          oldvalue = prod.Hose_Length__c;
        } else if(ecnl.Field_to_Change__c == 'Surface Mounted') { 
          oldvalue = prod.Surface_Mounted__c;         
        } else if(ecnl.Field_to_Change__c == 'Recessed') { 
          oldvalue = prod.Recessed__c;
        } else if(ecnl.Field_to_Change__c == 'Valve Centres') { 
          oldvalue = String.ValueOf(prod.Valve_Centres__c);
        } else if(ecnl.Field_to_Change__c == 'Wall to Valve Centre') { 
          oldvalue = String.ValueOf(prod.Wall_to_Valve_Centre__c);
        } else if(ecnl.Field_to_Change__c == 'Output') { 
          oldvalue = prod.Output__c;
        } else if(ecnl.Field_to_Change__c == 'Description') { 
          oldvalue = prod.Description__c;         
        } else if(ecnl.Field_to_Change__c == 'Additional Information') { 
          oldvalue = prod.Additional_Information__c;
        } else if(ecnl.Field_to_Change__c == 'P&P Range') { 
          oldvalue = prod.P_P_Range__c;
        } else if(ecnl.Field_to_Change__c == 'Section') { 
          oldvalue = prod.Section__c;
        } else if(ecnl.Field_to_Change__c == 'Sub Section') { 
          oldvalue = prod.Sub_Section__c;
        } else if(ecnl.Field_to_Change__c == 'Variant Header') { 
          oldvalue = prod.Variant_Header__c;
        } else if(ecnl.Field_to_Change__c == 'Accelerator Product') { 
          oldvalue = String.ValueOf(prod.Accelerator_Product__c);
        } else if(ecnl.Field_to_Change__c == 'Accelerator Category') { 
          oldvalue = prod.Accelerator_Category__c;
        } else if(ecnl.Field_to_Change__c == 'Accelerator Range') { 
          oldvalue = prod.Accelerator_Range__c;
        } else if(ecnl.Field_to_Change__c == 'Accelerator Title') { 
          oldvalue = prod.Accelerator_Title__c;
        } else if(ecnl.Field_to_Change__c == 'Accelerator Title 2') { 
          oldvalue = prod.Accelerator_Title_2__c;
        } else if(ecnl.Field_to_Change__c == 'Description Line 1') { 
          oldvalue = prod.Description_Line_1__c;
        } else if(ecnl.Field_to_Change__c == 'Description Line 2') { 
          oldvalue = prod.Description_Line_2__c;
        } else if(ecnl.Field_to_Change__c == 'Description Line 3') { 
          oldvalue = prod.Description_Line_3__c;
        } else if(ecnl.Field_to_Change__c == 'Description Line 4') { 
          oldvalue = prod.Description_Line_4__c;
        } else if(ecnl.Field_to_Change__c == 'Description Line 5') { 
          oldvalue = prod.Description_Line_5__c;
        } else if(ecnl.Field_to_Change__c == 'Accelerator Intro Paragraph') { 
          oldvalue = prod.Accelerator_Intro_Paragraph__c;
        } else if(ecnl.Field_to_Change__c == 'Paragraph Line 1') { 
          oldvalue = prod.Paragraph_Line_1__c;
        } else if(ecnl.Field_to_Change__c == 'Paragraph Line 2') { 
          oldvalue = prod.Paragraph_Line_2__c;
        } else if(ecnl.Field_to_Change__c == 'Paragraph Line 3') { 
          oldvalue = prod.Paragraph_Line_3__c;        
        } else if(ecnl.Field_to_Change__c == 'Bath Feet Type') { 
          oldvalue = prod.Bath_Feet_Type__c;
        } else if(ecnl.Field_to_Change__c == 'Bath Feet Type 2') { 
          oldvalue = prod.Bath_Feet_Type_2__c;        
        } else if(ecnl.Field_to_Change__c == 'Solid Skin') { 
          oldvalue = String.ValueOf(prod.Solid_Skin__c);
        } else if(ecnl.Field_to_Change__c == 'Single or Double Ended') { 
          oldvalue = prod.Single_or_Double_Ended__c;
        } else if(ecnl.Field_to_Change__c == 'A4 Description') { 
          oldvalue = prod.A4_Description__c;          
        } else if(ecnl.Field_to_Change__c == 'Product Benefits') { 
          oldvalue = prod.Product_Benefits__c;        
        } else if(ecnl.Field_to_Change__c == 'Title') { 
          oldvalue = prod.Title__c;  
        } else if(ecnl.Field_to_Change__c == 'Title Short') { 
          oldvalue = prod.Title_Short__c;  
        } else if(ecnl.Field_to_Change__c == 'Variant Description') { 
          oldvalue = prod.Variant_Description__c;            
        } else if(ecnl.Field_to_Change__c == 'P&P New Price (ex VAT)') { 
          oldvalue = String.valueOf(prod.P_P_New_Price_ex_VAT__c);
        } else if(ecnl.Field_to_Change__c == 'P&P New Price (inc VAT)') { 
          oldvalue = String.valueOf(prod.P_P_New_Price_inc_VAT__c);
        } else if(ecnl.Field_to_Change__c == 'Specifier Title') { 
          oldvalue = prod.Specifier_Title__c;  
        } else if(ecnl.Field_to_Change__c == 'Specify Description') { 
          oldvalue = prod.Specify_Description__c;  
        } else if(ecnl.Field_to_Change__c == 'Specify As') { 
          oldvalue = prod.Specify_As__c;  
        } else if(ecnl.Field_to_Change__c == 'Recommended Items') { 
          oldvalue = prod.Recommended_Items__c;  
        } else if(ecnl.Field_to_Change__c == 'Add to P&P') { 
          oldvalue = String.ValueOf(prod.Add_to_P_P__c);  
        } else if(ecnl.Field_to_Change__c == 'P&P Ready') { 
          oldvalue = String.ValueOf(prod.P_P_Ready__c);                      
        } else if(ecnl.Field_to_Change__c == 'Build Timings') { 
          oldvalue = String.valueOf(prod.Build_Timings__c);  
        } else if(ecnl.Field_to_Change__c == 'Ireland Euro (€) inc VAT') { 
          oldvalue = String.valueOf(prod.Ireland_Euro_inc_VAT__c);
        } else if(ecnl.Field_to_Change__c == 'Northern Ireland GBP (£) inc VAT') { 
          oldvalue = String.valueOf(prod.Northern_Ireland_GBP_inc_VAT__c);
        } else if(ecnl.Field_to_Change__c == 'Component?') { 
          oldvalue = String.valueOf(prod.Component__c);
        } else if(ecnl.Field_to_Change__c == 'Inventory Only?') { 
          oldvalue = String.valueOf(prod.Inventory_Only__c);
        } else if(ecnl.Field_to_Change__c == 'EU REACH Regulation') { 
          oldvalue = prod.EU_REACH_Regulation__c;
        } else if(ecnl.Field_to_Change__c == 'UK Water Regulation Compliance') { 
          oldvalue = prod.UK_Water_Regulation_Compliance__c;
        } else if(ecnl.Field_to_Change__c == 'Low Voltage Compliant') { 
          oldvalue = String.valueOf(prod.Low_Voltage_Compliant__c);
        } else if(ecnl.Field_to_Change__c == 'CE Approval Certificate No') { 
          oldvalue = prod.CE_Approval_Certificate_No__c;
        } else if(ecnl.Field_to_Change__c == 'EMC Directive Compliant') { 
          oldvalue = String.valueOf(prod.EMC_Directive_Compliant__c);
        } else if(ecnl.Field_to_Change__c == 'Red Directive Compliant') { 
          oldvalue = String.valueOf(prod.Red_Directive_Compliant__c);
        } else if(ecnl.Field_to_Change__c == 'ECO Design Compliant') { 
          oldvalue = String.valueOf(prod.ECO_Design_Compliant__c);
        } else if(ecnl.Field_to_Change__c == 'Energy Label') { 
          oldvalue = String.valueOf(prod.Energy_Label_Check__c);
        } else if(ecnl.Field_to_Change__c == 'EUTR Certificate No') { 
          oldvalue = prod.EUTR_Certificate_No__c;
        } else if(ecnl.Field_to_Change__c == 'REACH Statement') { 
          oldvalue = String.valueOf(prod.REACH_Statement__c);
        } else if(ecnl.Field_to_Change__c == 'UK Water Regulation Approved (Y/N)') { 
          oldvalue = String.valueOf(prod.UK_Water_Regulation_Approved__c);
        } else if(ecnl.Field_to_Change__c == 'Energy Label Required') { 
          oldvalue = String.valueOf(prod.Energy_Label__c);
        }
        else {
          oldValue = '' ;
        }
        
        ecnl.Old_Value__c = oldValue;
        system.debug('oldValue: ' + oldValue);

    }
}