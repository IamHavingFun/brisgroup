public with sharing class PartsCatalogue {

public set<String> folderNames{set; get;}
public set<String> partVersions{set; get;}
public String[] treeNodes {set; get;}
public map<String,Integer> parentIdNumberOfDocumentsMap {set;get;}
public Map<Product2, Map<Product_Revision__c, Spares_Revision__c[]>> prodHierarchyMap{set;get;}
//public Map<Product_Revision__c, Spares_Revision__c[]> selectedProdDetailsMap{set;get;}
 
//public List<cNodes> mainnodes{set; get;}

//public map<String,MAp<String,String[]>> partMap{set; get;}
public String link{set; get;}
public String searchTxt{set; get;}
public String  Quantity{set; get;}
public String  addMasterProductRevNumber{set; get;}
public String  masterProdCode{set; get;}
public String  addMasterProdCode{set; get;}
public String  addMasterSpareRev{set; get;}

public String  addMasterProdRevId{get; set;}
public Boolean addspareRevisionSelected{set; get;}

public integer offsetLimit{set; get;}
public integer countLines{set; get;}

public ID addMasterProductID{set; get;}

public ID masterProdID{set; get;}
public ID prodID{set; get;}
public ID prodRevID{set; get;}
public ID revID{set; get;}
public ID myCaseID{get; set;}
//public ID myOppID{get; set;}
public Id addProductID{set; get;}

public Id emailTemplateId{set; get;}

public Product2[] addAllProducts{set; get;}

public Boolean fnd{set; get;}
public boolean divMatch{set; get;}
public Boolean displayAddToCollection{set; get;}
public Boolean displayRetrievingQuantity{set; get;}
public Boolean spareRevisionSelected{set; get;}

//public Boolean displayRevisionStartDate{get; set;}

//public Opportunity myOpp{set; get;}
public Product2 SelectedProd{set; get;}
public Product_Revision__c prodRevision{set; get;}
public Spares_Revision__c SelectedRev{set; get;}
public Case thisCase{set; get;}

public List<cNodes> hierarchy;
public List<ProductsCollection> allProductsCollections{set; get;}

public string nodeType{get; set;}

private void setupSettings(){
        treeNodes = new String[]{'test', 'test2'};
        fnd = false;
        offsetLimit = 0; //default
}

public PartsCatalogue (){
        setupSettings();
        String thisID = ApexPages.currentPage().getParameters().get('Id');
        
        
        emailTemplateId = (ID) string.valueOf(Application_Config__c.getInstance('SendLinksEmailId').Value__c);
        
        if (thisID == null || thisID == ''){
            displayAddToCollection = false;
            apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No Case record has been selected'));
        }
        else{
            if (((ID)thisID).getSObjectType() == Case.SObjectType){
                    myCaseID = ApexPages.currentPage().getParameters().get('Id');
                    thisCase = [Select id, AccountId , Account.id, Account.Name, CaseNumber, Contact.Email, Contact.FirstName, Contact.LastName, ContactId, Contact.Name, Owner.Name, RecordType.Name, Case_Site__c, Related_Work_Order__c From Case where id=:myCaseID];
            }
            //else if (thisID.getSObjectType() == Opportunity.SObjectType){
            //      myOppID = thisID;
            //      myOpp = [Select id, AccountId , Account.id, Account.Name, Name From Opportunity where id=:thisID];
            //}
              
            displayAddToCollection = true;
        }
            //system.debug('####### MyTask ' + Constants.MyTask);
        nodeType = 'Product';
        system.debug('####### nodeType ' + nodeType);
        
        //displayRevisionStartDate = true;
        
        
        //IMPORTANT Remove after testing PartsCatalogueTest page
        //displayAddToCollection = true;
        //searchTxt = 'MT503CP';
        //searchTxt = 'J BAS C';
        //searchProd();
}

public class ProductsCollection
{
        //  eg <R1, Spares>
 public Boolean selectedName{get; set;}
 public Boolean selectedDrawing{get; set;}
 public Boolean selectedFitting{get; set;}
 public Boolean selectedTech{get; set;}
 public Boolean selectedProdData{get; set;}
 public Boolean selectedWebImage{get; set;}
 public Product2 thisPD {get;set;}
 public String thismasterProdID{set; get;}
 public String thisProdRevNumber{set; get;}
 public String thismasterProdCode{set; get;}
 public String thismasterSpareRev{set; get;}
 
 public String thisproductRevisionId{set; get;}
 public Boolean thisspareRevisionSelected{set; get;}
 

 public ProductsCollection(String masterProdID, String ProdRevNumber, String masterProdCode, String masterSpareRev, string ProdRevId, Product2  pd, Boolean spareRevisionSelected )
 {
     thisPD = pd;
     selectedName = false;
     selectedDrawing = false;
     selectedFitting = false;
     selectedTech = false;
     selectedProdData = false;
     selectedWebImage = false;
     thismasterProdID = masterProdID;
     thisProdRevNumber = ProdRevNumber;
     thismasterProdCode = masterProdCode;
     thismasterSpareRev = masterSpareRev;
     thisproductRevisionId = ProdRevId;
     thisspareRevisionSelected = spareRevisionSelected;
 }
}

public class cNodes
{
        //  eg <R1, Spares>
 public Map<Product_Revision__c, Spares_Revision__c[]> parent {get; set;}
 public Product2 gparent {get;set;}
 public cNodes(Product2  gp, Map<Product_Revision__c, Spares_Revision__c[]> p)
 {
     parent = p;
     gparent = gp;
 }
}

public void assignFnd(){
    fnd = true;
    system.debug('####### fnd2 ' + fnd);
}

Public List<cNodes> getmainnodes()
{    
    system.debug('####### fnd1 ' + fnd);
    system.debug('####### hierarchy1 ' + hierarchy);
    if (!fnd) buildTree(null, null);
    
    system.debug('####### hierarchy2 ' + hierarchy);
    
    //if ( nodeType == 'Revision')  displayRevisionStartDate = true;
    //else displayRevisionStartDate = false;
    
    //system.debug('####### displayRevisionStartDate ' + displayRevisionStartDate);
    
    return hierarchy;
}   

public PageReference addToCollection(){
        
        system.debug('####### addToCollection clicked');
        if (allProductsCollections == null) allProductsCollections = new List<ProductsCollection>();
        system.debug('####### addMasterProductRevNumber ' + addMasterProductRevNumber); // + ' '+ addMasterProdCode +  ' '+ addMasterSpareRev);
        system.debug('####### addMasterProdCode ' + addMasterProdCode);
        system.debug('####### addMasterSpareRev ' + addMasterSpareRev);
        system.debug('####### addMasterProdRevId ' + addMasterProdRevId);
        
        
        
        allProductsCollections.add(new ProductsCollection(addMasterProductID, addMasterProductRevNumber, addMasterProdCode, addMasterSpareRev, addMasterProdRevId, [Select id, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Base_Price__c,  Product_Data__c, Product_Web_Image__c, IsActive, Site__c From Product2 where id =:addProductID], addspareRevisionSelected));
        system.debug('####### allProductsCollections ' + allProductsCollections);
        system.debug('####### addMasterProductID ' + addMasterProductID);
        return null;
}

public PageReference sendEmail(){

        system.debug('####### sendEmail clicked');
        try{
                if (thisCase.Contact != null){
                        
                        EmailTemplate thitemplate = [Select Name, Id, HtmlValue From EmailTemplate where id =:emailTemplateId];
                        
                        String emailbody = thitemplate.HtmlValue;
                        system.debug('####### emailbody =' + emailbody );
                        //emailTemplateId
                        
                        List<String> recipients = new List<String>{thisCase.Contact.Email};
                        //String bdy = 'Dear ' + thisCase.Contact.FirstName + ' ' + thisCase.Contact.LastName  + '\n\n';
                        String bdy = '';
                        for (ProductsCollection eachProd :allProductsCollections){                      
                                system.debug('####### eachProd =' + eachProd );
                                if (eachProd.selectedName)
                                {
                                        //if (eachProd.selectedName){
                                        if (eachProd.selectedDrawing || eachProd.selectedFitting || eachProd.selectedTech || eachProd.selectedProdData || eachProd.selectedWebImage) {
                                          bdy += 'Product Name: ' + eachProd.thisPD.Name + '<p />';
                                        }
                                        //}
                                        if (eachProd.selectedDrawing){
                                                bdy += '<a href="' + eachProd.thisPD.Spares_Drawing__c + '" target="_blank">Link to CS Drawing</a><p />';
                                                //<a href="http://www.w3schools.com/" target="_blank">Visit W3Schools!</a> 
                                                
                                        }
                                        if (eachProd.selectedFitting){
                                                bdy += '<a href="' + eachProd.thisPD.Fitting_Instructions__c + '" target="_blank">Link to Fitting Instructions</a><p />';
                                                //bdy += 'Link to Fitting Instructions is ' + eachProd.thisPD.Fitting_Instructions__c + '<p />';
                                        }
                                        if (eachProd.selectedTech){
                                                bdy += '<a href="' + eachProd.thisPD.Technical_Drawing__c + '" target="_blank">Link to Technical Drawing</a><p />';
                                                //bdy += 'Link to Technical Drawing is ' + eachProd.thisPD.Technical_Drawing__c + '<p />';
                                        }
                                        if (eachProd.selectedProdData){  //Product_Data__c, Product_Web_Image__c, 
                                                bdy += '<a href="' + eachProd.thisPD.Product_Data__c + '" target="_blank">Link to Product Data</a><p />';
                                                //bdy += 'Link to Technical Drawing is ' + eachProd.thisPD.Technical_Drawing__c + '<p />';
                                        }
                                        if (eachProd.selectedWebImage){
                                                bdy += '<a href="' + eachProd.thisPD.Product_Web_Image__c + '" target="_blank">Link to Web Image</a><p />';
                                                //bdy += 'Link to Technical Drawing is ' + eachProd.thisPD.Technical_Drawing__c + '<p />';
                                        }
                                }
                
                        }
                        if (bdy != '') {
                          system.debug('####### bdy =' + bdy );
                          emailbody = emailbody.replace('++++++++', bdy);
                        
                          emailbody = emailbody.replace('Contact.FirstName', thiscase.Contact.FirstName);
                          emailbody = emailbody.replace('Contact.LastName', thiscase.Contact.LastName);
                          emailbody = emailbody.replace('Case.OwnerFullName', thiscase.Owner.Name);                          
                                        
                          system.debug('####### emailbody =' + emailbody );
                                                
                          //send email
                          //EmailUtils.sendHTMLEmail(recipients,'', emailbody);
                          EmailUtils.sendHTMLEmail(recipients,'Case ID: '+thiscase.CaseNumber+' - Product Information', emailbody, thisCase.ContactId,  thisCase.Id);
                        
                          apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Email was sent successfully.'));
                        }
                        else
                        {
                          apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No products/documents selected, no email sent.'));                         
                        }
                }
                else
                        apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'There is no Contact to send Email to.'));
        }
        catch (Exception ex){
                apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Email could not be sent.'));               
        }
                
        return null;
}

public PageReference addToAsset(){
        try{
                
                Product_Asset__c[] newAssets = new Product_Asset__c[]{}; 
                system.debug('####### allProductsCollections ' + allProductsCollections);
                for (ProductsCollection eachProd :allProductsCollections){
                       system.debug('####### addMasterProductID ' + eachProd + ' '+ spareRevisionSelected);
                       if (eachProd.selectedName == true && !eachProd.thisspareRevisionSelected && (eachProd.thisproductRevisionId != '' && eachProd.thisproductRevisionId != null)) //&& (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')) 
                       {
                             newAssets.add(new Product_Asset__c(Contact__c = thisCase.ContactId,
                             Name = eachProd.thisPD.Name, 
                             Product_Revision__c = eachProd.thisproductRevisionId != '' ? (ID)eachProd.thisproductRevisionId : null));
                       }              
                }
                system.debug('####### newAssets ' + newAssets);
                if (!newAssets.isempty()){
                    insert newAssets;
                    apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Product Asset was created successfully.'));
                }
                else
                    apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No Product Assets were created.'));
        }
        catch (Exception ex){
                system.debug('####### error ' + ex);
                apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Product Asset could not be created.'));            
        }
                
        
        return null;
}

public PageReference addToCase(){
        try{
                String bdy = 'added products via the Product Catalogue:\n\n';
                for (ProductsCollection eachProd :allProductsCollections){
                        if (eachProd.selectedName == true && (((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')))) {
                            bdy += 'Product added ' + eachProd.thisPD.Name  + ' (Revision: ' + eachProd.thisProdRevNumber + ')\n';
                        }
                        else if (eachProd.selectedName == true) bdy += 'Product added ' + eachProd.thisPD.Name  + '\n';
                }
                
                system.debug('## bdy ' + thisCase.id + ' ' + bdy);
                insert new CaseComment(ParentId = thisCase.id, CommentBody = bdy);
                apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Case Comment was created successfully.'));
        }
        catch (Exception ex){
                apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Case Comment could not be created.'));             
        }
                
        
        return null;
}

public PageReference addToOrder(){
        divMatch = true;  // Check site on case matches site on parts else don't create order.
        countLines = 0; // Check there are lines selected before creating order.        
        for (ProductsCollection eachProd :allProductsCollections){
            if(eachProd.selectedName == true && eachProd.thisPD.isActive && (((eachProd.thisProdRevNumber == null || eachProd.thisProdRevNumber == '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')) || ((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev != null && eachProd.thismasterSpareRev != ''))))
            {
                if(eachProd.selectedName && thisCase.RecordType.Name.indexOf('Heritage') != -1 && eachProd.thisPD.Site__c != '04')
                {
                    divMatch = false;
                }
                if(eachProd.selectedName && thisCase.RecordType.Name.indexOf('Heritage') == -1 && eachProd.thisPD.Site__c != '01')
                {
                    divMatch = false;
                }
                countLines = countLines + 1;     
            }                
        }
        if(countLines > 0) {        
            if(divMatch) {
                Order__c thisneworder = new Order__c();
                thisneworder.Case_Account__c = thisCase.AccountId;
                RecordType standardorderrecordtype = [SELECT Id, Name FROM RecordType where Name = 'Standard Order' and SObjectType = 'Order__c'];
                thisneworder.RecordTypeId = standardorderrecordtype.Id;
                Delivery_Term__c thisterm = [select id from Delivery_Term__c where Name = 'PST' limit 1];
                thisneworder.Case__c = thisCase.Id;
                thisneworder.Delivery_Term__c = thisterm.id;
                insert thisneworder;    
                system.debug('## thisneworder ' + thisneworder);
        
                Order_Line__c[] newOrderLines = new Order_Line__c[]{};
                for (ProductsCollection eachProd :allProductsCollections){
                    try
                    {
                        system.debug('## eachProd ' + eachProd  );
                        // add products (thisProdRevNumber is blank and thismasterSpareRev is blank) and spares (thisProdRevNumber is not blank and thismasterSpareRev is not blank) but not product revision (thisProdRevNumber is not blank but thismasterSpareRev is blank)
                        if (eachProd.selectedName == true && eachProd.thisPD.isActive && (((eachProd.thisProdRevNumber == null || eachProd.thisProdRevNumber == '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')) || ((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev != null && eachProd.thismasterSpareRev != ''))))
                        {
                            newOrderLines.add(new Order_Line__c(Order__c = thisneworder.Id, Quantity__c = 1, Product__c =  eachProd.thisPD.id ));
                        }
                    }
                    catch(Exception err)
                    {
                    }
                }
                insert newOrderLines;
                system.debug('## newOrderLines ' + newOrderLines);
                PageReference pr = new PageReference('/' + thisneworder.Id);
                return pr;
            }
            else
            {
                apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Cannot create order.  Selected product(s) Site must match the Case Site.'));
                return null;            
            }
        }            
        else            
        {
            apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Cannot create order.  No valid selected products.'));
            return null;                     
        }     
}

public PageReference submitLink(){

        return null;
}

    private void buildTree(Set<Id> searchID, Set<Id> catlogSet) {//Map<id, id[]> thisprodToCatRev
        /*AggregateResult[] pc = [select Part_Name__c from Parts_Catalogue__c Group By Part_Name__c];
         folderNames = new set<String>();
         for (Sobject eachpc: pc){
                folderNames.add((String)eachpc.get('Part_Name__c'));
        }*/
        hierarchy = new List<cNodes>();
        
        system.debug('## searchID ' + searchID);
        system.debug('## catlogSet ' + catlogSet);
        //system.debug('## pc2 ' + pc2);
        Map<id, id[]> prodToCatRev = new Map<id, id[]>();
        Map<id, Spares_Revision__c[]> catToSpares = new Map<id, Spares_Revision__c[]>();
        Spares_Revision__c[] pc2;
        if (catlogSet == null)
                pc2 = Database.query('select Master_Product__c, Product_Descr__c, Code_And_Desc__c, Product_Code__c, Revision__c, Name, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r) from Spares_Revision__c Limit 100');//OFFSET :offsetLimit
        else
                pc2 = Database.query('select Master_Product__c, Product_Descr__c, Code_And_Desc__c, Product_Code__c, Revision__c, Name, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r where id In : catlogSet) from Spares_Revision__c');//:offsetLimit

system.debug('## pc2 ' + pc2);
        for (Spares_Revision__c eachpart : pc2){                
                for (Catalogue_Junction__c eachCat : eachpart.Catalog_Junctions__r){ 
                                if(!prodToCatRev.containsKey(eachpart.id)) {
                                        prodToCatRev.put(eachpart.id, new id[]{}); 
                                }
                                prodToCatRev.get(eachpart.id).add(eachCat.id);
                                
                                if(!catToSpares.containsKey(eachCat.id)) {
                                        catToSpares.put(eachCat.id, new Spares_Revision__c[]{}); 
                                }       
                                catToSpares.get(eachCat.id).add(eachpart);      
                }       
        }
        system.debug('## prodToCatRev ' + prodToCatRev);

                Product_Revision__c[] prods;
                if(searchID == null) 
                        prods = [Select Revision__c, Product_Code__c, Master_Product__c, Master_Product__r.Name, Name, Product_Descr__c, Code_And_Desc__c, Product_ID__c, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r)  From Product_Revision__c where id In :prodToCatRev.keyset()];//='a0Wc0000000lk9g'  :Limits.getLimitQueryRows()
                else
                        prods = [Select Revision__c, Product_Code__c, Master_Product__c, Master_Product__r.Name, Name, Product_Descr__c, Code_And_Desc__c, Product_ID__c, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r)  From Product_Revision__c where id In :searchID];//
                
                Set<id> allProds = new Set<id>();
                for (Product_Revision__c eachprod: prods)
                        allProds.add(eachprod.Master_Product__c);
                
                Map<id, Product2> prodMap = new Map<id, Product2>([Select id, Name, Name_Site__c, Base_Price__c, IsActive From Product2 where id In :allProds]);
                
                prodHierarchyMap = new Map<Product2, Map<Product_Revision__c, Spares_Revision__c[]>>();
                integer cntr = 0;
                for (Product_Revision__c eachprod: prods){
                        system.debug('## eachprod ' + eachprod);
                        Map<Product_Revision__c, Spares_Revision__c[]> allSpares = new Map<Product_Revision__c, Spares_Revision__c[]>();
                        //if (prodToCatRev.containsKey(eachprod.id)){
                                
                                for (Catalogue_Junction__c eachCat : eachprod.Catalog_Junctions__r){
                                        /*system.debug('## eachSpare ' + prodToCatRev.get(eachprod.id));        
                                        system.debug('## catToSpares ' + catToSpares.get(eachCat));*/
                                        if (catToSpares.containskey(eachCat.id)){
                                                for (Spares_Revision__c eachSpare : catToSpares.get(eachCat.id)){       
                                                        system.debug('## eachSpare ' + eachSpare);                                      
                                                        if(eachprod != null && !allSpares.containsKey(eachprod)) {
                                                                allSpares.put(eachprod, new Spares_Revision__c[]{}); 
                                                        }
                                                        allSpares.get(eachprod).addall(catToSpares.get(eachCat.id));
                                                        
                                                }
                                        }
                                        system.debug('## allSpares ' + allSpares);
                                }
                                
                                if (!allSpares.isempty()){
                                        if(!prodHierarchyMap.containsKey(prodMap.get(eachprod.Master_Product__c))) {
                                                prodHierarchyMap.put(prodMap.get(eachprod.Master_Product__c), allSpares); 
                                        }
                                        prodHierarchyMap.get(prodMap.get(eachprod.Master_Product__c)).putall(allSpares);
                                }
                        //}
                        ++cntr;
                        if (cntr == 100){
                            apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Too many records were returned, please improving the search criteria. A limited number of records have been returned'));
                            break;
                        }
                }
                
                if (!prodHierarchyMap.isempty()){  
                        for (Product2 eachProd :prodHierarchyMap.keyset()){
                                hierarchy.add(new cNodes(eachProd, prodHierarchyMap.get(eachProd)));
                        }
                }
                system.debug('###hierarchy ' +hierarchy); 

        /*partMap = new map<String,Map<String,String[]>>();
        Map<String,String[]> subpartMap;
        String[] revisionLst;
        for (Parts_Catalogue__c eachpc: pc2){        
                if (partMap.containskey(eachpc.Part_Name__c)){
                        subpartMap = partMap.get(eachpc.Part_Name__c);
                        if (subpartMap.containskey(eachpc.Part_Rev__c)){
                                revisionLst = subpartMap.get(eachpc.Part_Rev__c);
                        }
                        else
                                revisionLst = new String[]{};
                        
                }
                else{
                        subpartMap = new Map<String,String[]>();
                        revisionLst = new String[]{};                   
                }
                
                revisionLst.add(eachpc.Sub_Part_Name__c);
                
                subpartMap.put(eachpc.Part_Rev__c, revisionLst);
                partMap.put(eachpc.Part_Name__c, subpartMap);
        }*/
        /*opportunitiesNames = new set<String>();
        casesNames = new set<String>();
        servicesNames = new set<String>();*/        
       
       
        //parentIdNumberOfDocumentsMap = new map<String,Integer>();
        
        /*for (Parts_Catalogue__c iter : pc)
                folderNames.add(iter.name);
           
        /*for (Integer i = 0 ; i < treeNodes.size()  - 1; i++ ) // general 
                treeNodes[i] +=  getNumberOfItemsInFolder(treeNodes[i]);
        treeNodes[treeNodes.size()  - 1]+= ' ('+ String.valueOf(documents.size()) +')';
         */
    }

        public PageReference searchProd(){
                Set<Id> prodSet = new Set<Id>();
                Set<Id> catlogSet = new Set<Id>();
                
                searchTxt = searchTxt.toUpperCase();
                searchTxt = searchTxt.trim();
                system.debug('###prodSet ' +'Select id From Product_Revision__c where Product_Code__c Like \'%' + searchTxt + '%\' or Product_Descr__c Like \'%' + searchTxt + '%\'' );
                Map<id, id[]> prodToCatRev = new Map<id, id[]>();
                for (Product_Revision__c pr : Database.query('Select id, (Select id, Product_Revision__c, Name, Junction_Key__c From Catalog_Junctions__r) From Product_Revision__c where Product_Code__c Like \'%' + searchTxt + '%\' or Product_Descr__c Like \'%' + searchTxt + '%\'')){
                        prodSet.add(pr.id);
                        for (Catalogue_Junction__c eachcat: pr.Catalog_Junctions__r)
                                catlogSet.add(eachcat.id);
                                
                        /*if(!prodToCatRev.containsKey(pr.Product_Revision__c)) {
                                prodToCatRev.put(pr.Product_Revision__c, new id[]{}); 
                        }
                        prodToCatRev.get(pr.Product_Revision__c).add(pr.id);*/
                } 
                
                system.debug('###catlogSet ' +catlogSet );
                system.debug('###prodSet ' +prodSet );  
                
                buildTree(prodSet, catlogSet);
                fnd = true;
                return null;
        }

        public PageReference nextProd(){
                offsetLimit += 20;
                searchProd();
                return null;
        }
        
        /*public String prodName{set; get;}
        public String prodCode{set; get;}
        */
        
        public PageReference selectProd(){
                system.debug('###selectProd ');
                system.debug('###prodID ' +prodID); 
                Quantity = 'NOT Queried'; 
                //Quantity = 'Querying for quantity.........';
                SelectedRev = null;
                prodRevision = null;
                spareRevisionSelected = false;
                SelectedProd = [select Site__c, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Product_Data__c, Product_Web_Image__c, Description, Short_Description__c, id, Base_Price_Plus_VAT__c, IsActive, Supplier_Held__c, Guarantee__c, Qty_Available__c from Product2 where id = :prodID ];
                masterProdID = prodID;
                masterProdCode = SelectedProd.ProductCode;
                
                //qtyCallout(SelectedProd);
                system.debug('####### nodeType ' + nodeType);

                system.debug('###SelectedProd ' +SelectedProd); 
                /*prodName = SelectedProd.Name;
                prodCode = SelectedProd.ProductCode;
                selectedProdDetailsMap = prodHierarchyMap.get(SelectedProd.Name);
                */
                return null;
        }

        public PageReference selectProdRevision(){
                selectProd();
                
                prodRevision = [select Site__c, Name, Revision_Date__c, Revision__c, Id  from Product_Revision__c where id = :prodRevID];
                
                system.debug('####### nodeType ' + nodeType);
                return null;
        }
        
        public PageReference selectRevsion(){
                system.debug('###selectRevsion just started');
                
                system.debug('###revID =' + revID);
                 
                SelectedRev = [select Master_Product__c, Product_Code__c, Revision__c, Name, Revision_Date__c, id from Spares_Revision__c where id = :revID];
                SelectedProd = [select Site__c, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Product_Data__c, Product_Web_Image__c, Description, Short_Description__c, id, Base_Price_Plus_VAT__c, IsActive, Supplier_Held__c, Guarantee__c, Qty_Available__c from Product2 where id = :SelectedRev.Master_Product__c];
                prodRevision = [select Site__c, Name, Revision_Date__c, Revision__c, Id  from Product_Revision__c where id = :prodRevID];
                spareRevisionSelected = true;
                
                //Quantity = 'Querying for quantity.........'; 
                Quantity = 'NOT Queried'; 
                //qtyCallout(SelectedProd);
                
                system.debug('###SelectedRev ' +SelectedRev); 
                system.debug('###SelectedProd ' +SelectedProd); 
                system.debug('####### nodeType ' + nodeType);

                /*prodName = SelectedProd.Name;
                prodCode = SelectedProd.ProductCode;
                        */
                return null;
        }

        public void qtyCallout(){
                system.debug('########### qtyCallout just started ');
                //Quantity = 'Querying for quantity'; 
                 
                system.debug('########### SelectedProd =' + SelectedProd); 
                if (SelectedProd != null){
                        Product2 prd = SelectedProd;
                
                        system.debug('###########qtyCallout just started '); 
                        
                        system.debug('########### prd =' + prd); 
                        system.debug('########### prd.ProductCode =' + prd.ProductCode); 
                        system.debug('########### prd.Name =' + prd.Name ); 
                        system.debug('########### prd.Site__c =' + prd.Site__c); 
                        
                        
                        QuantityRequestCallout h = new QuantityRequestCallout();
                         
                        if (!Test.isRunningTest()) {
                            Quantity = h.main(prd.Name , '',prd.Site__c);
                            if (Quantity == ''){
                                Quantity = 'No Response from Quantity Server';
                                //apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Service timed out'));
                            }
                        }       
                }
                displayRetrievingQuantity = false;
        }
        
        public PageReference retrievingQty(){
                displayRetrievingQuantity = true;
                Quantity = 'Querying for quantity'; 
                
                system.debug('###displayRetrievingQuantity ' +displayRetrievingQuantity); 
                return null;
        }
        
    /*private void incrementNumberOfDocumentsInFolder(String key){
        Integer tmp;
        if (parentIdNumberOfDocumentsMap.containsKey(key)) {
            tmp = parentIdNumberOfDocumentsMap.get(key);
            tmp++;
            parentIdNumberOfDocumentsMap.put(key, tmp);
            }
        else 
                parentIdNumberOfDocumentsMap.put(key, 1);                                
    } 

    private String getNumberOfItemsInFolder(String key){
        Integer cnt  = parentIdNumberOfDocumentsMap.get( key);
        if ( cnt == null) return ' (0)';
        else return ' ('+ String.valueOf(cnt) +')';
    }*/

}