/**This trigger copy all case comments from a cloned case to the new case
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since Aut 2019
**/
trigger caseCloneCaseComments on Case (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        CaseTriggerHandler.copyAllCommentsFromCase(Trigger.new);
    }

}