/**This trigger copy all case comments from a cloned case to the new case
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since Aut 2019
**/
trigger caseCloneCaseComments on Case (after insert) {
    for(case cs :trigger.new) { 
        if(cs.isClone()) {
            string csId = cs.getCloneSourceId();
            List<CaseComment> comments = [SELECT ParentId, CommentBody from CaseComment WHERE ParentId = :csId ORDER BY CreatedDate ASC];
            for(CaseComment comment : comments) {
                CaseComment cc = new CaseComment();
                cc.CommentBody = comment.CommentBody;
                cc.ParentId = cs.Id;
                insert cc;
            }
        }
    }
}