@isTest
private class SabioSfdcSoftphoneUmGetUserInfoTest {
    static testMethod void getUserIdTest() {
        String userName = new SabioSfdcSoftphoneUmGetUserInfo().getUserId();
        System.assertEquals(true, userName != null);
    }
}