/*
 * generated by Xtext 2.22.0
 */
package org.agileware.natural.jbehave.formatting2

import com.google.inject.Inject
import org.agileware.natural.jbehave.jbehave.Examples
import org.agileware.natural.jbehave.jbehave.JbehaveModel
import org.agileware.natural.jbehave.jbehave.Lifecycle
import org.agileware.natural.jbehave.jbehave.LifecycleAfter
import org.agileware.natural.jbehave.jbehave.LifecycleAfterElement
import org.agileware.natural.jbehave.jbehave.LifecycleBefore
import org.agileware.natural.jbehave.jbehave.LifecycleBeforeElement
import org.agileware.natural.jbehave.jbehave.Meta
import org.agileware.natural.jbehave.jbehave.Scenario
import org.agileware.natural.jbehave.jbehave.Step
import org.agileware.natural.jbehave.jbehave.Story
import org.agileware.natural.jbehave.jbehave.StoryNarrativeA
import org.agileware.natural.jbehave.jbehave.StoryNarrativeB
import org.agileware.natural.jbehave.jbehave.StoryNarrativeElement
import org.agileware.natural.jbehave.services.JbehaveGrammarAccess
import org.agileware.natural.lang.formatting2.NaturalFormatHelper
import org.agileware.natural.lang.model.DocString
import org.agileware.natural.lang.model.MetaElement
import org.agileware.natural.lang.model.Table
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.FormatterRequest
import org.eclipse.xtext.formatting2.IFormattableDocument

class JbehaveFormatter extends AbstractFormatter2 {

	@Inject extension JbehaveGrammarAccess jbehaveGrammerAccess

	@Inject NaturalFormatHelper.Factory formatHelperFactory

	// TODO there must be a better way to get the current indentation level!
	var int indentationLevel = -1

	var extension NaturalFormatHelper _formatHelper = null

	override protected initialize(FormatterRequest request) {
		_formatHelper = formatHelperFactory.create(request.textRegionAccess, naturalGrammarAccess)
		_formatHelper.initialize(request)

		super.initialize(request)
	}

	def dispatch void format(JbehaveModel model, extension IFormattableDocument doc) {
		// println(textRegionAccess)
		model.document.format()
	// println(doc)
	}

	def dispatch void format(Story model, extension IFormattableDocument document) {
		model.description.format()
		model.meta.format()
		model.narrative.format()
		model.lifecycle.format()
		model.scenarios.forEach[format]
	}

	def dispatch void format(StoryNarrativeA model, extension IFormattableDocument doc) {
		model.inOrderTo.format()
		model.asA.format()
		model.wantTo.format()
	}

	def dispatch void format(StoryNarrativeB model, extension IFormattableDocument doc) {
		model.asA.format()
		model.wantTo.format()
		model.soThat.format()
	}

	def dispatch void format(StoryNarrativeElement model, extension IFormattableDocument doc) {
		// TODO...
	}

	def dispatch void format(Lifecycle model, extension IFormattableDocument doc) {
		model.before.format()
		model.after.format()
	}

	def dispatch void format(LifecycleBefore model, extension IFormattableDocument doc) {
		model.elements.forEach[format]
	}

	def dispatch void format(LifecycleBeforeElement model, extension IFormattableDocument doc) {
		model.steps.forEach[format]
	}

	def dispatch void format(LifecycleAfter model, extension IFormattableDocument doc) {
		model.elements.forEach[format]
	}

	def dispatch void format(LifecycleAfterElement model, extension IFormattableDocument doc) {
		model.steps.forEach[format]
	}

	def dispatch void format(Scenario model, extension IFormattableDocument doc) {
		model.meta.format()
		// model.given.format()
		model.steps.forEach[format]
		model.examples.format()
	}

//	def dispatch void format(GivenStories model, extension IFormattableDocument doc) {
//		model.resources.forEach[format]
//	}

//	def dispatch void format(StoryPath model, extension IFormattableDocument doc) {
//		// TODO...
//	}
	
	def dispatch void format(Step model, extension IFormattableDocument doc) {
		// TODO...
	}

	def dispatch void format(Examples model, extension IFormattableDocument doc) {
		model.table.format()
	}




	def dispatch void format(Meta model, extension IFormattableDocument doc) {
		model.tags.forEach[format]
	}

	def dispatch void format(MetaElement model, extension IFormattableDocument doc) {
		// Trim leading/trailing whitespace
		model.surround[noSpace]

//		if (model.value !== null) {
//			// Cleanup whitespace around value assignment
//			model.regionFor.keyword(':').prepend[noSpace].append[oneSpace]
//			model.regionFor.assignment(metaElementAccess.valueAssignment_2_1).prepend[oneSpace].append[noSpace]
//		}

		// Insert newline if not present from BLANK_SPACE
		if (model.isLast()) {
			model.append[setNewLines(0)]
		} else if (!model.hasTrailingBlankSpace) {
			model.append[newLine]
		}
	}

	def dispatch void format(Table model, extension IFormattableDocument doc) {
		model.rows.forEach[prepend[indent]]
	}

	def dispatch void format(DocString model, extension IFormattableDocument doc) {
		formatMultilineText(model, docStringAccess.valueAssignment_1, indentationLevel, doc)
	}

	def dispatch boolean isLast(MetaElement model) {
		val meta = model.eContainer as Meta
		model == meta.tags.last
	}
}
