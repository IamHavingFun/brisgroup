/**
 * @author  PolSource
 */

trigger LeadTrigger on Lead (before insert,before update) {


    /** This trigger is for updating the 'Division'custom field on 'Lead'record based upon on Lead Owner's 'Division'.
    *   For example-If Lead Owner's 'Division' is 'Trade' that the custom 'Division' field will have value 'Trade'.
    *  Author-Hema kulkarni
    *  Since-May 2012
    *  Email-hkulkarni@innoveer.com
    **/
    LeadTriggerHandler.updateDivisionfield(Trigger.new);

}