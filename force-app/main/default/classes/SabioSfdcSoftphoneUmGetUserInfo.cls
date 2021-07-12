public with sharing class SabioSfdcSoftphoneUmGetUserInfo {
    public SabioSfdcSoftphoneUmGetUserInfo() {
        //Do nothing
    }
    
    public String getUserId() {
        return UserInfo.getUserId();
    }
}