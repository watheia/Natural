/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.ui.labeling;

import org.agileware.natural.cucumber.cucumber.Background;
import org.agileware.natural.cucumber.cucumber.Example;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Scenario;
import org.agileware.natural.cucumber.cucumber.ScenarioOutline;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.lang.model.DocString;
import org.agileware.natural.lang.model.Meta;
import org.agileware.natural.lang.model.MetaElement;
import org.agileware.natural.lang.model.Table;
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider;
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider;

import com.google.inject.Inject;

/**
 * Provides labels for a EObjects.
 *
 * see
 * http://www.eclipse.org/Xtext/documentation/latest/xtext.html#labelProvider
 */
public class CucumberLabelProvider extends DefaultEObjectLabelProvider {

	@Inject
	public CucumberLabelProvider(final AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	String text(final Feature ele) {
		return ele.getTitle() == null ? "Feature" : merge("Feature: ", ele.getTitle());
	}

	String image(final Feature ele) {
		return "feature.png";
	}

	String text(final Background ele) {
		return ele.getTitle() == null ? "Background" : merge("Background: ", ele.getTitle());
	}

	String image(final Background ele) {
		return "background.gif";
	}

	String text(final Scenario ele) {
		return ele.getTitle() == null ? "Scenario" : merge("Scenario: ", ele.getTitle());
	}

	String image(final Scenario ele) {
		return "scenario.png";
	}

	String text(final ScenarioOutline ele) {
		return ele.getTitle() == null ? "Scenario Outline" : merge("Scenario Outline: ", ele.getTitle());
	}

	String image(final ScenarioOutline ele) {
		return "scenario_outline.png";
	}

	String text(final Step ele) {
		return ele.getDescription();
	}

	String image(final Step ele) {
		return "step.gif";
	}

	String text(final Table ele) {
		return "Table of " + ele.getRows().size() + " rows";
	}

	String image(final Table ele) {
		return "table.gif";
	}

	String text(final DocString ele) {
		return "DocString";
	}

	String image(final DocString ele) {
		return "code.gif";
	}

	String text(final Example ele) {
		return ele.getTitle() == null ? "Examples" : merge("Examples: ", ele.getTitle());
	}

	String image(final Example ele) {
		return "example.gif";
	}

	String text(final Meta ele) {
		return "Meta";
	}

	String text(final MetaElement ele) {
		return ele.getId().substring(1);
	}

	String image(final MetaElement ele) {
		return "annotation.gif";
	}

	private static String merge(final String... strings) {
		final StringBuilder builder = new StringBuilder();
		for (final String string : strings) {
			builder.append(string);
		}
		return builder.toString();
	}
}
