/*
 * generated by Xtext
 */
package org.agileware.natural.jbehave.ui.codemining;

import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.codemining.ICodeMining;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.codemining.AbstractXtextCodeMiningProvider;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.util.IAcceptor;

@SuppressWarnings("restriction")
public class JbehaveCodeMiningProvider extends AbstractXtextCodeMiningProvider {
	@Override
	protected void createCodeMinings(IDocument document, XtextResource resource, CancelIndicator indicator,
		IAcceptor<? super ICodeMining> acceptor) throws BadLocationException {
		
		// TODO: implement me
		// use acceptor.accept(super.createNewLineHeaderCodeMining(...)) to add a new code mining to the final list
		
		// example:
		// acceptor.accept(createNewLineHeaderCodeMining(1, document, "Header annotation"));
	}
}