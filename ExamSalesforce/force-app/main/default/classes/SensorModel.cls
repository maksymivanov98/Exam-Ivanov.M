global class SensorModel {
    public String sensorid;
	public List<Vector> vectorsList;

	public class Vector {
	    public Integer x;
	    public Integer y;
		public Integer z;
	}
    
    public static SensorModel parse(String json) {
		return (SensorModel) System.JSON.deserialize(json, SensorModel.class);
	}
}