/**
 * 
 * @author PolSource
 */
public with sharing class PartsCatalogue {
    
    public set<String> folderNames{set; get;}
    public set<String> partVersions{set; get;}
    public map<String,Integer> parentIdNumberOfDocumentsMap {set;get;}
    public Map<Product2, Map<Product_Revision__c, Spares_Revision__c[]>> prodHierarchyMap{set;get;}

    public String link{set; get;}
    public String searchTxt{set; get;}
    public String Quantity{set; get;}
    public String addMasterProductRevNumber{set; get;}
    public String masterProdCode{set; get;}
    public String addMasterProdCode{set; get;}
    public String addMasterSpareRev{set; get;}

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

    public Id addProductID{set; get;}

    public Id emailTemplateId{set; get;}

    public Product2[] addAllProducts{set; get;}

    public Boolean fnd{set; get;}
    public boolean divMatch{set; get;}
    public Boolean displayAddToCollection{set; get;}
    public Boolean displayRetrievingQuantity{set; get;}
    public Boolean spareRevisionSelected{set; get;}

    public Product2 SelectedProd{set; get;}
    public Product_Revision__c prodRevision{set; get;}
    public Spares_Revision__c SelectedRev{set; get;}
    public Case thisCase{set; get;}

    private List<cNodes> hierarchy;
    public List<ProductsCollection> allProductsCollections{set; get;}

    public String nodeType{get; set;}

    /**
     * 
     */
    private void setupSettings() {
        fnd = false;
        offsetLimit = 0; //default
    }

    /**
     * PartsCatalogue Class constructor
     */
    public PartsCatalogue () {
        setupSettings();
        String thisID = ApexPages.currentPage().getParameters().get('Id');
        
        
        emailTemplateId = (Id) String.valueOf(Application_Config__c.getInstance('SendLinksEmailId').Value__c);
        
        if (thisID == null || thisID == '') {
            displayAddToCollection = false;
            apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No Case record has been selected'));
        } else {
            if (((Id) thisID).getSObjectType() == Case.SObjectType) {
                myCaseID = ApexPages.currentPage().getParameters().get('Id');
                thisCase = [SELECT Id, AccountId , Account.Id, Account.Name, CaseNumber, Contact.Email, Contact.FirstName, Contact.LastName, ContactId, Contact.Name, Owner.Name, RecordType.Name, Case_Site__c, Related_Work_Order__c FROM Case WHERE Id = :myCaseID];
            }
            displayAddToCollection = true;
        }
        nodeType = 'Product';
    }

    /**
     * 
     */
    public class ProductsCollection {
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
 
        /**
         * 
         * @param masterProdID 
         * @param ProdRevNumber 
         * @param masterProdCode 
         * @param masterSpareRev 
         * @param ProdRevId 
         * @param pd 
         * @param spareRevisionSelected 
         */
        public ProductsCollection(String masterProdID, String ProdRevNumber, String masterProdCode, String masterSpareRev, String ProdRevId, Product2  pd, Boolean spareRevisionSelected ) {
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

    /**
     * 
     */
    public class cNodes {
        //  eg <R1, Spares>
        public Map<Product_Revision__c, Spares_Revision__c[]> parent {get; set;}
        public Product2 gparent {get;set;}

        /**
         * @param gp 
         * @param p 
         */
        public cNodes(Product2  gp, Map<Product_Revision__c, Spares_Revision__c[]> p) {
            parent = p;
            gparent = gp;
        }
    }

    /**
     * 
     */
    public void assignFnd(){
        fnd = true;
        system.debug('####### fnd2 ' + fnd);
    }

    /**
     * @return  `List<cNodes>`
     */
    public List<cNodes> getmainnodes() {    
        system.debug('####### fnd1 ' + fnd);
        system.debug('####### hierarchy1 ' + hierarchy);
        if (!fnd) buildTree(null, null);
        
        system.debug('####### hierarchy2 ' + hierarchy);        
        return hierarchy;
    }   

    /**
     * @return  `PageReference`
     */
    public PageReference addToCollection() {
            
        system.debug('####### addToCollection clicked');
        if (allProductsCollections == null) allProductsCollections = new List<ProductsCollection>();
        system.debug('####### addMasterProductRevNumber ' + addMasterProductRevNumber); // + ' '+ addMasterProdCode +  ' '+ addMasterSpareRev);
        system.debug('####### addMasterProdCode ' + addMasterProdCode);
        system.debug('####### addMasterSpareRev ' + addMasterSpareRev);
        system.debug('####### addMasterProdRevId ' + addMasterProdRevId);



        allProductsCollections.add(new ProductsCollection(
            addMasterProductID, 
            addMasterProductRevNumber, 
            addMasterProdCode, 
            addMasterSpareRev, 
            addMasterProdRevId, 
            [SELECT Id, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Base_Price__c,  Product_Data__c, Product_Web_Image__c, IsActive, Site__c FROM Product2 WHERE Id =:addProductID], 
            addspareRevisionSelected)
        );
        system.debug('####### allProductsCollections ' + allProductsCollections);
        system.debug('####### addMasterProductID ' + addMasterProductID);
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference sendEmail() {

        system.debug('####### sendEmail clicked');
        try {
            if (thisCase.Contact == null) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'There is no Contact to send Email to.'));                
            } else {
                EmailTemplate thitemplate = [SELECT Name, Id, HtmlValue FROM EmailTemplate WHERE id = :emailTemplateId];

                String emailbody = thitemplate.HtmlValue;
                system.debug('####### emailbody =' + emailbody );

                List<String> recipients = new List<String>{thisCase.Contact.Email};
                String bdy = '';
                for (ProductsCollection eachProd :allProductsCollections) {
                    system.debug('####### eachProd =' + eachProd );
                    if (eachProd.selectedName) {
                        if (eachProd.selectedDrawing || eachProd.selectedFitting || eachProd.selectedTech || eachProd.selectedProdData || eachProd.selectedWebImage) {
                            bdy += 'Product Name: ' + eachProd.thisPD.Name + '<p />';
                        }
                        if (eachProd.selectedDrawing) {
                            bdy += buildAnchorTag(eachProd.thisPD.Spares_Drawing__c, 'Link to CS Drawing');
                        }
                        if (eachProd.selectedFitting) {
                            bdy += buildAnchorTag(eachProd.thisPD.Fitting_Instructions__c, 'Link to Fitting Instructions');
                        }
                        if (eachProd.selectedTech) {
                            bdy += buildAnchorTag(eachProd.thisPD.Technical_Drawing__c, 'Link to Technical Drawing');
                        }
                        if (eachProd.selectedProdData) {
                            bdy += buildAnchorTag(eachProd.thisPD.Product_Data__c, 'Link to Product Data');
                        }
                        if (eachProd.selectedWebImage) {
                            bdy += buildAnchorTag(eachProd.thisPD.Product_Web_Image__c, 'Link to Web Image');
                        }
                    }
                }
                if (String.isNotEmpty(bdy)) {
                    system.debug('####### bdy =' + bdy );
                    emailbody = emailbody.replace('++++++++', bdy);

                    emailbody = emailbody.replace('Contact.FirstName', thiscase.Contact.FirstName);
                    emailbody = emailbody.replace('Contact.LastName', thiscase.Contact.LastName);
                    emailbody = emailbody.replace('Case.OwnerFullName', thiscase.Owner.Name);

                    system.debug('####### emailbody =' + emailbody );

                    //send email
                    EmailUtils.sendHTMLEmail(recipients,'Case ID: '+thiscase.CaseNumber+' - Product Information', emailbody, thisCase.ContactId,  thisCase.Id);
                            
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Email was sent successfully.'));
                } else {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No products/documents selected, no email sent.'));
                }
            }
        } catch (Exception ex) {
            apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Email could not be sent.'));
        }
                
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference addToAsset(){
        try {
                    
            Product_Asset__c[] newAssets = new Product_Asset__c[]{}; 
            system.debug('####### allProductsCollections ' + allProductsCollections);
            for (ProductsCollection eachProd :allProductsCollections) {
                system.debug('####### addMasterProductID ' + eachProd + ' '+ spareRevisionSelected);
                if (eachProd.selectedName == true && !eachProd.thisspareRevisionSelected && (eachProd.thisproductRevisionId != '' && eachProd.thisproductRevisionId != null)) {
                    newAssets.add(new Product_Asset__c(Contact__c = thisCase.ContactId,
                    Name = eachProd.thisPD.Name, 
                    Product_Revision__c = String.isNotEmpty(eachProd.thisproductRevisionId) ? (Id) eachProd.thisproductRevisionId : null));
                }
            }
            system.debug('####### newAssets ' + newAssets);
            if (newAssets.isEmpty()) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'No Product Assets were created.'));
            } else {
                insert newAssets;
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Product Asset was created successfully.'));
            }

        } catch (Exception ex) {
            system.debug('####### error ' + ex);
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Product Asset could not be created.'));
        }
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference addToCase(){
        try {
            String bdy = 'added products via the Product Catalogue:\n\n';
            for (ProductsCollection eachProd :allProductsCollections) {
                if (eachProd.selectedName == true && (((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')))) {
                    bdy += 'Product added ' + eachProd.thisPD.Name  + ' (Revision: ' + eachProd.thisProdRevNumber + ')\n';
                } else if (eachProd.selectedName == true) {
                    bdy += 'Product added ' + eachProd.thisPD.Name  + '\n';
                }
            }

            system.debug('## bdy ' + thisCase.id + ' ' + bdy);
            insert new CaseComment(ParentId = thisCase.id, CommentBody = bdy);
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Case Comment was created successfully.'));
        } catch (Exception ex) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Case Comment could not be created.'));
        }
        
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference addToOrder(){
        divMatch = true;  // Check site on case matches site on parts else don't create order.
        countLines = 0; // Check there are lines selected before creating order.        
        for (ProductsCollection eachProd :allProductsCollections) {
            if (eachProd.selectedName == true && eachProd.thisPD.isActive && (((eachProd.thisProdRevNumber == null || eachProd.thisProdRevNumber == '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')) || ((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev != null && eachProd.thismasterSpareRev != '')))) {
                if (eachProd.selectedName && thisCase.RecordType.Name.indexOf('Heritage') != -1 && eachProd.thisPD.Site__c != '04') {
                    divMatch = false;
                }
                if (eachProd.selectedName && thisCase.RecordType.Name.indexOf('Heritage') == -1 && eachProd.thisPD.Site__c != '01') {
                    divMatch = false;
                }
                countLines = countLines + 1;
            }
        }
        if (countLines > 0) {
            if (divMatch) {
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
                for (ProductsCollection eachProd :allProductsCollections) {
                    try {
                        system.debug('## eachProd ' + eachProd  );
                        // add products (thisProdRevNumber is blank and thismasterSpareRev is blank) 
                        // and spares (thisProdRevNumber is not blank and thismasterSpareRev is not blank) but not product revision 
                        // (thisProdRevNumber is not blank but thismasterSpareRev is blank)
                        if (eachProd.selectedName && eachProd.thisPD.isActive && (((eachProd.thisProdRevNumber == null || eachProd.thisProdRevNumber == '') && (eachProd.thismasterSpareRev == null || eachProd.thismasterSpareRev == '')) || ((eachProd.thisProdRevNumber != null && eachProd.thisProdRevNumber != '') && (eachProd.thismasterSpareRev != null && eachProd.thismasterSpareRev != '')))) {
                            newOrderLines.add(new Order_Line__c(Order__c = thisneworder.Id, Quantity__c = 1, Product__c =  eachProd.thisPD.id ));
                        }
                    } catch (Exception err) {
                        System.debug('Exception in addToOrder method: ' + err.getStackTraceString());
                    }
                }
                insert newOrderLines;
                system.debug('## newOrderLines ' + newOrderLines);
                return new PageReference('/' + thisneworder.Id);
            } else {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Cannot create order.  Selected product(s) Site must match the Case Site.'));
                return null;
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'Cannot create order.  No valid selected products.'));
            return null;
        }
    }

    /**
     * @return  `PageReference`
     */
    public PageReference submitLink() {
        return null;
    }

    /**
     * @param searchID 
     * @param catlogSet 
     */
    private void buildTree(Set<Id> searchID, Set<Id> catlogSet) {
        hierarchy = new List<cNodes>();
                
        Map<id, id[]> prodToCatRev = new Map<id, id[]>();
        Map<id, Spares_Revision__c[]> catToSpares = new Map<id, Spares_Revision__c[]>();
        Spares_Revision__c[] pc2;
        if (catlogSet == null) {
            //OFFSET :offsetLimit
            pc2 = [SELECT Master_Product__c, Product_Descr__c, Code_And_Desc__c, Product_Code__c, Revision__c, Name, (SELECT id, Product_Revision__c, Name, Junction_Key__c FROM Catalog_Junctions__r) FROM Spares_Revision__c LIMIT 100];
        } else {
            //:offsetLimit
            pc2 = [SELECT Master_Product__c, Product_Descr__c, Code_And_Desc__c, Product_Code__c, Revision__c, Name, (SELECT id, Product_Revision__c, Name, Junction_Key__c FROM Catalog_Junctions__r WHERE id IN :catlogSet) FROM Spares_Revision__c];
        }

        for (Spares_Revision__c eachpart : pc2) {
            for (Catalogue_Junction__c eachCat : eachpart.Catalog_Junctions__r) {
                if (!prodToCatRev.containsKey(eachpart.id)) {
                    prodToCatRev.put(eachpart.id, new id[]{}); 
                }
                prodToCatRev.get(eachpart.id).add(eachCat.id);

                if (!catToSpares.containsKey(eachCat.id)) {
                    catToSpares.put(eachCat.id, new Spares_Revision__c[]{}); 
                }       
                catToSpares.get(eachCat.id).add(eachpart);
            }
        }

        Product_Revision__c[] prods;
        if (searchID == null) {
            //='a0Wc0000000lk9g'  :Limits.getLimitQueryRows()
            prods = [SELECT Revision__c, Product_Code__c, Master_Product__c, Master_Product__r.Name, Name, Product_Descr__c, Code_And_Desc__c, Product_ID__c, (SELECT id, Product_Revision__c, Name, Junction_Key__c FROM Catalog_Junctions__r) FROM Product_Revision__c WHERE id IN :prodToCatRev.keyset()];
        } else {
            prods = [SELECT Revision__c, Product_Code__c, Master_Product__c, Master_Product__r.Name, Name, Product_Descr__c, Code_And_Desc__c, Product_ID__c, (SELECT id, Product_Revision__c, Name, Junction_Key__c FROM Catalog_Junctions__r) FROM Product_Revision__c WHERE id IN :searchID];
        }

        Set<id> allProds = new Set<id>();
        for (Product_Revision__c eachprod: prods) {
            allProds.add(eachprod.Master_Product__c);
        }

        Map<id, Product2> prodMap = new Map<id, Product2>([SELECT id, Name, Name_Site__c, Base_Price__c, IsActive FROM Product2 WHERE id IN :allProds]);
                
        prodHierarchyMap = new Map<Product2, Map<Product_Revision__c, Spares_Revision__c[]>>();
        integer cntr = 0;
        for (Product_Revision__c eachprod: prods) {

            Map<Product_Revision__c, Spares_Revision__c[]> allSpares = new Map<Product_Revision__c, Spares_Revision__c[]>();
                                
            for (Catalogue_Junction__c eachCat : eachprod.Catalog_Junctions__r) {
                if (catToSpares.containskey(eachCat.id)) {
                    for (Spares_Revision__c eachSpare : catToSpares.get(eachCat.id)) {
                        if (eachprod != null && !allSpares.containsKey(eachprod)) {
                            allSpares.put(eachprod, new Spares_Revision__c[]{}); 
                        }
                        allSpares.get(eachprod).addall(catToSpares.get(eachCat.id));
                    }
                }
            }

            if (!allSpares.isempty()) {
                if (!prodHierarchyMap.containsKey(prodMap.get(eachprod.Master_Product__c))) {
                    prodHierarchyMap.put(prodMap.get(eachprod.Master_Product__c), allSpares); 
                }
                prodHierarchyMap.get(prodMap.get(eachprod.Master_Product__c)).putall(allSpares);
            }

            ++cntr;
            if (cntr == 100) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Too many records were returned, please improving the search criteria. A limited number of records have been returned'));
                break;
            }
        }
                
        if (!prodHierarchyMap.isempty()) {
            for (Product2 eachProd :prodHierarchyMap.keyset()) {
                hierarchy.add(new cNodes(eachProd, prodHierarchyMap.get(eachProd)));
            }
        }

    }

    /**
     * @return  `PageReference`
     */
    public PageReference searchProd() {
        Set<Id> prodSet = new Set<Id>();
        Set<Id> catlogSet = new Set<Id>();
                
        searchTxt = searchTxt.toUpperCase();
        searchTxt = searchTxt.trim();
        // Wrapping text around single quotes
        searchTxt = '\'' + searchTxt + '\'';
        system.debug('###prodSet ' +'Select id From Product_Revision__c where Product_Code__c Like \'%' + searchTxt + '%\' or Product_Descr__c Like \'%' + searchTxt + '%\'' );

        for (Product_Revision__c pr : [SELECT Id, (SELECT id, Product_Revision__c, Name, Junction_Key__c FROM Catalog_Junctions__r) FROM Product_Revision__c WHERE Product_Code__c LIKE :searchTxt OR Product_Descr__c LIKE :searchTxt]) {
            prodSet.add(pr.id);
            for (Catalogue_Junction__c eachcat: pr.Catalog_Junctions__r) {
                catlogSet.add(eachcat.id);
            }
        }
                
        system.debug('###catlogSet ' +catlogSet );
        system.debug('###prodSet ' +prodSet );  
                
        buildTree(prodSet, catlogSet);
        fnd = true;
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference nextProd() {
        offsetLimit += 20;
        searchProd();
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference selectProd() {
        system.debug('###selectProd ');
        system.debug('###prodID ' +prodID); 
        Quantity = 'NOT Queried'; 
        //Quantity = 'Querying for quantity.........';
        SelectedRev = null;
        prodRevision = null;
        spareRevisionSelected = false;
        SelectedProd = [SELECT Site__c, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Product_Data__c, Product_Web_Image__c, Description, Short_Description__c, id, Base_Price_Plus_VAT__c, IsActive, Supplier_Held__c, Guarantee__c, Qty_Available__c FROM Product2 WHERE id = :prodID];
        masterProdID = prodID;
        masterProdCode = SelectedProd.ProductCode;

        system.debug('###SelectedProd ' +SelectedProd); 
        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference selectProdRevision() {
        selectProd();
                
        prodRevision = [SELECT Site__c, Name, Revision_Date__c, Revision__c, Id  FROM Product_Revision__c WHERE Id = :prodRevID];

        return null;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference selectRevsion() {
        system.debug('###selectRevsion just started');
                
        system.debug('###revID =' + revID);
                 
        SelectedRev = [SELECT Master_Product__c, Product_Code__c, Revision__c, Name, Revision_Date__c, id FROM Spares_Revision__c WHERE Id = :revID];
        SelectedProd = [SELECT Site__c, Name, ProductCode, Spares_Drawing__c, Technical_Drawing__c, Fitting_Instructions__c, Product_Data__c, Product_Web_Image__c, Description, Short_Description__c, id, Base_Price_Plus_VAT__c, IsActive, Supplier_Held__c, Guarantee__c, Qty_Available__c FROM Product2 WHERE id = :SelectedRev.Master_Product__c];
        prodRevision = [SELECT Site__c, Name, Revision_Date__c, Revision__c, Id FROM Product_Revision__c WHERE id = :prodRevID];
        spareRevisionSelected = true;
                
        //Quantity = 'Querying for quantity.........'; 
        Quantity = 'NOT Queried'; 
                
        system.debug('###SelectedRev ' +SelectedRev); 
        system.debug('###SelectedProd ' +SelectedProd); 
        return null;
    }

    /**
     * 
     */
    public void qtyCallout() {
        system.debug('########### qtyCallout just started ');
        //Quantity = 'Querying for quantity'; 
                 
        system.debug('########### SelectedProd =' + SelectedProd); 
        if (SelectedProd != null) {
            Product2 prd = SelectedProd;
                
            system.debug('###########qtyCallout just started '); 
                        
            system.debug('########### prd =' + prd); 
            system.debug('########### prd.ProductCode =' + prd.ProductCode); 
            system.debug('########### prd.Name =' + prd.Name ); 
            system.debug('########### prd.Site__c =' + prd.Site__c); 
                        
                        
            QuantityRequestCallout h = new QuantityRequestCallout();
                         
            if (!Test.isRunningTest()) {
                Quantity = h.main(prd.Name , '',prd.Site__c);
                if (Quantity == '') {
                    Quantity = 'No Response from Quantity Server';
                    //apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'Service timed out'));
                }
            }       
        }
        displayRetrievingQuantity = false;
    }

    /**
     * @return  `PageReference`
     */
    public PageReference retrievingQty() {
        displayRetrievingQuantity = true;
        Quantity = 'Querying for quantity'; 
                
        system.debug('###displayRetrievingQuantity ' +displayRetrievingQuantity); 
        return null;
    }

    private String buildAnchorTag(String href, String label) {
        return '<a href="' + href + '" target="_blank">' + label + '</a><p />';
    }
}