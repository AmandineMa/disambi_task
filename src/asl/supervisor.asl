// Agent disambiguation_task in project supervisor

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <-
	configureNode;
	startParameterLoaderNode("/general.yaml", "/robot_decision.yaml");
	startROSNode;
	initServices;
	.create_agent(plan_manager, "src/asl/plan_manager.asl", [agentArchClass("arch.agarch.RobotAgArch"), beliefBaseClass("rjs.agent.TimeBB"), agentClass("rjs.agent.LimitedAgent")]);
	.create_agent(robot_decision, "src/asl/robot_decision.asl", [agentArchClass("arch.agarch.RobotAgArch"), beliefBaseClass("rjs.agent.TimeBB"), agentClass("rjs.agent.LimitedAgent")]);.
//	.create_agent(robot, "src/asl/disambiguation_task.asl", [agentArchClass("arch.agarch.RobotAgArch"), beliefBaseClass("rjs.agent.TimeBB"), agentClass("rjs.agent.LimitedAgent")]);.
	
	
+~connected_srv(S) : true <- .print("service not connected : ", S).