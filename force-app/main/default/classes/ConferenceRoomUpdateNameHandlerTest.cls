@isTest
private class ConferenceRoomUpdateNameHandlerTest {
    static testMethod void testUpdateConferenceRoomNameHandler() {

        Building__c building = new Building__c();
        building.Name = '保利国际中心';
        building.Country__c = 'China';
        // Ignore the building city changing case, builing city should be required and accurate while initing
        building.City__c = 'Wuhan';
        building.Location__c = '武汉市东湖新技术开发区关山大道332号保利·时代K18地块A栋保利国际中心20层2001号';
        insert building;

        ConferenceRoom__c conferenceRoom = new ConferenceRoom__c();
        // conferenceRoom.Name = '';
        conferenceRoom.Building__c = building.Id;
        conferenceRoom.Floor__c = '32F';
        conferenceRoom.RoomNo__c = 'N1';
        conferenceRoom.Facility__c = 'Zoom视频;';
        conferenceRoom.Capacity__c = 4;
        insert conferenceRoom;

        Boolean matchInsertConferenceRoomName = false;
        Boolean matchUpdateConferenceRoomName = false;
        for(ConferenceRoom__c room : [SELECT Name FROM ConferenceRoom__c]) {

            if(room.Name == 'Wuhan32F/N1') {

                matchInsertConferenceRoomName = true;
            }
        }
        System.assertEquals(true, matchInsertConferenceRoomName);

        conferenceRoom.RoomNo__c = 'N10';
        conferenceRoom.Facility__c = 'Zoom视频;空调;';
        conferenceRoom.Capacity__c = 6;
        update conferenceRoom;

        for(ConferenceRoom__c room : [SELECT Name FROM ConferenceRoom__c]) {

            if(room.Name == 'Wuhan32F/N10') {

                matchUpdateConferenceRoomName = true;
            }
        }
        System.assertEquals(true, matchUpdateConferenceRoomName);
    }
}