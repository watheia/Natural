/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberFormatterTest {

	@Inject CucumberTestHelpers _th

	@Test
	def void simpleFormatting() {
		val toBeFormatted = '''
			@alpha  @beta  
			Feature: The quick brown fox  
				Jumps over  
				The lazy dog
			Scenario: Jack and Jill  
				When Jack falls down  
				Then Jill comes tumbling after  
		'''
		val expectation = '''
			@alpha
			@beta
			Feature: The quick brown fox
				Jumps over
				The lazy dog
			
			Scenario: Jack and Jill
				When Jack falls down
				Then Jill comes tumbling after
		'''
		_th.assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void scenarioIndentation() {
		val toBeFormatted = '''
			Feature: The quick brown fox
			
			Scenario: Jack and Jill
			When Jack falls down
			Then Jill comes tumbling after
		'''
		val expectation = '''
			Feature: The quick brown fox
			
			Scenario: Jack and Jill
				When Jack falls down
				Then Jill comes tumbling after
		'''
		_th.assertFormatted(toBeFormatted, expectation)
	}
}
