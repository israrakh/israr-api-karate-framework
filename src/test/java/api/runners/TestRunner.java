package api.runners;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	// run() method required path to feature files.
	// you can use tags() method to specify the Tags.
	@Karate.Test
	public Karate runTests() {
		return Karate.run("classpath:features").tags("Regression");
	}
}
