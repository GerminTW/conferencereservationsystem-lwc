public with sharing class ConferenceRoomUpdateNameHandler implements Triggers.Handler {

    public void handle() {
        
        List<ConferenceRoom__c> conferenceRoomList = new List<ConferenceRoom__c>();
        if(Trigger.isInsert) {

            for(ConferenceRoom__c conferenceRoom : [SELECT Building__r.City__c,
                                                            Floor__c,
                                                            RoomNo__c
                                                    FROM ConferenceRoom__c
                                                    WHERE Id IN :Trigger.new]){

                ConferenceRoom__c cr = new ConferenceRoom__c();
                cr.Id = conferenceRoom.Id;
                // considering adding some validation rules to gurantee the data quality.City and floor should be accurate while initing.
                cr.Name = conferenceRoom.Building__r.City__c + conferenceRoom.Floor__c + '/' + conferenceRoom.RoomNo__c;
                conferenceRoomList.add(cr);
            }
        }
        if(Trigger.isUpdate) {

            Map<Id,ConferenceRoom__c> idConferenceMap = new Map<Id,ConferenceRoom__c>();
            for(ConferenceRoom__c conferenceRoom : ((List<ConferenceRoom__c>)Trigger.old)) {

                idConferenceMap.put(conferenceRoom.Id, conferenceRoom);
            }
            for(ConferenceRoom__c conferenceRoom : [SELECT Building__r.City__c,
                                                            Floor__c,
                                                            RoomNo__c
                                                    FROM ConferenceRoom__c
                                                    WHERE Id IN :Trigger.new]){
                if(idConferenceMap.containsKey(conferenceRoom.Id) &&
                    idConferenceMap.get(conferenceRoom.Id).RoomNo__c != conferenceRoom.RoomNo__c) {

                    ConferenceRoom__c cr = new ConferenceRoom__c();
                    cr.Id = conferenceRoom.Id;
                    // considering adding some validation rules to gurantee the data quality.City and floor should be accurate while initing.
                    cr.Name = conferenceRoom.Building__r.City__c + conferenceRoom.Floor__c + '/' + conferenceRoom.RoomNo__c;
                    conferenceRoomList.add(cr);
                }
            }
        }
        if(conferenceRoomList.size() > 0) {

            update conferenceRoomList;
        }
    }
}