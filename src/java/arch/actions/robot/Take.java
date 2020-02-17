package arch.actions.robot;

import java.util.ArrayList;
import java.util.Arrays;

import jason.asSemantics.ActionExec;
import rjs.arch.actions.AbstractAction;
import rjs.arch.agarch.AbstractROSAgArch;
import rjs.utils.Tools;

public class Take extends AbstractAction {


	public Take(ActionExec actionExec, AbstractROSAgArch rosAgArch) {
		super(actionExec, rosAgArch);
		setSync(true);
	}

	@Override
	public void execute() {
		logger.info("BOOUUUUH");
		Tools.sleep(3000);
		rosAgArch.addBelief("action", new ArrayList<Object>(Arrays.asList("ongoing",actionExec.getActionTerm().getTerm(0).toString())));
		actionExec.setResult(true);
	}

}
