public class WorkOrderExtension {
    private ApexPages.StandardController sc;
    public WorkOrderExtension(ApexPages.StandardController sc) {  
        this.sc = sc;
        WorkOrder wo = (WorkOrder)sc.getRecord();
        if(wo.Id == null) {
            Map<String, String> m = ApexPages.currentPage().getParameters();
            if(m.get('accId') != '')
              wo.AccountId = (Id)m.get('accId');
            if(m.get('conId') != '')
              wo.ContactId = (Id)m.get('conId');
            if(m.get('caseId') != '')
              wo.CaseId = (Id)m.get('caseId');
        }
    }
}