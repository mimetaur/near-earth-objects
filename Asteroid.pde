class Asteroid {
	public AsteroidDataField<String> name;
	public AsteroidDataField<Float> magnitude;
	public AsteroidDataField<Float> diameter;
	public AsteroidDataField<Boolean> isPotentiallyHazardous;

	Asteroid(JSONObject asteroidAsJson) {
		name = addDataField("name", asteroidAsJson.getString("name"));
		magnitude = addDataField("absolute magnitude (h)", asteroidAsJson.getFloat("absolute_magnitude_h"));

		// note - all values use kilometers when a choice is given in API
		diameter = addDataField("estimated diameter", calculateMidpoint("estimated_diameter_min", "estimated_diameter_min", asteroidAsJson.getJSONObject("estimated_diameter").getJSONObject("kilometers")), "kph");

		isPotentiallyHazardous = addDataField("potentially hazardous?", asteroidAsJson.getBoolean("is_potentially_hazardous_asteroid"));
	}

	public String toString() {
		return name.toString();
	}

	private AsteroidDataField<String> addDataField(String name, String value) {
		return new AsteroidDataField(name, value);
	}

	private AsteroidDataField<Float> addDataField(String name, float value) {
		return new AsteroidDataField(name, value);
	}

	private AsteroidDataField<Float> addDataField(String name, float value, String units) {
		return new AsteroidDataField(name, value, units);
	}

	private AsteroidDataField<Boolean> addDataField(String name, boolean value) {
		return new AsteroidDataField(name, value);
	}

	private float calculateMidpoint(String min, String max, JSONObject json) {
		return calculateMidpoint( json.getFloat(min), json.getFloat(max) );
	}

	private float calculateMidpoint(float min, float max) {
		float sum = min + max;
		return sum / 2;
	}
}




