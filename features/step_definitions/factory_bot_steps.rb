# frozen_string_literal: true

FactoryBot.factories.each_key do |name|
  Given(/^an? #{name} exists with an? (.*) of "([^"]*)"$/) do |attr, value|
    Factory(name, attr.gsub(" ", "_") => value)
  end
end
