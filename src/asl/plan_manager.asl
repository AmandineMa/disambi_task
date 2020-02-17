// Agents plan_manager in project disambi_task
{ include("common.asl")}
/* Initial beliefs and rules */
/* Initial goals */
!start.

+!start : true <- 
	.verbose(2); 
	!getRobotName;
	rjs.jia.log_beliefs;
	+newGoal("ThrowAll",0).

/* Plans */


+newGoal(Goal,Priority) : true <-
	.abolish(_);
	+currentGoal(Goal,Priority);
	-newGoal(Goal,Priority)[source(_)].
	
+currentGoal(Goal,Priority): true <-
	!getNewPlan(Goal).
	
+!getNewPlan(Goal) : true <-
	getHatpPlan(Goal);
	?plan(ID,_);
	-+currentPlan(ID, Goal).
	
+currentPlan(ID, Goal) : true <-
	?plan(ID,Actions);
	.findall(X, 
		action(X,"planned",Name,Agents,Cost) 
		& .findall(Origin, link(Origin,P) & .empty(P), L) 
		& .member(X,L), A
	);
	for(.member(X,A)){
		?action(X,"planned",Name,Agents,Cost);
		-action(X,"planned",Name,Agents,Cost);
		+action(X,"todo",Name,Agents,Cost);
	}.
	
wantedAction(Name,Params) :- (action(ID,"todo",Name,Agents,_) | action(ID,"ongoing",Name,_,_)) & actionParams(ID,Params).
	
+actionExecuted(Name, Params) :  true <-
	-actionExecuted(Name,Params)[source(_)];
	!actionExecuted(Name,Params).
	
+action(ID, "executed") : true <-
	-action(ID, "executed")[source(_)];
	?action(ID,_,Name,_,_);
	?actionParams(ID,Params);
	!actionExecuted(Name, Params).
	
+!actionExecuted(Name,Params) : wantedAction(Name,Params) <-
	-action(ID,"todo",Name,Agents,Cost);
	+action(ID,"executed",Name,Agents,Cost);
	!updatePlan.
	
+!actionExecuted(Name,Params) : not wantedAction(Name,Params) <-
	?currentGoal(Goal,_);
	?currentPlan(ID,Goal);
	!endPlan(ID);
	!getNewPlan(Goal).
	
+!endPlan(IDp): true <-
	for( .findall(IDa, action(IDa,"planned",_,_,_) | action(IDa,"todo",_,_,_), Actions ) & .member(X, Actions)){
		.abolish(actionParams(IDa,_));
	}
	.abolish(action(_,"planned",_,_,_));
	.abolish(action(_,"todo",_,_,_));
	.abolish(link(_,_));
	.abolish(link(_));
	-plan(IDp,_).
	
+actionOnGoing(Name, Params) : true <-
	-actionOnGoing(Name,Params)[source(_)];
	!actionOnGoing(Name, Params).
	
+action(ID, "ongoing") : true <-
	-action(ID, "ongoing")[source(_)];
	?action(ID,_,Name,_,_);
	?actionParams(ID,Params);
	!actionOnGoing(Name, Params).
	
+!actionOnGoing(Name, Params) : not wantedAction(Name,Params) <-
	.send(robot_decision, tell, actionOnGoingNotWanted(Name,Params)).
	
+!actionOnGoing(Name, Params) : wantedAction(Name,Params) <-
	+action(ID,"ongoing",Name,Agents,Cost);
	-action(ID,_,Name,Agents,Cost).
	
	
+!updatePlan : true <-
	
	for(link(Origin,Preds)){
		.findall(action(X,"planned",Name,Agents,Cost),
			.findall(P, action(P,"executed",_,_,_) & .member(P,Preds), PredsL)
			& .difference(Preds,PredsL,Diff)
			& .empty(Diff)
			& action(Origin,"planned",Name,Agents,Cost) 
			& action(X,"planned",Name,Agents,Cost) 
			& X=Origin, A
		);
		for(.member(Act,A)){
			Act = action(AID,"planned",Name,Agents,Cost);
			-action(AID,"planned",Name,Agents,Cost);
			+action(AID,"todo",Name,Agents,Cost);
		}
	}.	
	
+action(ID,"todo",Name,Agents,Cost) : (actionParams(ID,Params) | not actionParams(ID,Params)) <-
	if(.ground(Params)){
		.send(robot_decision, tell, actionParams(ID,Params));
	};
	.send(robot_decision, tell, action(ID,Name,Agents,Cost)).

	
	