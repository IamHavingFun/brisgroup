trigger ECNUpdateProductFields on ECN__c (before insert, before update) {

    for (ECN__c ecn : Trigger.new)
    {
        String ecnId = ecn.Id;
        Product__c proddata = [SELECT ID, OwnerID from Product__c where ID = :ecn.Product__c];
        String PASId = proddata.ID;
        ID PASOwner = proddata.OwnerID;
        ecn.PAS_Owner__c = PASOwner;  

        if(ecn.Status__c=='New' || ecn.Status__c=='Rejected' || ecn.Status__c=='Awaiting Finance Approval')
        {
            list<ECN_Line__c> lines = [SELECT Id, Field_to_Change__c, New_Value__c, Old_Value__c, ECN__r.Product__r.OwnerID from ECN_Line__c where ECN__c = :ecnId];
            for(ECN_Line__c line : lines)
            {
              // Loop and update all lines on an ECN at New status when the ECN is saved
              // This is to retrigger the 'fetch old value' trigger so that the correct value is pulled when changing the product on a cloned ECN
              line.Old_Value__c = '';
              update line;
              ecn.PAS_Owner__c = PASOwner ;            
            }
            ecn.PAS_Owner__c = PASOwner ;            
        }    
        if(ecn.Status__c == 'Completed')
        {
            system.debug('*****Trigger UpdateProductFields ECN ID: ' + ecnId);
            String prodId = ecn.Product__c;
            system.debug('*****Trigger UpdateProductFields Product ID: ' + prodId);         
            String objectName = 'Product__c';
            String query = 'SELECT';
            Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
            for(String s : objectFields.keySet()) {
            query += ' ' + s + ',';
            }
            if (query.subString(query.Length()-1,query.Length()) == ','){
                query = query.subString(0,query.Length()-1);
            }
            query += ' FROM Product__c';
            query += ' WHERE Id = :prodId LIMIT 1'; 
  
            Product__c prod = database.query(query);
                
            list<ECN_Line__c> el = [SELECT Id, Field_to_Change__c, New_Value__c from ECN_Line__c where ECN__c = :ecnId];
            system.debug('ECN Lines: ' + el.size());
            
            if(ecn.Type__c == 'Discontinuation')
                prod.Discontinuation_Effective_Date__c = ecn.Effective_Date__c;
        
            for(ECN_Line__c ecnl : el)
            {
                if(ecnl.Field_to_Change__c == 'Long Part Description') {
                    prod.Long_Part_Description__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Short Part Description') { 
                    prod.Short_Part_Description__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Lead Time (Days)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Lead_Time__c = null; 
                    else 
                        prod.Lead_Time__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Accounting Group') { 
                    prod.Accounting_Group__c = ecnl.New_Value__c;
//                } else if(ecnl.Field_to_Change__c == 'Adjustable Brackets (ABRAC)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.ABRAC__c = null; 
//                    else                
//                        prod.ABRAC__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Additional Comments and Information') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Additional_Comment_and_Information__c = null; 
                    else                
                        prod.Additional_Comment_and_Information__c = ecnl.New_Value__c;                        
                } else if(ecnl.Field_to_Change__c == 'BEAB Control (BEAB)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEAB__c = null; 
                    else                    
                        prod.BEAB__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'BEAB Care (BEABC)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEABC__c = null; 
                    else                        
                        prod.BEABC__c = ecnl.New_Value__c;                    
                } else if(ecnl.Field_to_Change__c == 'BEAB EMC Certificate Expiry (BEABE)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEABE__c = null; 
                    else                        
                        prod.BEABE__c = ecnl.New_Value__c;                    
                } else if(ecnl.Field_to_Change__c == 'BEAB Safety Certificate Expiry (BEABS)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEABS__c = null; 
                    else                        
                        prod.BEABS__c = ecnl.New_Value__c;                    
//                } else if(ecnl.Field_to_Change__c == 'Brass Product (BRASS)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.BRASS__c = null; 
//                    else                        
//                        prod.BRASS__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Case Quantity') { 
                    prod.Case_Quantity__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'CE Marking Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.CE_Marking__c = null; 
                    else                    
                        prod.CE_Marking__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Check Valve Supplied (CHECK)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.CHECK__c = null; 
                    else                
                        prod.CHECK__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Commodity Code') { 
                    prod.Commodity_Code__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Commodity Code 2 (COMC2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.COMC2__c = null; 
                    else                    
                        prod.COMC2__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Connection Inlet (INLET)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.INLET__c = null; 
                    else                        
                        prod.INLET__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Connection Outlet (OUTLT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.OUTLT__c = null; 
                    else                    
                        prod.OUTLT__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Mounting Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.MOUNT__c = null; 
                    else                        
                        prod.MOUNT__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Flow Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.DFLOW__c = null; 
                    else                        
                        prod.DFLOW__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'EAN Number') { 
                    if(ecnl.New_Value__c == null) 
                        prod.EAN_Number__c = null; 
                    else                        
                        prod.EAN_Number__c = ecnl.New_Value__c;
//                } else if(ecnl.Field_to_Change__c == 'Fast Fix (FSTFX)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.FSTFX__c = null; 
//                    else                        
//                        prod.FSTFX__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 1 (FT1)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT1__c = null; 
                    else                        
                        prod.FT1__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 10 (FT10)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT10__c = null; 
                    else                    
                        prod.FT10__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 11 (FT11)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT11__c = null; 
                    else                        
                        prod.FT11__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 2 (FT2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT2__c = null; 
                    else                        
                        prod.FT2__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 3 (FT3)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT3__c = null; 
                    else                        
                        prod.FT3__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 4 (FT4)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT4__c = null; 
                    else                        
                        prod.FT4__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 5 (FT5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT5__c = null; 
                    else                                        
                        prod.FT5__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 6 (FT6)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT6__c = null; 
                    else                    
                        prod.FT6__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 7 (FT7)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT7__c = null; 
                    else                        
                        prod.FT7__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 8 (FT8)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT8__c = null; 
                    else                        
                        prod.FT8__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Feature 9 (FT9)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT9__c = null; 
                    else                        
                        prod.FT9__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Fitting Instructions Brand') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Fitting_Instructions_Brand__c = null; 
                    else                    
                        prod.Fitting_Instructions_Brand__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Minimum Flow Rate') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR0_1__c = null; 
                    else                        
                        prod.FR0_1__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR0.2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR0_2__c = null; 
                    else                        
                        prod.FR0_2__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR0.5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR0_5__c = null; 
                    else                        
                        prod.FR0_5__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR1.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR1_0__c = null; 
                    else                        
                        prod.FR1_0__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR2.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR2_0__c = null; 
                    else                        
                        prod.FR2_0__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR3.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR3_0__c = null; 
                    else                        
                        prod.FR3_0__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR4.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR4_0__c = null; 
                    else                        
                        prod.FR4_0__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate (FR5.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FR5_0__c = null; 
                    else                
                        prod.FR5_0__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow Rate l/m (Open Outlet) (FLOW)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FLOW__c = null; 
                    else 
                        prod.FLOW__c = Decimal.valueOf(ecnl.New_Value__c); 
                } else if(ecnl.Field_to_Change__c == 'Glass Content') { 
                    prod.Glass__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Guarantee') { 
                    prod.Guarantee__c = ecnl.New_Value__c;
//                } else if(ecnl.Field_to_Change__c == 'Handle Type (HANDT)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.HANDT__c = null; 
//                    else                        
//                        prod.HANDT__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Healthcare (HEAL)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.HEAL__c = null; 
                    else                    
                        prod.HEAL__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hospitality Sector (HOSP)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.HOSP__c = null; 
                    else                        
                        prod.HOSP__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Isolation Included (ISO)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.ISO__c = null; 
                    else                        
                        prod.ISO__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Brand Label Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Label_Required__c = null; 
                    else                    
                        prod.Label_Required__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Orientation') { 
                    if(ecnl.New_Value__c == null) 
                        prod.HAND__c = null; 
                    else                        
                        prod.HAND__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Manual or Thermostatic (MANTH)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.MANTH__c = null; 
                    else                        
                        prod.MANTH__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Manufactured Structure') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Manufactured_Structure__c = null; 
                    else                        
                        prod.Manufactured_Structure__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Maximum Dynamic Pressure (MDP)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.MDP__c = null; 
                    else                        
                        prod.MDP__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Maximum Hot Water Supply Temp (MXHOT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.MXHOT__c = null; 
                    else                        
                        prod.MXHOT__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Maximum Static Pressure (MSP)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.MSP__c = null; 
                    else                        
                        prod.MSP__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Minimum Order Quantity') { 
                    prod.Minimum_Order_Quantity__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'New Product Project (PRJCT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.PRJCT__c = null; 
                    else                        
                        prod.PRJCT__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'New Product Project Year (PRJYR)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.PRJYR__c = null; 
                    else                        
                        prod.PRJYR__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Number of Handles/Controls') { 
                    if(ecnl.New_Value__c == null) 
                        prod.CONTS__c = null; 
                    else                            
                        prod.CONTS__c = Decimal.valueOf(ecnl.New_Value__c);
//                } else if(ecnl.Field_to_Change__c == 'Number of Tap Holes (TAPHO)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.TAPHO__c = null; 
//                    else                        
//                        prod.TAPHO__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Other Materials') { 
                    prod.Other_Materials__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Own Label') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Own_Label__c = null; 
                    else                        
                        prod.Own_Label__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Packaging Specification') { 
                    prod.Packaging_Specification__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Pallet Quantity') { 
                    prod.Pallet_Quantity__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Paper / Cardboard Content') { 
                    prod.Paper_Cardboard__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Parent Products') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Parent_Products__c = null; 
                    else                        
                        prod.Parent_Products__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Phased Shutdown (PSHUT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.PSHUT__c = null; 
                    else                        
                        prod.PSHUT__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Planner Code') { 
                    prod.Planner_Code__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Plastic/Foam Content') { 
                    prod.Plastic__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Plumbing Systems (SYSTM)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.SYSTM__c = null; 
                    else                        
                        prod.SYSTM__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Packaged Product Weight (kg)') { 
                    prod.Product_Kg__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Product Classification') { 
                    prod.Product_Classification__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Family') { 
                    prod.Product_Family__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Finish') { 
                    prod.Product_Finish__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Package Height (mm)') { 
                    prod.Single_Height__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Product Package Length (mm)') { 
                    prod.Single_Length__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Product Package Width (mm)') { 
                    prod.Single_Width__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Product Type (PTYPE)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.PTYPE__c = null; 
                    else                        
                        prod.PTYPE__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Project No') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Project_No__c = null; 
                    else                    
                        prod.Project_No__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Range') { 
                    prod.Range__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'RRP Inc VAT') { 
                    prod.RRP_Gross__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Rub Clean Handset (RUB)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.RUB__c = null; 
                    else                    
                        prod.RUB__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Sales Group') {    
                    String key = ecnl.New_Value__c;
                    Sales_Group__c sg = [SELECT Id from Sales_Group__c WHERE Key__c = :key LIMIT 1];
                    prod.Sales_Group__c = sg.Id;
                } else if(ecnl.Field_to_Change__c == 'Sales Part Active?') { 
                    prod.Sales_Part_Active__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Shower Technology Type (TTYPE)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TTYPE__c = null; 
                    else                        
                        prod.TTYPE__c = ecnl.New_Value__c;
//                } else if(ecnl.Field_to_Change__c == 'Single Flow (SFLOW)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.SFLOW__c = null; 
//                    else                        
//                        prod.SFLOW__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Source') { 
                    prod.Source__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Sport & Leisure (SPLES)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.SPLES__c = null; 
                    else                        
                        prod.SPLES__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Supplier') {
                    if(ecnl.New_Value__c == null) 
                        prod.Supplier__c = null; 
                    else {
                        String supkey = ecnl.New_Value__c;
                        Supplier__c sup = [SELECT Id from Supplier__c WHERE Key__c = :supkey LIMIT 1];
                        prod.Supplier__c = sup.Id; }
                } else if(ecnl.Field_to_Change__c == 'TMV2 Expiry Date (TMV2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV2__c = null; 
                    else                    
                        prod.TMV2__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'TMV3 Expiry Date (TMV3)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV3__c = null; 
                    else                        
                        prod.TMV3__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Flow Control Valve Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.VTYPE__c = null; 
                    else                        
                        prod.VTYPE__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Waste of Electrical Equipment (WEEE)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.WEEE__c = null; 
                    else                        
                        prod.WEEE__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Unified Water Label (UWL) Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Water_Label_Scheme_WEPLS__c = null; 
                    else                        
                        prod.Water_Label_Scheme_WEPLS__c = ecnl.New_Value__c;
//                } else if(ecnl.Field_to_Change__c == 'Web Collection 1') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.WCAT1__c = null; 
//                    else                        
//                        prod.WCAT1__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'UWL Flow(l/min)/Capacity(ltrs)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.WFLOW__c = null; 
                    else                        
                        prod.WFLOW__c = Decimal.valueOf(ecnl.New_Value__c);
//                } else if(ecnl.Field_to_Change__c == 'With Waste (WWSTE)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.WWSTE__c = null; 
//                    else                        
//                        prod.WWSTE__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Wood Content') { 
                    prod.Wood__c = Decimal.valueOf(ecnl.New_Value__c);
//                } else if(ecnl.Field_to_Change__c == 'Working Pressure Range BAR (PRESS)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.PRESS__c = null; 
//                    else                        
//                        prod.PRESS__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'WRAS Certificate Expiry (WRAS)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.WRAS__c = null; 
                    else                
                        prod.WRAS__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'BEAB Care Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEAB_Care_Required__c = null; 
                    else                        
                        prod.BEAB_Care_Required__c = ecnl.New_Value__c;             
                } else if(ecnl.Field_to_Change__c == 'BEAB Control Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEAB_Control_Required__c = null; 
                    else                        
                        prod.BEAB_Control_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'BEAB EMC Approval Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEAB_EMC_Approval_Required__c = null; 
                    else                        
                        prod.BEAB_EMC_Approval_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'BEAB Safety Approval Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.BEAB_Safety_Approval_Required__c = null; 
                    else                        
                        prod.BEAB_Safety_Approval_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'CS Drawing Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.CS_Drawing_Required__c = null; 
                    else                        
                        prod.CS_Drawing_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Fitting Instructions Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Fitting_Instructions_Required__c = null; 
                    else                        
                        prod.Fitting_Instructions_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Declaration of Conformity Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Declaration_of_Conformity_Required__c = null; 
                    else                        
                        prod.Declaration_of_Conformity_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Image Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Image_Required__c = null; 
                    else                        
                        prod.Image_Required__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Low Voltage Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Low_Voltage__c = null; 
                    else                            
                        prod.Low_Voltage__c = ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'EMC Directive Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.EMC_Directive__c = null; 
                    else                        
                        prod.EMC_Directive__c = ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'RED Directive Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.RED_Directive__c = null; 
                    else                    
                        prod.RED_Directive__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'ECO Design Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.ECO_Design__c = null; 
                    else                        
                        prod.ECO_Design__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'EU Timber Regulations Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.EU_Timber_Regulations__c = null; 
                    else                        
                        prod.EU_Timber_Regulations__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Show on Web') { 
                    prod.Show_on_Web__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Web Title') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Title__c = null; 
                    else                        
                        prod.Web_Title__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Web Short Title') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Short_Title__c = null; 
                    else                        
                        prod.Web_Short_Title__c = ecnl.New_Value__c;        
                } else if(ecnl.Field_to_Change__c == 'Web Variant Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Variant_Description__c = null; 
                    else                        
                        prod.Web_Variant_Description__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Web Additional Information') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Additional_Information__c = null; 
                    else                        
                        prod.Web_Additional_Information__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Wishlist Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Wishlist_Description__c = null; 
                    else                    
                        prod.Wishlist_Description__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Finish Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Finish_Value__c = null; 
                    else                        
                        prod.Finish_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Finish SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Finish_SKUs__c = null; 
                    else                        
                        prod.Finish_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Size Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Size_Value__c = null; 
                    else                            
                        prod.Size_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Size SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Size_SKUs__c = null; 
                    else                        
                        prod.Size_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Height Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Height_Value__c = null; 
                    else                    
                        prod.Height_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Height SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Height_SKUs__c = null; 
                    else                    
                        prod.Height_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Taphole Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Taphole_Value__c = null; 
                    else                            
                        prod.Taphole_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Taphole SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Taphole_SKUs__c = null; 
                    else                        
                        prod.Taphole_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hinge Finish Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hinge_Finish_Value__c = null; 
                    else                    
                        prod.Hinge_Finish_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hinge Finish SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hinge_Finish_SKUs__c = null; 
                    else                        
                        prod.Hinge_Finish_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hinge Function Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hinge_Function_Value__c = null; 
                    else                        
                        prod.Hinge_Function_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hinge Function SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hinge_Function_SKUs__c = null; 
                    else                            
                        prod.Hinge_Function_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Left/Right Handed Value') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Left_Right_Handed_Value__c = null; 
                    else                            
                        prod.Left_Right_Handed_Value__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Left/Right Handed SKUs') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Left_Right_Handed_SKUs__c = null; 
                    else                            
                        prod.Left_Right_Handed_SKUs__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Required Products Search') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Required_Products_Search__c = null; 
                    else                        
                        prod.Required_Products_Search__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Related Products Search') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Related_Products_Search__c = null; 
                    else                            
                        prod.Related_Products_Search__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Optional Products Search') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Optional_Products_Search__c = null; 
                    else                
                        prod.Optional_Products_Search__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Cross Sell Products Search') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Cross_Sell_Products_Search__c = null; 
                    else                    
                        prod.Cross_Sell_Products_Search__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Water Label') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Water_Label__c = null; 
                    else                    
                        prod.Water_Label__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Water Capacity') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Water_Capacity__c = null; 
                    else                
                        prod.Water_Capacity__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flush Volume') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flush_Volume__c = null; 
                    else                        
                        prod.Flush_Volume__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Product Use') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Use__c = null; 
                    else                    
                        prod.Product_Use__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Sanitaryware Shape') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sanitaryware_Shape__c = null; 
                    else                    
                        prod.Sanitaryware_Shape__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Matching Products') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Matching_Products__c = null; 
                    else                        
                        prod.Matching_Products__c = ecnl.New_Value__c;       
                } else if(ecnl.Field_to_Change__c == 'Easyfit') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Easyfit__c = null; 
                    else                    
                        prod.Easyfit__c = ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'Shower Head Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Shower_Head_Type__c = null; 
                    else                    
                        prod.Shower_Head_Type__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Valve/Control Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Valve_Control_Type__c = null; 
                    else                    
                        prod.Valve_Control_Type__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Handle Shape') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Handle_Shape__c = null; 
                    else                    
                        prod.Handle_Shape__c = ecnl.New_Value__c;     
                } else if(ecnl.Field_to_Change__c == 'Power Rating') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Power_Rating__c = null; 
                    else                    
                        prod.Power_Rating__c = ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'Handset Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Handset_Type__c = null; 
                    else                        
                        prod.Handset_Type__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Safety') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Safety__c = null; 
                    else                
                        prod.Safety__c = ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'Sector') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sector__c = null; 
                    else                    
                        prod.Sector__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'What Style?') { 
                    if(ecnl.New_Value__c == null) 
                        prod.What_Style__c = null; 
                    else                    
                        prod.What_Style__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Sink Shape') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sink_Shape__c = null; 
                    else                    
                        prod.Sink_Shape__c = ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'TMV2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV2_Web__c = null; 
                    else                
                        prod.TMV2_Web__c = ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'TMV3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV3_Web__c = null; 
                    else                    
                        prod.TMV3_Web__c = ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'DO8') { 
                    if(ecnl.New_Value__c == null) 
                        prod.DO8__c = null; 
                    else                
                        prod.DO8__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'LANTAC') { 
                    if(ecnl.New_Value__c == null) 
                        prod.LANTAC__c = null; 
                    else                
                        prod.LANTAC__c = ecnl.New_Value__c;          
                } else if(ecnl.Field_to_Change__c == 'Variant Label 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Label_1__c = null; 
                    else                    
                        prod.Variant_Label_1__c = ecnl.New_Value__c;       
                } else if(ecnl.Field_to_Change__c == 'Variant Label 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Label_2__c = null; 
                    else                
                        prod.Variant_Label_2__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Variant Label 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Label_3__c = null; 
                    else                    
                        prod.Variant_Label_3__c = ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'Variant Label 4') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Label_4__c = null; 
                    else                
                        prod.Variant_Label_4__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Variant Label 5') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Label_5__c = null; 
                    else                
                        prod.Variant_Label_5__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Variant SKUs 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_SKUs_1__c = null; 
                    else                
                        prod.Variant_SKUs_1__c = ecnl.New_Value__c;         
                } else if(ecnl.Field_to_Change__c == 'Variant SKUs 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_SKUs_2__c = null; 
                    else                    
                        prod.Variant_SKUs_2__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Variant SKUs 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_SKUs_3__c = null; 
                    else                    
                        prod.Variant_SKUs_3__c = ecnl.New_Value__c;    
                } else if(ecnl.Field_to_Change__c == 'Variant SKUs 4') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_SKUs_4__c = null; 
                    else                
                        prod.Variant_SKUs_4__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Variant SKUs 5') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_SKUs_5__c = null; 
                    else                
                        prod.Variant_SKUs_5__c = ecnl.New_Value__c;            
                } else if(ecnl.Field_to_Change__c == 'Variant Value 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Value_1__c = null; 
                    else                
                        prod.Variant_Value_1__c = ecnl.New_Value__c;                    
                } else if(ecnl.Field_to_Change__c == 'Variant Value 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Value_2__c = null; 
                    else                
                        prod.Variant_Value_2__c = ecnl.New_Value__c;     
                } else if(ecnl.Field_to_Change__c == 'Variant Value 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Value_3__c = null; 
                    else                
                        prod.Variant_Value_3__c = ecnl.New_Value__c;       
                } else if(ecnl.Field_to_Change__c == 'Variant Value 4') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Value_4__c = null; 
                    else                    
                        prod.Variant_Value_4__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Variant Value 5') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Value_5__c = null; 
                    else                    
                        prod.Variant_Value_5__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Cost Delivered') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Cost_Delivered__c = null; 
                    else                    
                        prod.Cost_Delivered__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Cost in GBP') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Cost_in_GBP__c = null; 
                    else                    
                        prod.Cost_in_GBP__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Cost Delivered Currency') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Cost_Delivered_Currency__c = null; 
                    else                    
                        prod.Cost_Delivered_Currency__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Product Depth (mm)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Depth_mm__c = null; 
                    else                    
                        prod.Product_Depth_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Product Height (mm)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Height_mm__c = null; 
                    else                    
                        prod.Product_Height_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Product Width (mm)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Width_mm__c = null; 
                    else                    
                        prod.Product_Width_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Riser Length (mm)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Riser_Length_mm__c = null; 
                    else                    
                        prod.Riser_Length_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Spout Height (mm)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Spout_Height_mm__c = null; 
                    else                    
                        prod.Spout_Height_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
//                } else if(ecnl.Field_to_Change__c == 'Spout Projection (mm)') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.Spout_Projection_mm__c = null; 
//                    else                    
//                        prod.Spout_Projection_mm__c = Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'QC Sheet Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.QC_Sheet_Required__c = null; 
                    else                    
                        prod.QC_Sheet_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'ROHS Expiry Date (ROHS)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.ROHS__c = null; 
                    else                    
                        prod.ROHS__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'ROHS Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.ROHS_Required__c = null; 
                    else                    
                        prod.ROHS_Required__c = ecnl.New_Value__c;      
//                } else if(ecnl.Field_to_Change__c == 'Spare Parts Required') { 
//                    if(ecnl.New_Value__c == null) 
//                        prod.Spare_Parts_Required__c = null; 
//                    else                    
//                        prod.Spare_Parts_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Supplier Drawing Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Supplier_Drawing_Required__c = null; 
                    else                    
                        prod.Supplier_Drawing_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Supplier Etching') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Supplier_Etching__c = null; 
                    else                    
                        prod.Supplier_Etching__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Supplier Etching ID Marking') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Supplier_Etching_ID_Marking__c = null; 
                    else                    
                        prod.Supplier_Etching_ID_Marking__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Technical Construction File Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Technical_Construction_File_Required__c = null; 
                    else                    
                        prod.Technical_Construction_File_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Technical Data Sheet Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Technical_Data_Sheet_Required__c = null; 
                    else                    
                        prod.Technical_Data_Sheet_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Test Report Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Test_Report_Required__c = null; 
                    else                    
                        prod.Test_Report_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'TMV2 Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV2_Required__c = null; 
                    else                    
                        prod.TMV2_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'TMV3 Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TMV3_Required__c = null; 
                    else                    
                        prod.TMV3_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'WEEE Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.WEEE_Required__c = null; 
                    else                    
                        prod.WEEE_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'WRAS Approval Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.WRAS_Approval_Required__c = null; 
                    else                    
                        prod.WRAS_Approval_Required__c = ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Supersede Code') { 
                    if(ecnl.New_Value__c == null) {
                        prod.Supersede_Code__c = null; 
                        prod.Supersede_Date__c = null;
                    }
                    else {
                        prod.Supersede_Code__c= ecnl.New_Value__c;
                        prod.Supersede_Date__c = ecn.Effective_Date__c;
                    }
                } else if(ecnl.Field_to_Change__c == 'Sales Price Group') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sales_Price_Group__c= null; 
                    else                    
                        prod.Sales_Price_Group__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Video Content 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Video_Content_1__c= null; 
                    else                    
                        prod.Video_Content_1__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Video Content 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Video_Content_2__c= null; 
                    else                    
                        prod.Video_Content_2__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Video Content 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Video_Content_3__c= null; 
                    else                    
                        prod.Video_Content_3__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_1__c= null; 
                    else                    
                        prod.USP_Icon_1__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_2__c= null; 
                    else                    
                        prod.USP_Icon_2__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_3__c= null; 
                    else                    
                        prod.USP_Icon_3__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 4') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_4__c= null; 
                    else                    
                        prod.USP_Icon_4__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 5') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_5__c= null; 
                    else                    
                        prod.USP_Icon_5__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 6') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_6__c= null; 
                    else                    
                        prod.USP_Icon_6__c= ecnl.New_Value__c;     
                } else if(ecnl.Field_to_Change__c == 'USP Icon 7') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_7__c= null; 
                    else                    
                        prod.USP_Icon_7__c= ecnl.New_Value__c;   
                } else if(ecnl.Field_to_Change__c == 'USP Icon 8') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_8__c= null; 
                    else                    
                        prod.USP_Icon_8__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'USP Icon 9') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_9__c= null; 
                    else                    
                        prod.USP_Icon_9__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'USP Icon 10') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_10__c= null; 
                    else                    
                        prod.USP_Icon_10__c= ecnl.New_Value__c;                                                                                                
                } else if(ecnl.Field_to_Change__c == 'USP Icon 1 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_1_Description__c= null; 
                    else                    
                        prod.USP_Icon_1_Description__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 2 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_2_Description__c= null; 
                    else                    
                        prod.USP_Icon_2_Description__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 3 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_3_Description__c= null; 
                    else                    
                        prod.USP_Icon_3_Description__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 4 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_4_Description__c= null; 
                    else                    
                        prod.USP_Icon_4_Description__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 5 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_5_Description__c= null; 
                    else                    
                        prod.USP_Icon_5_Description__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'USP Icon 6 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_6_Description__c= null; 
                    else                    
                        prod.USP_Icon_6_Description__c= ecnl.New_Value__c;     
                } else if(ecnl.Field_to_Change__c == 'USP Icon 7 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_7_Description__c= null; 
                    else                    
                        prod.USP_Icon_7_Description__c= ecnl.New_Value__c;       
                } else if(ecnl.Field_to_Change__c == 'USP Icon 8 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_8_Description__c= null; 
                    else                    
                        prod.USP_Icon_8_Description__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'USP Icon 9 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_9_Description__c= null; 
                    else                    
                        prod.USP_Icon_9_Description__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'USP Icon 10 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.USP_Icon_10_Description__c= null; 
                    else                    
                        prod.USP_Icon_10_Description__c= ecnl.New_Value__c;                                                                                            
                } else if(ecnl.Field_to_Change__c == 'Customs Stat No') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Customs_Stat_No__c= null; 
                    else                    
                        prod.Customs_Stat_No__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Country of Origin') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Country_of_Origin__c= null; 
                    else                    
                        prod.Country_of_Origin__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Feature 12 (FT12)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT12__c= null; 
                    else                    
                        prod.FT12__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Feature 13 (FT13)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT13__c= null; 
                    else                    
                        prod.FT13__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Feature 14 (FT14)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.FT14__c= null; 
                    else                    
                        prod.FT14__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Web Tap Holes') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Tap_Holes__c= null; 
                    else                    
                        prod.Web_Tap_Holes__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Commercial Product') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Commercial_Product__c= null; 
                    else                    
                        prod.Commercial_Product__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Spares Category') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Spares_Category__c= null; 
                    else                    
                        prod.Spares_Category__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Web Finish') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Finish__c= null; 
                    else                    
                        prod.Web_Finish__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Hero Copy') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hero_Copy__c= null; 
                    else                    
                        prod.Hero_Copy__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Type') { 
                    if(ecnl.New_Value__c != null) 
                        prod.Product_Type__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Web Range') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Web_Range__c= null; 
                    else                    
                        prod.Web_Range__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Contemporary or Traditional (STYLE)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.STYLE__c= null; 
                    else                    
                        prod.STYLE__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Sell on Web') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sell_on_Web__c= null; 
                    else                    
                        prod.Sell_on_Web__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Sell on Web Price') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sell_on_Web_Price__c= null; 
                    else                    
                        prod.Sell_on_Web_Price__c= Decimal.valueOf(ecnl.New_Value__c);      
                } else if(ecnl.Field_to_Change__c == 'Division (DIV)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.DIV__c= null; 
                    else                    
                        prod.DIV__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Heat and Plumb URL') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Heat_and_Plumb_URL__c= null; 
                    else                    
                        prod.Heat_and_Plumb_URL__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Victorian URL') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Victorian_URL__c= null; 
                    else                    
                        prod.Victorian_URL__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Tapstore URL') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Tapstore_URL__c= null; 
                    else                    
                        prod.Tapstore_URL__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'Trading Depot URL') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Trading_Depot_URL__c= null; 
                    else                    
                        prod.Trading_Depot_URL__c= ecnl.New_Value__c;      
                } else if(ecnl.Field_to_Change__c == 'BIM') { 
                    prod.BIM__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'NBS Specification') { 
                    prod.NBS_Specification__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Web Ready') { 
                    prod.Web_Ready__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Add to Website') { 
                    prod.Add_to_Website__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Engineering Part Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Engineering_Part_Description__c= null; 
                    else                    
                        prod.Engineering_Part_Description__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Weight (Kg)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Weight_Kg__c= null; 
                    else                    
                        prod.Product_Weight_Kg__c= Decimal.valueOf(ecnl.New_Value__c);  
                } else if(ecnl.Field_to_Change__c == 'Pre-set Outlet Temperature') { 
                    if(ecnl.New_Value__c == null) 
                        prod.TSTOP__c= null; 
                    else                    
                        prod.TSTOP__c= Decimal.valueOf(ecnl.New_Value__c);  
                } else if(ecnl.Field_to_Change__c == 'Shower Kit') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Shower_Kit__c= null; 
                    else                    
                        prod.Shower_Kit__c= ecnl.New_Value__c;                  
                } else if(ecnl.Field_to_Change__c == 'Main Construction Material') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Main_Construction_Material__c= null; 
                    else                    
                        prod.Main_Construction_Material__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Minimum Dynamic Pressure') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Minimum_dynamic_Pressure__c= null; 
                    else                    
                        prod.Minimum_dynamic_Pressure__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'What\'s in the Box?') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Whats_in_the_Box__c= null; 
                    else                    
                        prod.Whats_in_the_Box__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Assembly Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Assembly_Required__c= null; 
                    else                    
                        prod.Assembly_Required__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (Min)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_Min__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_Min__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (Min)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_Min__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_Min__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (Min)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_Min__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_Min__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (Min)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_Min__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_Min__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR0.2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR0_2__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR0_2__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR0.2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR0_2__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR0_2__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR0.2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR0_2__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR0_2__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR0.2)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR0_2__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR0_2__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR0.5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR0_5__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR0_5__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR0.5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR0_5__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR0_5__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR0.5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR0_5__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR0_5__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR0.5)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR0_5__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR0_5__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR1.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR1_0__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR1_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR1.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR1_0__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR1_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR1.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR1_0__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR1_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR1.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR1_0__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR1_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR2.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR2_0__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR2_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR2.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR2_0__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR2_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR2.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR2_0__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR2_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR2.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR2_0__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR2_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR3.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR3_0__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR3_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR3.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR3_0__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR3_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR3.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR3_0__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR3_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR3.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR3_0__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR3_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR4.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR4_0__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR4_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR4.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR4_0__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR4_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR4.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR4_0__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR4_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR4.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR4_0__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR4_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Handset l/min (FR5.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Handset_l_min_FR5_0__c= null; 
                    else                    
                        prod.Flow_through_Handset_l_min_FR5_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Open Outlet l/min (FR5.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Open_Outlet_l_min_FR5_0__c= null; 
                    else                    
                        prod.Flow_through_Open_Outlet_l_min_FR5_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Flow Limiter l/min (FR5.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Flow_Limiter_l_min_FR5_0__c= null; 
                    else                    
                        prod.Flow_through_Flow_Limiter_l_min_FR5_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Flow through Fixed Head l/min (FR5.0)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Flow_through_Fixed_Head_l_min_FR5_0__c= null; 
                    else                    
                        prod.Flow_through_Fixed_Head_l_min_FR5_0__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Internal Length') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Internal_Length__c= null; 
                    else                    
                        prod.Internal_Length__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Internal Width') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Internal_Width__c= null; 
                    else                    
                        prod.Internal_Width__c= ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Height Inc Feet') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Height_Inc_Feet__c= null; 
                    else                    
                        prod.Height_Inc_Feet__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'Height Max') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Height_Max__c= null; 
                    else                    
                        prod.Height_Max__c= ecnl.New_Value__c;                      
                } else if(ecnl.Field_to_Change__c == 'Height Min') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Height_Min__c= null; 
                    else                    
                        prod.Height_Min__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Full Height') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Full_Height__c= null; 
                    else                    
                        prod.Full_Height__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Full Projection') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Full_Projection__c= null; 
                    else                    
                        prod.Full_Projection__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Overflow to Waste') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Overflow_to_Waste__c= null; 
                    else                    
                        prod.Overflow_to_Waste__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Spout Projection') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Spout_Projection__c= null; 
                    else                    
                        prod.Spout_Projection__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Valve') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Valve__c= null; 
                    else                    
                        prod.Valve__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Inlet Centres') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Inlet_Centres__c= null; 
                    else                    
                        prod.Inlet_Centres__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Hose Length') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Hose_Length__c= null; 
                    else                    
                        prod.Hose_Length__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'Surface Mounted') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Surface_Mounted__c= null; 
                    else                    
                        prod.Surface_Mounted__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Recessed') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Recessed__c= null; 
                    else                    
                        prod.Recessed__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Valve Centres') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Valve_Centres__c= null; 
                    else                    
                        prod.Valve_Centres__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Wall to Valve Centre') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Wall_to_Valve_Centre__c= null; 
                    else                    
                        prod.Wall_to_Valve_Centre__c= Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Output') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Output__c= null; 
                    else                    
                        prod.Output__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description__c= null; 
                    else                    
                        prod.Description__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Additional Information') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Additional_Information__c= null; 
                    else                    
                        prod.Additional_Information__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'P&P Range') { 
                    if(ecnl.New_Value__c == null) 
                        prod.P_P_Range__c= null; 
                    else                    
                        prod.P_P_Range__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Section') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Section__c= null; 
                    else                    
                        prod.Section__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'Sub Section') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Sub_Section__c= null; 
                    else                    
                        prod.Sub_Section__c= ecnl.New_Value__c; 
                } else if(ecnl.Field_to_Change__c == 'Variant Header') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Header__c= null; 
                    else                    
                        prod.Variant_Header__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Accelerator Product') { 
                    prod.Accelerator_Product__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Accelerator Category') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Accelerator_Category__c= null; 
                    else                    
                        prod.Accelerator_Category__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Accelerator Range') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Accelerator_Range__c= null; 
                    else                    
                        prod.Accelerator_Range__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Accelerator Title') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Accelerator_Title__c= null; 
                    else                    
                        prod.Accelerator_Title__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Accelerator Title 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Accelerator_Title_2__c= null; 
                    else                    
                        prod.Accelerator_Title_2__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description Line 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description_Line_1__c= null; 
                    else                    
                        prod.Description_Line_1__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description Line 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description_Line_2__c= null; 
                    else                    
                        prod.Description_Line_2__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description Line 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description_Line_3__c= null; 
                    else                    
                        prod.Description_Line_3__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description Line 4') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description_Line_4__c= null; 
                    else                    
                        prod.Description_Line_4__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Description Line 5') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Description_Line_5__c= null; 
                    else                    
                        prod.Description_Line_5__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Accelerator Intro Paragraph') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Accelerator_Intro_Paragraph__c= null; 
                    else                    
                        prod.Accelerator_Intro_Paragraph__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Paragraph Line 1') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Paragraph_Line_1__c= null; 
                    else                    
                        prod.Paragraph_Line_1__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Paragraph Line 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Paragraph_Line_2__c= null; 
                    else                    
                        prod.Paragraph_Line_2__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Paragraph Line 3') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Paragraph_Line_3__c= null; 
                    else                    
                        prod.Paragraph_Line_3__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Bath Feet Type') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Bath_Feet_Type__c= null; 
                    else                    
                        prod.Bath_Feet_Type__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Bath Feet Type 2') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Bath_Feet_Type_2__c= null; 
                    else                    
                        prod.Bath_Feet_Type_2__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Solid Skin') { 
                    prod.Solid_Skin__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Single or Double Ended') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Single_or_Double_Ended__c= null; 
                    else                    
                        prod.Single_or_Double_Ended__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'A4 Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.A4_Description__c= null; 
                    else                    
                        prod.A4_Description__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Product Benefits') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Product_Benefits__c= null; 
                    else                    
                        prod.Product_Benefits__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Title') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Title__c= null; 
                    else                    
                        prod.Title__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Title Short') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Title_Short__c= null; 
                    else                    
                        prod.Title_Short__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Variant Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Variant_Description__c= null; 
                    else                    
                        prod.Variant_Description__c= ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'P&P New Price (ex VAT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.P_P_New_Price_ex_VAT__c = null; 
                    else                    
                        prod.P_P_New_Price_ex_VAT__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'P&P New Price (inc VAT)') { 
                    if(ecnl.New_Value__c == null) 
                        prod.P_P_New_Price_inc_VAT__c = null; 
                    else                    
                        prod.P_P_New_Price_inc_VAT__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Specifier Title') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Specifier_Title__c = null; 
                    else                    
                        prod.Specifier_Title__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Specify Description') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Specify_Description__c = null; 
                    else                    
                        prod.Specify_Description__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Specify As') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Specify_As__c = null; 
                    else                    
                        prod.Specify_As__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Recommended Items') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Recommended_Items__c = null; 
                    else                    
                        prod.Recommended_Items__c = ecnl.New_Value__c;
                } else if(ecnl.Field_to_Change__c == 'Add to P&P') { 
                    prod.Add_to_P_P__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'P&P Ready') { 
                    prod.P_P_Ready__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Build Timings') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Build_Timings__c = null; 
                    else                        
                        prod.Build_Timings__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Component?') { 
                    prod.Component__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Inventory Only?') { 
                    prod.Inventory_Only__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Ireland Euro (€) inc VAT') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Ireland_Euro_inc_VAT__c = null; 
                    else                    
                        prod.Ireland_Euro_inc_VAT__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Northern Ireland GBP (£) inc VAT') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Northern_Ireland_GBP_inc_VAT__c = null; 
                    else                    
                        prod.Northern_Ireland_GBP_inc_VAT__c = Decimal.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'EU REACH Regulation') { 
                    if(ecnl.New_Value__c == null) 
                        prod.EU_REACH_Regulation__c = null; 
                    else                    
                        prod.EU_REACH_Regulation__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'UK Water Regulation Compliance') { 
                    if(ecnl.New_Value__c == null) 
                        prod.UK_Water_Regulation_Compliance__c = null; 
                    else                    
                        prod.UK_Water_Regulation_Compliance__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'CE Approval Certificate No') { 
                    if(ecnl.New_Value__c == null) 
                        prod.CE_Approval_Certificate_No__c = null; 
                    else                    
                        prod.CE_Approval_Certificate_No__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'EUTR Certificate No') { 
                    if(ecnl.New_Value__c == null) 
                        prod.EUTR_Certificate_No__c = null; 
                    else                    
                        prod.EUTR_Certificate_No__c = ecnl.New_Value__c;  
                } else if(ecnl.Field_to_Change__c == 'Low Voltage Compliant') { 
                    prod.Low_Voltage_Compliant__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'EMC Directive Compliant') { 
                    prod.EMC_Directive_Compliant__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Red Directive Compliant') { 
                    prod.Red_Directive_Compliant__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'ECO Design Compliant') { 
                    prod.ECO_Design_Compliant__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Energy Label') { 
                    prod.Energy_Label_Check__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'REACH Statement') { 
                    prod.REACH_Statement__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'UK Water Regulation Approved (Y/N)') { 
                    prod.UK_Water_Regulation_Approved__c = Boolean.valueOf(ecnl.New_Value__c);
                } else if(ecnl.Field_to_Change__c == 'Energy Label Required') { 
                    if(ecnl.New_Value__c == null) 
                        prod.Energy_Label__c = null; 
                    else                    
                        prod.Energy_Label__c = ecnl.New_Value__c;      
                }
            }
            prod.Status__c = 'Complete';
            UPDATE prod;
            prod = [select Id, Status__c from Product__c where Id = :prodId LIMIT 1];
            system.debug('Product Status: ' + prod.Status__c);
        }
    }
}