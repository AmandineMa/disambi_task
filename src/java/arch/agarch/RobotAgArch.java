package arch.agarch;

import org.ros.message.MessageListener;

import jason.asSyntax.StringTermImpl;
import rjs.arch.agarch.AbstractROSAgArch;

public class RobotAgArch extends AbstractROSAgArch {

	public RobotAgArch() {
		super();
	}

	@Override
	public void init() {
		MessageListener<std_msgs.String> clicked_object = new MessageListener<std_msgs.String>() {
			public void onNewMessage(std_msgs.String msg) {
				StringTermImpl str = new StringTermImpl(msg.getData());
				addBelief("clicked_object("+str+")");
			}
		};
		rosnode.addListener("disambi/topics/clicked_object", std_msgs.String._TYPE, clicked_object);
	}


}
