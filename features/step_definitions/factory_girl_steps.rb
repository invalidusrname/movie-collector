# frozen_string_literal: true

FactoryBot.factories.each do |name, _factory|
  Given(/^an? #{name} exists with an? (.*) of "([^"]*)"$/) do |attr, value|
    Factory(name, attr.gsub(" ", "_") => value)
  end
end
