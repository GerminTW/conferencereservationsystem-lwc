trigger ConferenceRoomTrigger on ConferenceRoom__c (after insert, after update) {
	new Triggers()
	.bind(Triggers.Evt.afterInsert, new ConferenceRoomUpdateNameHandler())
	.bind(Triggers.Evt.afterUpdate, new ConferenceRoomUpdateNameHandler())
	.manage();
}