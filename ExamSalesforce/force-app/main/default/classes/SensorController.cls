public with sharing class SensorController {
@AuraEnabled(cacheable=true)
    public static List<Sensor__c> getSensorList() {
        return [SELECT 
                id, 
                Name, 
                Max_Vectors_Length__c 
                FROM Sensor__c LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Sensor_Event__c> getSelectedSensor(String idSelected) {
        return [SELECT 
                id, 
                Name,
                Sensor__c, 
                X__c, 
                Y__c, 
                Z__c, 
                Modulus_Vector_Length__c 
                FROM Sensor_Event__c WHERE Sensor__c =: idSelected];
    }
}