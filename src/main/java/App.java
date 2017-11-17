import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class App {
	private Client client;
	private ClientEventLogger eventLogger;
	public static void main(String[] args){

		App app = new App();

		app.client = new Client();
		app.client.setFullName("John Snow");
		app.client.setId("15");
		app.eventLogger = new ClientEventLogger();
		app.logEvent("You know nothing 15");
	}

	private void logEvent(String msg){
		String message = msg.replaceAll(client.getId(), client.getFullName());
		eventLogger.logEvent(message);
	}

}
