package beans;

import java.text.DateFormat;
import java.util.Date;
import java.util.Random;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Event {
	private int id;
	private DateFormat df;
	private String msg;
	private Date date;

	public String toString() {
		return "id:       " + id + "\nmessage:  " + msg + "\ndate:     " + df.format(date);
	}

	public Event(Date date, DateFormat df) {
		this.df = df;
		this.date = date;
		this.id = new Random().nextInt(6) + 5;
	}
}
