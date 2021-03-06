/*
* generated by Xtext
*/
package org.agileware.natural.cucumber.ui.contentassist;

import java.util.Collection;

import org.agileware.natural.stepmatcher.ui.AbstractAnnotationDescriptor;
import org.agileware.natural.stepmatcher.ui.JavaAnnotationMatcher;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.RuleCall;
import org.eclipse.xtext.impl.RuleCallImpl;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;

import com.google.inject.Inject;

/**
 * see
 * http://www.eclipse.org/Xtext/documentation/latest/xtext.html#contentAssist on
 * how to customize content assistant
 */
public class CucumberProposalProvider extends AbstractCucumberProposalProvider {

	@Inject
	private JavaAnnotationMatcher matcher;

	@Inject
	private AbstractAnnotationDescriptor descriptor;

	@Override
	public void complete_Step(final EObject model, final RuleCall ruleCall, final ContentAssistContext context,
			final ICompletionProposalAcceptor acceptor) {
		if (((RuleCallImpl) context.getLastCompleteNode().getGrammarElement()).getRule().getName().equals("NL")
				&& context.getPrefix().length() == 0) {
			for (final String entry : descriptor.getNames()) {
				acceptor.accept(createCompletionProposal(entry + " ", context));
			}
		}
	}

	public void complete_StepDescription(final EObject model, final RuleCall ruleCall,
			final ContentAssistContext context, final ICompletionProposalAcceptor acceptor) {
		final Collection<String> proposals = matcher.findProposals();
		for (String proposal : proposals) {
			final String display = proposal;
			if (proposal.charAt(0) == '^') {
				proposal = proposal.substring(1);
			}
			if (proposal.charAt(proposal.length() - 1) == '$') {
				proposal = proposal.substring(0, proposal.length() - 1);
			}
			acceptor.accept(createCompletionProposal(proposal, display, null, context));
		}
	}
}
