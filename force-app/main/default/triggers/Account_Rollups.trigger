// This trigger populates the 'Number of Orders' field on accounts,
// Custom roll up field for reporting

trigger Account_Rollups on Account (before insert, before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        Account_RollupsHandler.calculateRollUps(Trigger.new);
    }
}