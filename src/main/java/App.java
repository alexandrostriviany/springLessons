import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import beans.Client;
import beans.Event;
import beans.EventLogger;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class App {

	private Client client;
	private EventLogger eventLogger;
	@Autowired
	private Event event;

	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
		App app = (App) ctx.getBean("app");
		Event event = (Event) ctx.getBean("event");
		event.setMsg("Fuck off");
		app.logEvent(event);
	}

	@Autowired
	public App(Client client, EventLogger eventLogger) {
		super();
		this.client = client;
		this.eventLogger = eventLogger;
	}

	private void logEvent(Event msg) {
		eventLogger.logEvent(msg);
	}

}
