/**
 * @author PolSource
 */
public with sharing class OrderLineTriggerHandler {

    private OrderLineTriggerHandler() {}

    /**
     * @param records `List<Order_Line__c>` list of records to delete
     */
    public static void validatePermissionBeforeDelete(List<Order_Line__c> records) {
        Boolean isAllowed = false;
        List<String> profileNames = new List<String>{'Service User','Service Back Office User','Service Knowledge Contributer','Heritage User','Engineer User','System Administrator'};
        List<String> allowedUserLevels = new List<String>{'Head of Customer Service', 'Coach', 'Team Leader', 'SysAdmin'};
        // Get list of profiles
        Profile[] systemProfiles = [SELECT Name, Id FROM Profile WHERE Name IN :profileNames];
        system.debug('#### systemProfiles = ' + systemProfiles + ' ####');
  
        // Get context user's Level
        String UserLevel = [SELECT Id, Level__c FROM User WHERE Id = :UserInfo.getUserId()].Level__c;
        // get context user's Profile Id
        String contextUserProfile = UserInfo.getProfileId();
        // loop through all Order Line records
        for (Order_Line__c orderLine : records) {
          for (Profile systemProfile : systemProfiles) {
            system.debug('#### systemProfile  = ' + systemProfile + ' ####');
            // validate if current profile matches user's profile
            if (contextUserProfile == systemProfile.id) {
              system.debug('#### Profile Match ####');
              // If user's level is one of the values defined on `allowedUserLevels` list, then allow operation to continue
              if (allowedUserLevels.contains(UserLevel)) {
                system.debug('#### ALLOWED ####');
                isAllowed = true;
              }
            }
          }
          if (!isAllowed) {
            orderLine.addError('You do not have access to delete Order Lines.');
          }
        }
    }
}