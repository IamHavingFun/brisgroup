/*
 * This trigger updates:
 *   The account number field on the Contact if the Account is a Direct account
 *   The account record type field on the Contact
 *   Mobile Phone Email field on Contact (for SMS messaging)
 *   GDPR Confirmed Date field on Contact
 * Author : Steve Mason
 * since  : March 2019
 * E-Mail : smason@bristan.com
 */
trigger contactFieldUpdates on Contact (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Update contact fields before records are persisted to the Database
        ContactTriggerHandler.updateContactFields(Trigger.new);
    }


}