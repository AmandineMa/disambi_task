package ros;

import java.util.HashMap;

import org.ros.namespace.GraphName;

import rjs.ros.AbstractRosNode;

public class RosNodeDisambi extends AbstractRosNode {

	public RosNodeDisambi(String name) {
		super(name);
	}

	@Override
	public GraphName getDefaultNodeName() {
		return GraphName.of("supervisor_disambi");
	}
	
	@SuppressWarnings("unchecked")
	public void init() {
		super.init();
		servicesMap = (HashMap<String, HashMap<String, String>>) parameters.getMap("/disambi/services");
		
	}

}
