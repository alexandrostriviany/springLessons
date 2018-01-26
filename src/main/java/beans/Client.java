package beans;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class Client {

	private String id;
	private String fullName;

	public Client(String id, String fullName) {
		this.id = id;
		this.fullName = fullName;
	}
}
