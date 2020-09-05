/*
 * generated by Xtext 2.23.0-SNAPSHOT
 */
package org.agileware.natural.lang.formatting2

import com.google.inject.Inject
import org.agileware.natural.lang.model.Block
import org.agileware.natural.lang.model.DocString
import org.agileware.natural.lang.model.Document
import org.agileware.natural.lang.model.Meta
import org.agileware.natural.lang.model.MetaElement
import org.agileware.natural.lang.model.Narrative
import org.agileware.natural.lang.model.NaturalModel
import org.agileware.natural.lang.model.Paragraph
import org.agileware.natural.lang.model.Section
import org.agileware.natural.lang.model.Table
import org.agileware.natural.lang.services.NaturalGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.FormatterRequest
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.eclipse.xtext.formatting2.regionaccess.ISemanticRegion

class NaturalFormatter extends AbstractFormatter2 {

	@Inject extension NaturalGrammarAccess naturalGrammarAccess

	@Inject NaturalFormatHelper.Factory formatHelperFactory

	var extension NaturalFormatHelper _formatHelper = null

	override protected initialize(FormatterRequest request) {
		_formatHelper = formatHelperFactory.create(request.textRegionAccess, naturalGrammarAccess)
		_formatHelper.initialize(request)

		super.initialize(request)
	}

	def dispatch void format(NaturalModel model, extension IFormattableDocument doc) {
		// println(textRegionAccess)
		model.document.format()
		// println(doc)
	}

	def dispatch void format(Document model, extension IFormattableDocument doc) {
		resetIndentation()
		
		// Condense all BLANK_SPACE regions into single line break
		model.allRegionsFor.ruleCallsTo(BLANK_SPACERule).forEach [ region |
			// println('''Trimming BLANK_SPACE: «region.offset» «region.length»''')
			trimBlankSpace(region, 1, doc)
		]

		// Format meta tags
		model.meta.format()

		// Cleanup whitespace around keyword/title
		if (model.title === null) {
			model.regionFor.keyword(documentAccess.documentKeyword_3).append[noSpace]
		} else {
			model.regionFor.assignment(documentAccess.titleAssignment_4).prepend[oneSpace].append[noSpace]
		}

		increaseIndent()
		indentBlock(model.startIndent, model.endIndent, doc)

		// Format narrative
		if (model.narrative !== null) {
			model.narrative.format().prepend[indent]
			if (!model.narrative.hasLeadingBlankSpace) {
				model.narrative.prepend[setNewLines(2)]
			}
		}

		// Format sections
		model.sections.forEach[format().prepend[indent]]

		decreaseIndent()
	}

	def dispatch void format(Section model, extension IFormattableDocument doc) {

		// Set block spacing
		if (!model.hasLeadingBlankSpace) {
			model.prepend[setNewLines(2)]
		}

		// Format meta tags
		if (model.meta !== null) {
			model.meta.format()

			// Work-around for strange keyword placement when tags are present
			model.regionFor.keyword(sectionAccess.sectionKeyword_2).prepend[indent]
		}

		// Cleanup whitespace around keyword/title
		if (model.title === null) {
			model.regionFor.keyword(sectionAccess.sectionKeyword_2).append[noSpace]
		} else {
			model.regionFor.assignment(sectionAccess.titleAssignment_3).prepend[oneSpace].append[noSpace]
		}

		increaseIndent()
		indentBlock(model.startIndent, model.endIndent, doc)

		// Format narrative
		if (model.narrative !== null) {
			model.narrative.format().prepend[indent]
		// TODO (opinionated) should we increase spacing here? 
		// if(!model.narrative.hasLeadingBlankSpace) {
		// model.narrative.prepend[setNewLines(2)]
		// }
		}

		decreaseIndent()
	}

	def dispatch void format(Meta model, extension IFormattableDocument doc) {
		model.tags.forEach[format]
	}

	def dispatch void format(MetaElement model, extension IFormattableDocument doc) {

		// Trim leading/trailing whitespace
		model.surround[noSpace]

		if (model.value !== null) {
			// Cleanup whitespace around value assignment
			model.regionFor.keyword(':').prepend[noSpace].append[oneSpace]
			model.regionFor.assignment(metaElementAccess.valueAssignment_2_1).prepend[oneSpace].append[noSpace]
		}

		// Insert newline if not present from BLANK_SPACE
		if (model.isLast()) {
			model.append[setNewLines(0)]
		} else if (!model.hasTrailingBlankSpace) {
			model.append[newLine]
		}
	}

	def dispatch void format(Narrative model, extension IFormattableDocument doc) {
		model.sections.forEach[format().prepend[indent]]
	}

	def dispatch void format(Paragraph model, extension IFormattableDocument doc) {
		formatMultilineText(model, paragraphAccess.valueAssignment_1, indentationLevel, doc)
	}

	def dispatch void format(Table model, extension IFormattableDocument doc) {
		model.rows.forEach[prepend[indent]]
	}

	def dispatch void format(DocString model, extension IFormattableDocument doc) {
		formatMultilineText(model, docStringAccess.valueAssignment_1, indentationLevel, doc)
	}

	def ISemanticRegion startIndent(Document model) {
		return model.regionFor.ruleCallTo(NLRule)
	}

	def ISemanticRegion endIndent(Document model) {
		if (!model.sections.isEmpty()) {
			return model.sections.last.endIndent()
		} else if (model.narrative !== null) {
			return model.narrative.endIndent()
		}

		return model.regionFor.ruleCall(documentAccess.BLANK_SPACEParserRuleCall_8)
	}

	def ISemanticRegion startIndent(Section model) {
		return model.regionFor.ruleCallTo(NLRule)
	}

	def ISemanticRegion endIndent(Section model) {
		if (model.narrative !== null) {
			return model.narrative.endIndent()
		}

		return model.regionFor.ruleCallTo(NLRule)
	}

	def ISemanticRegion endIndent(Narrative model) {
		return model.sections.last.endIndent()
	}

	def ISemanticRegion endIndent(Block model) {
		if(model instanceof Table) {
			return model.rows.last.regionFor.ruleCallTo(NLRule)
		}
		
		return model.regionFor.ruleCallTo(NLRule)
	}

	def boolean isLast(Section model) {
		val document = model.eContainer as Document
		model == document.sections.last
	}
}