
+!tellToPack(Params): true <-
	.nth(2, Params,Area);
	!getUnRef(Area);
	?verba(Area,Verba);
	!sayPack(Verba).
	
+!tellToTake(Params): true <-
	.nth(1, Params,Object);
	!getUnRef(Object);
	?verba(Object,Verba);
	!sayTake(Verba).
	
+!getUnRef(Object): true <-
	disambiguate(Object,robot);
	?sparql_result(Object,S);
	sparql_verbalization(S).
	
+!sayPack(Area) : true <-
	.concat("Can you put it in ", Area, " ?", Vc);
	say(Vc).
	
+!sayTake(Verba) : .length(Verba,X) & X > 0 <-
	.concat("Can you take ", Verba, " ?", Vc);
	say(Vc).

+!sayTake(Verba) : true <-
	say("I could not find any disambiguation for this object").
	
+!pointObject(Params): true <-
	.nth(1, Params,Object);
	say("can you take this cube ?");
	pointObject(Object).


	