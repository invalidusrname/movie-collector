# ripped from https://gist.github.com/tooky/5933773
# caused by https://github.com/minitest/minitest/issues/286

require "minitest"

module Cucumber
  module MiniTestAssertions
    def self.extended(base)
      base.extend(MiniTest::Assertions)
      base.assertions = 0
    end

    attr_accessor :assertions
  end
end

World(Cucumber::MiniTestAssertions)
