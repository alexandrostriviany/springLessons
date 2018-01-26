package beans;

import org.springframework.stereotype.Service;

@Service
public class ConsoleEventLogger implements EventLogger {
	public void logEvent(Event event) {
		System.out.println(event.toString());
	}
}
