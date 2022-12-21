# frozen_string_literal: true

require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "valid movie" do
    m = Movie.new(title: "Sample Movie", upc: "1234", format: "Blu-ray")
    assert m.valid?, m.errors.full_messages * "\n"
  end

  test "invalid movie creation" do
    m = Movie.new(title: "", upc: "1234", format: "Blu-Ray")
    assert_not m.valid?
  end

  test "search movies locally" do
    Movie.create(title: "Sample Movie",   upc: "1111", format: "Blu-ray")
    Movie.create(title: "Sample Movie 2", upc: "2222", format: "Blu-ray")
    Movie.create(title: "Another Title",  upc: "3333", format: "Blu-ray")
    Movie.create(title: "Another Sample", upc: "3333", format: "Blu-ray")

    starts_with = Movie.search("Sample", { starts_with: true }, page: nil)
    search      = Movie.search("Sample", {}, page: nil)

    assert_equal 2, starts_with.size, "Searching by starts_with"
    assert_equal 3, search.size, "Searching without starts_with"
  end

  # TODO
  test "search titles on amazon" do
  end

  # TODO
  test "lookup on amazon via UPC" do
  end

  test "skip lookup on amazon via UPC for short codes" do
    result = Movie.lookup_on_amazon("123")
    assert_equal({}, result)
  end
end
