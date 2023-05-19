package api.data;

import java.util.Random;

public class GenerateData {

	public static String getEmail() {
		String email = "dragonspostman";
		String provider = "@tekschool.us";
		int randomNumber = (int) (Math.random() * 100000);
		String autoEmail = email + randomNumber + provider;
		return autoEmail;
	}

	public static String getRandomPhoneNumber() {
		Random rand = new Random();
		int num1, num2, num3;
		num1 = rand.nextInt(900) + 100;
		num2 = rand.nextInt(123) + 100;
		num3 = rand.nextInt(9000) + 1000;
		String randomNums = num1 + "-" + num2 + "-" + num3;
		return randomNums;
	}

	public static String getLicensePlate() {
		// Generate three random uppercase letters
		int letter1 = 65 + (int) (Math.random() * (90 - 65));
		int letter2 = 65 + (int) (Math.random() * (90 - 65));
		int letter3 = 65 + (int) (Math.random() * (90 - 65));

		// Generate four random digits
		int number1 = (int) (Math.random() * 10);
		int number2 = (int) (Math.random() * 10);
		int number3 = (int) (Math.random() * 10);
		int number4 = (int) (Math.random() * 10);

		// Display number plate
		String licensePlate = "" + (char) (letter1) + ((char) (letter2)) + ((char) (letter3)) + number1 + number2
				+ number3 + number4;
		return licensePlate;
	}
}
