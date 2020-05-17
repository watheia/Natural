/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.formatting2

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.DocString
import org.agileware.natural.cucumber.cucumber.Example
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Narrative
import org.agileware.natural.cucumber.cucumber.NarrativeLine
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.cucumber.Table
import org.agileware.natural.cucumber.cucumber.TableCol
import org.agileware.natural.cucumber.cucumber.TableRow
import org.agileware.natural.cucumber.cucumber.Tag
import org.agileware.natural.cucumber.services.CucumberGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.*

class CucumberFormatter extends AbstractFormatter2 {
	
	@Inject extension CucumberGrammarAccess

	def dispatch void format(Feature model, extension IFormattableDocument document) {
		println(textRegionAccess)
		
		model.prepend[setNewLines(0)]
		
		// format top-level tags
		for (t : model.tags) t.format()
		
		// Adjust spacing around Feature: keyword
		model.regionFor.keyword(featureAccess.featureKeyword_1)
				.prepend[noSpace]
				.append[oneSpace]
		
		// Trim whitespace around title
		model.regionFor.feature(FEATURE__TITLE)
				.append[noSpace]

		// format narrative
		model.narrative.format()

		// format background
		model.background.format()

		// format scenarios
		for (s : model.scenarios) s.format()
		
	 	println(document)
	}

	def dispatch void format(Tag model, extension IFormattableDocument document) {
		model.append[newLine]
	}

	def dispatch void format(Narrative model, extension IFormattableDocument document) {
 		// Format lines
		 for (l : model.lines) l.format()
	}

	def dispatch void format(NarrativeLine model, extension IFormattableDocument document) {
		model.regionFor.feature(NARRATIVE_LINE__VALUE)
				.append[noSpace]
	}

	def dispatch void format(Background model, extension IFormattableDocument document) {
		
		// Append blank line above region
		model.prepend[setNewLines(2)]
		
		// Adjust spacing around keyword
		model.regionFor.keyword(backgroundAccess.backgroundKeyword_1)
				.append[oneSpace]
		
		// Trim whitespace around title
		model.regionFor.feature(BACKGROUND__TITLE)
				.append[noSpace]
		
		// format steps
		for (s : model.steps) s.format()
	}

	def dispatch void format(Scenario model, extension IFormattableDocument document) {

		// Append blank line above region
		model.prepend[setNewLines(2)]
		
		// format tags
		for (t : model.tags) t.format()
		
		// Adjust spacing around keyword
		model.regionFor.keyword(scenarioAccess.scenarioKeyword_2)
				.append[oneSpace]
		
		// Trim whitespace around title
		model.regionFor.feature(ABSTRACT_SCENARIO__TITLE)
				.append[noSpace]
		

		// format narrative
		model.narrative.format()

		// format steps
		for (s : model.steps) s.format()
	}

	def dispatch void format(ScenarioOutline model, extension IFormattableDocument document) {
		
		// Append blank line above region
		model.prepend[setNewLines(2)]
		
		// format tags
		for (t : model.tags) t.format()

		// Adjust spacing around keyword
		model.regionFor.keyword(scenarioOutlineAccess.scenarioKeyword_2)
				.append[oneSpace]
		
		// Trim whitespace around title
		model.regionFor.feature(ABSTRACT_SCENARIO__TITLE)
				.append[noSpace]
				
		// format narrative
		model.narrative.format()

		// format steps
		for (s : model.steps) s.format()

		// format examples
		for (e : model.examples) e.format()
	}
	
	def dispatch void format(Example model, extension IFormattableDocument document) {
		
		// Append blank line above region
		model.prepend[setNewLines(2)]
		
		// format tags
		for (t : model.tags) t.format()

		// format narrative
		model.narrative.format()

		// format table
		model.table.format()
	}

	def dispatch void format(Step model, extension IFormattableDocument document) {
		
		// Adjust spacing around keyword
		model.regionFor.feature(STEP__KEYWORD)
				.append[oneSpace]
				
		// Trim whitespace around description, including any additional NL
		model.regionFor.feature(STEP__DESCRIPTION)
				.append[noSpace]
				
		// format table | text
		if(model.table !== null) model.table.format()
		if(model.text !== null) model.text.format()
	}

	def dispatch void format(Table model, extension IFormattableDocument document) {
		// format rows
		for (r : model.rows) r.format()
	}

	def dispatch void format(TableRow model, extension IFormattableDocument document) {
		
		// Trim whitespace at before/after collumns 
		model.surround[noSpace]
		
		// format cols
		for (c : model.cols) c.format()
	}

	def dispatch void format(TableCol model, extension IFormattableDocument document) {
		// Add a space after each column separator
		model.regionFor.keyword("|").append[oneSpace]
	}

	def dispatch void format(DocString model, extension IFormattableDocument document) {
		// TODO...
	}

}
