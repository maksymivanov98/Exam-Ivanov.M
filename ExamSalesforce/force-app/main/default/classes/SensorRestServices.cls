@RestResource(urlMapping='/Sensors/*')
global class SensorRestServices {
@HttpPost
    global static Sensor__c createSensor(SensorModel sensor){             
        Sensor__c sensorRecord;
        List<Sensor_Event__c> sensorVectors= new List <Sensor_Event__c>();
        List<Sensor__c> sensorscount = [SELECT 
                                        id,
                                        Name
                                        FROM Sensor__c WHERE Name =: sensor.sensorid];
        if(sensorscount.size()==0){
            Sensor__c sensorNew = new Sensor__c(Name = sensor.sensorid);
            insert sensorNew;
            sensorRecord = sensorNew;
            for(integer i = 0;i<sensor.vectorsList.size();i++){
            Sensor_Event__c vectors  = new Sensor_Event__c(Sensor__c = sensorNew.Id, X__c = sensor.vectorsList[i].X,Y__c =sensor.vectorsList[i].Y ,Z__c = sensor.vectorsList[i].Z);
            sensorVectors.add(vectors);
            }
        insert sensorVectors;
        }else{
            sensorRecord = sensorscount.get(0);
            List<Sensor_Event__c> sensorEvents= [SELECT 
                                                 id, 
                                                 X__c, 
                                                 Y__c, 
                                                 Z__c 
                                                 FROM Sensor_Event__c WHERE Sensor__c =: sensorscount.get(0).Id];
            for(integer i = 0;i<sensor.vectorsList.size();i++){
                for(integer m = 0;m<sensorEvents.size();m++){
                   if(sensorEvents.get(m).X__c == sensor.vectorsList.get(i).x && sensorEvents.get(m).Y__c == sensor.vectorsList.get(i).y && sensorEvents.get(m).Z__c == sensor.vectorsList.get(i).z){
                        break;
                   } else if(m == sensorEvents.size()-1 && sensorEvents.get(m).X__c != sensor.vectorsList.get(i).x){
                       Sensor_Event__c event = new Sensor_Event__c(X__c = sensor.vectorsList.get(i).x, Y__c = sensor.vectorsList.get(i).y, Z__c = sensor.vectorsList.get(i).z, Sensor__c = sensorscount.get(0).id);
                       sensorVectors.add(event);
                   }
                }
            }
            insert sensorVectors;
        }
        return sensorRecord;
    }
}