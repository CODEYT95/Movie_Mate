package controller.movie;

import java.util.Calendar;
import java.util.Timer;

public class test {
	public static void main(String[] args) {
		DailyUpdate rankUpdate = new DailyUpdate();
		Timer timer = new Timer();
		Calendar date = Calendar.getInstance();
		date.set(Calendar.AM_PM, Calendar.AM);
		date.set(Calendar.HOUR, 0);
		date.set(Calendar.MINUTE, 10);
		date.set(Calendar.SECOND, 0);
		date.set(Calendar.MILLISECOND, 0);

		timer.scheduleAtFixedRate(rankUpdate, date.getTime(), 1000 * 60 * 60 * 24);
	}
}