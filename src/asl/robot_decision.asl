// Agent robot_decision in project disambi_task
{ include("common.asl")}

/* Initial beliefs and rules */
robotState(idle).

/* Initial goals */

!start.

/* Plans */

+!start : true <-
	.verbose(2);
//	rjs.jia.log_beliefs;
	!getRobotName.

+action(ID,Name,Agents,Cost) : robotState(idle) & robotName(Agent) & .member(Agent,Agents) <-
	-+robotState(acting);
	-action(ID,Name,Agents,Cost)[source(_)];
	.concat("/robot_decision/action_names/",Name,HATPName);
	rjs.jia.get_param(HATPName, "String", ActName);
	.term2string(Action,ActName);
	.send(plan_manager, tell, action(ID,"ongoing"));
	if(rjs.jia.believes(actionParams(ID,Params))){
		?actionParams(ID,Params);
		Act =.. [Action, [Params],[]];
		Act;
	}else{
		Action;
	}
	-+robotState(idle);
	+action(ID,Name,"executed");
	.send(plan_manager, tell, action(ID,"executed")).
	
