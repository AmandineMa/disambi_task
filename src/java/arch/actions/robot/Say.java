package arch.actions.robot;

import org.ros.node.topic.Publisher;

import jason.asSemantics.ActionExec;
import rjs.arch.actions.AbstractAction;
import rjs.arch.agarch.AbstractROSAgArch;

public class Say extends AbstractAction {

	private Publisher<std_msgs.String> sayPub; 

	public Say(ActionExec actionExec, AbstractROSAgArch rosAgArch, Publisher<std_msgs.String> sayPub) {
		super(actionExec, rosAgArch);
		this.sayPub = sayPub;
		setSync(true);
	}

	@Override
	public void execute() {
		String param = removeQuotes(actionExec.getActionTerm().getTerm(0).toString());
		std_msgs.String str = sayPub.newMessage();
		str.setData(param);
		sayPub.publish(str);
		actionExec.setResult(true);
	}

}
