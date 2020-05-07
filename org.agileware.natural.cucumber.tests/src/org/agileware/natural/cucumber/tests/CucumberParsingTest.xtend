/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Feature
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.tests.CucumberMatchers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberParsingTest {

	@Inject
	ParseHelper<Feature> parseHelper

	@Test
	def void helloCucumber() {
		val feature = parseHelper.parse('''
			Feature: Hello, Cucumber!
			  The quick brown fox
			  Jumps over the lazy dog
			  # But only on days that end in 'Y'
			
			Scenario: Jack and Jill
			  Given Jack and Jill went up a hill
			  When Jack fell down
			  Then Jill came tumbling after
		''')

		assertThat(feature, notNullValue())
		assertThat(feature.title, equalTo("Hello, Cucumber!"))
		assertThat(feature.narrative, equalToCompressingWhiteSpace('''
			The quick brown fox
			Jumps over the lazy dog
		'''))

		val scenarios = feature.scenarios
		assertThat(scenarios, hasSize(1))
		assertThat(scenarios, hasItem(withScenario("Jack and Jill")))

		val steps = scenarios.get(0).steps
		assertThat(steps, hasSize(3))
		assertThat(steps, hasItems(
			withStep("Jack and Jill went up a hill"),
			withStep("Jack fell down"),
			withStep("Jill came tumbling after")
		))
	}

	@Test
	def void featureOnly() {
		val feature = parseHelper.parse('''
			Feature: Hello, Cucumber!
		''')

		assertThat(feature, notNullValue())
		assertThat(feature.title, equalTo("Hello, Cucumber!"))
	}

	@Test
	def void allSupportedSyntax() {
		// TODO: this is still missing a lot of odd-ball cases
		val feature = parseHelper.parse('''
			@release:Release-2 
			@version:1.0.0
			@pet_store
			Feature: Add a new pet 
				In order to sell a pet
					As a store owner
					I want to add a new pet to the catalog
				# But only on days that end in 'Y'
			
			@setup
			Background: Add a dog 
				Given I have the following pet
					| name | status    |
					| Fido | available |
				And I add the pet to the store   		 # extra whitespace
			
			@add
			@fido
			Scenario: Add a dog 
				Then the pet should be available in the store 
				
			@update
			@fido
			Scenario: Update a dog 
				Given the pet is available in the store
				When I update the pet with  
					| name | status      |
					| Fido | unavailable |
				Then the pet should be unavailable in the store 
			
			@eat-pickles	
			Scenario Outline: Eating pickles
				Given there are <start> pickles
				When I eat <eat> pickles
				Then I should have <left> pickles
			
				@hungry
				Examples:
					| start | eat | left |
					|    12 |  10 |    2 |
					|    20 |  15 |    5 |
			
				@full
				Examples:
					| start | eat | left |
					|    12 |   2 |   10 |
					|    20 |   5 |   15 |
		''')

		assertThat(feature, notNullValue())
		assertThat(feature.eResource.errors, empty())
	}
}
