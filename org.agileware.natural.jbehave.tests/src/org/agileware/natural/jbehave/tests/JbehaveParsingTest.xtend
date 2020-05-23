/*
 * generated by Xtext
 */
package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.jbehave.jbehave.StepStartingWord.*
import static org.agileware.natural.jbehave.tests.JbehaveTestHelpers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(JbehaveInjectorProvider)
class JbehaveParsingTest {
	
	@Inject JbehaveTestHelpers _th
	
	@Test
	def void narrativeTypeA() {
		val model = _th.parse('''
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeTypeA", model)

		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		))
	}
	
	@Test
	def void narrativeTypeB() {
		val model = _th.parse('''
			Narrative:
			As a store owner
			I want to add a new pet
			So that the pet gets sold
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeTypeB", model)
		
		// Check narrative
		assertThat(model, hasNarrative(
			asA("store owner"),
			iWantTo("add a new pet"),
			soThat("the pet gets sold")
		))
	}
	
	@Test
	def void narrativeWithDescriptionAndMeta() {
		val model = _th.parse('''
			The quick brown fox
			Jumps over the lazy dog
			
			Meta:
			@author: Mauro
			@themes UI Usability
			
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeWithDescriptionAndMeta", model)
		
		// Check description
		assertThat(model.description, notNullValue())
		assertThat(model.description.lines, hasSize(2))
		
		// Check meta
		assertThat(model.meta, notNullValue())
		assertThat(model.meta.elements, hasItems(
			allOf(hasProperty("key", equalTo("author")), 
					hasProperty("value", equalTo("Mauro"))),
			allOf(hasProperty("key", equalTo("themes")), 
					hasProperty("value", equalTo("UI Usability")))
		))

		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		))
	}
	
	@Test
	def void simpleScenarios() {
		val model = _th.parse('''
			Narrative:
			In order to communicate effectively to the business some functionality
			As a development team
			I want to use Behaviour-Driven Development
			
			Scenario: A scenario is a collection of executable steps of different type
			
			Given step represents a precondition to an event
			When step represents the occurrence of the event
			Then step represents the outcome of the event
			
			Scenario: Another scenario exploring different combination of events
			 
			Given a [precondition]
			When a negative event occurs
			Then the outcome should <be-captured>
			 
			Examples: 
			|precondition|be-captured|
			|abc|be captured    |
			|xyz|not be captured|
		''')
		
		assertThat(model, notNullValue())
		_th.trace("simpleScenarios", model)
		
		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("communicate effectively to the business some functionality"),
			asA("development team"),
			iWantTo("use Behaviour-Driven Development")
		))
		
		// Check Scenarios
		////
		
		assertThat(model.scenarios, hasSize(2))
		
		val s1 = model.scenarios.get(0)
		assertThat(s1.title, equalTo("A scenario is a collection of executable steps of different type"))
		assertThat(s1.steps, hasItems(
				withStep(GIVEN, "step represents a precondition to an event"),
				withStep(WHEN, "step represents the occurrence of the event"),
				withStep(THEN, "step represents the outcome of the event")
		))
		
		val s2 = model.scenarios.get(1)
		assertThat(s2.title, equalTo("Another scenario exploring different combination of events"))
		assertThat(s2.steps, hasItems(
				withStep(GIVEN, "a [precondition]"),
				withStep(WHEN, "a negative event occurs"),
				withStep(THEN, "the outcome should <be-captured>")
		))
		assertThat(s2.examples, notNullValue())
		assertThat(s2.examples.table, notNullValue())
		assertThat(s2.examples.table.header, not(emptyString()))
		assertThat(s2.examples.table.rows, hasSize(2))
	}
	
	@Test
	def void singleScenario() {
		val model = _th.parse('''
			The quick brown fox
			Jumps over the lazy dog
			
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet
			
			Given step represents a precondition to an event
			When step represents the occurrence of the event
			Then step represents the outcome of the event
		''')
		
		assertThat(model, notNullValue())
		_th.trace("simpleScenarios", model)
		
		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		))
		
		// Check Scenario
		assertThat(model.scenarios, hasSize(1))
		val s1 = model.scenarios.get(0)
		assertThat(s1.steps, hasItems(
				withStep(GIVEN, "step represents a precondition to an event"),
				withStep(WHEN, "step represents the occurrence of the event"),
				withStep(THEN, "step represents the outcome of the event")
		))
	}
	
	@Test
	def void scenarioWithLifecycle() {
		val model = _th.parse('''
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet
			
			Lifecycle: 
			Before:
			Scope: STORY
			Given a step that is executed before each story
			And another step that is executed before each story
			Scope: SCENARIO
			Given a step that is executed before each scenario
			After:
			Scope: STEP
			Given a step that is executed after each scenario step
			And another step that is executed after each scenario step
			Scope: STORY
			Outcome: ANY
			Given a step that is executed after each story regardless of outcome
			
			Scenario: A scenario is a collection of executable steps of different type
			When step represents the occurrence of the event
			Then step represents the outcome of the event
		''')
		
		assertThat(model, notNullValue())
		_th.trace("scenarioWithLifecycle", model)
		
		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		))
		
		// Check Lifecycle
		assertThat(model.lifecycle, notNullValue())
		assertThat(model.lifecycle.before, notNullValue())		
		assertThat(model.lifecycle.before.elements, hasSize(2))
		assertThat(model.lifecycle.after, notNullValue())
		assertThat(model.lifecycle.after.elements, hasSize(2))
		
		// Check Scenarios
		////
		
		assertThat(model.scenarios, hasSize(1))
		val s1 = model.scenarios.get(0)
		assertThat(s1.title, equalTo("A scenario is a collection of executable steps of different type"))
		assertThat(s1.steps, hasItems(
				withStep(WHEN, "step represents the occurrence of the event"),
				withStep(THEN, "step represents the outcome of the event")
		))
	}
	
	@Test
	def void givenStories() {
		val model = _th.parse('''
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet
			
			Scenario: With a title
			
			GivenStories: /path/to/precondition1.story,
			              /path/to/precondition2.story
			              
			When step represents the occurrence of the event
			Then step represents the outcome of the event
		''')
		
		assertThat(model, notNullValue())
		_th.trace("givenStories", model)
		
		// Check narrative
		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		))
		
		// Check Scenarios
		////
		
		assertThat(model.scenarios, hasSize(1))
		val s1 = model.scenarios.get(0)
		assertThat(s1.title, equalTo("With a title"))
		assertThat(s1.steps, hasItems(
				withStep(WHEN, "step represents the occurrence of the event"),
				withStep(THEN, "step represents the outcome of the event")
		))
		
		// Check given stories
		assertThat(s1.given, notNullValue())
		assertThat(s1.given.resources, hasSize(2))
	}
	
	@Test
	def void allSupportedSyntax() {
		val model = _th.parse(EXAMPLE_STORY)
		
		assertThat(model, notNullValue())
		_th.trace("allSupportedSyntax", model)
		
		assertThat(model.eResource.errors, empty())
	}
}
