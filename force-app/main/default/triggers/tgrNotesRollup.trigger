// This trigger rolls up Opportunity 'Notes' field to proj 'Notes Rollup' field

trigger tgrNotesRollup on Opportunity (after insert, before update) { 
    
    if ((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)) {
        OpportunityTriggerHandler.updateNoteOnProjects(Trigger.new);
    }
    
}