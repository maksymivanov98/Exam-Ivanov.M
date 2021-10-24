@isTest
public class SensorTests {
    
static testMethod void testSensorRestServices(){
      /*SensorModel sensor = new SensorModel();
        sensor.sensorid = '1';
        SensorModel.Vector vector = new SensorModel.Vector(10,20,30);
        sensor.vectorsList.add(vector);*/
        String json = '{"sensor": {"sensorid": "1", "vectorsList": [{"x": 22,"y": 17,"z": 197}, {"x": 23, "y": 45,"z": 14},{"x": 23, "y": 55,"z": 17}, { "x": 22, "y": 43,"z": 199}, {"x": 23, "y": 55,"z": 14}, { "x": 22, "y": 43,"z": 196}, {"x": 24,"y": 42,"z": 198} ] }}';
	SensorModel obj = SensorModel.parse(json);  
        SensorRestServices.createSensor(obj);
    }
    
    static testMethod void testParseSensorModel() {
		String json = '{\"sensorid\": \"1\", \"vectors\": [{\"x\": 22,\"y\": 17,\"z\": 197}, {\"x\": 23, \"y\": 45,\"z\": 14}, { \"x\": 22, \"y\": 43,\"z\": 196}, {\"x\": 24,\"y\": 42,\"z\": 198} ] }';
		SensorModel obj = SensorModel.parse(json);
		System.assert(obj != null);
	}
    
    static testMethod void testSensorControllerGetList() {
		SensorController.getSensorList();
	}
    
    static testMethod void testSensorControllerGetSelected() {
        Sensor__c sensor = new Sensor__c(Name = 'SensorTestRecord');
        insert sensor;
		SensorController.getSelectedSensor(sensor.id);
	}
    
}
