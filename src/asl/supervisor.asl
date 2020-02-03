// Agent disambiguation_task in project supervisor

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <-
	.verbose(2);
	configureNode;
	startParameterLoaderNode("/disambi.yaml");
	startROSNode;
	initServices;
	.create_agent(robot, "src/asl/disambiguation_task.asl", [agentArchClass("arch.agarch.RobotAgArch"), beliefBaseClass("rjs.agent.TimeBB"), agentClass("rjs.agent.LimitedAgent")]);.
	
	
+~connected_srv(S) : true <- .print("service not connected : ", S).