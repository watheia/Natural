/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.formatting;

import org.agileware.natural.cucumber.services.CucumberGrammarAccess;
import org.eclipse.xtext.formatting.impl.AbstractDeclarativeFormatter;
import org.eclipse.xtext.formatting.impl.FormattingConfig;

/**
 * This class contains custom formatting description.
 * 
 * see : http://www.eclipse.org/Xtext/documentation/latest/xtext.html#formatting
 * on how and when to use it
 * 
 * Also see {@link org.eclipse.xtext.xtext.XtextFormattingTokenSerializer} as an
 * example
 */
public class CucumberFormatter extends AbstractDeclarativeFormatter {

	@Override
	protected void configureFormatting(FormattingConfig c) {
		CucumberGrammarAccess g = (CucumberGrammarAccess) super.getGrammarAccess();

		c.setNoSpace().after(g.getSTEP_KEYWORDRule());

		c.setIndentationIncrement().before(g.getNarrativeRule());
		c.setIndentationDecrement().after(g.getNarrativeRule());
		c.setIndentationIncrement().before(g.getStepRule());
		c.setIndentationDecrement().after(g.getStepRule());
		c.setIndentationIncrement().before(g.getExampleRule());
		c.setIndentationDecrement().after(g.getExampleRule());
		c.setIndentationIncrement().before(g.getTableRule());
		c.setIndentationDecrement().after(g.getTableRule());
		c.setIndentationIncrement().before(g.getDocStringRule());
		c.setIndentationDecrement().after(g.getDocStringRule());

		c.setNoLinewrap().around(g.getStepDescriptionRule());
	}
}