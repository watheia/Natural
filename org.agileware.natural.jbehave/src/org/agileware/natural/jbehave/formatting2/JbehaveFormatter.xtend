/*
 * generated by Xtext
 */
package org.agileware.natural.jbehave.formatting2

import com.google.inject.Inject
import org.agileware.natural.jbehave.jbehave.Story
import org.agileware.natural.jbehave.services.JbehaveGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument

class JbehaveFormatter extends AbstractFormatter2 {

	@Inject extension JbehaveGrammarAccess

	def dispatch void format(Story story, extension IFormattableDocument document) {
		// TODO...
		println(document)
	}
}