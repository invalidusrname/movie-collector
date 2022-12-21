# frozen_string_literal: true

require "test_helper"

class UsersMovieTest < ActiveSupport::TestCase
  test "use existing movie when given a UPC" do
    movie = Movie.create(title: "Blankman", upc: "123", format: "DVD")
    um = UsersMovie.new(movie_attributes: { upc: "123" })

    assert um.save, um.errors.full_messages * "\n"
    assert_equal "Blankman", um.movie.title
    assert_equal movie, um.movie, "users_movie.movie should an existing movie"
  end

  test "new movie is created when given a non-existent UPC" do
    movie = Movie.find_by(title: "Blankman")

    assert_nil movie

    movie_attributes = {
      title: "Blankman",
      upc: "123",
      format: "DVD"
    }

    Movie.expects(:lookup_on_amazon).at_least_once.returns({})

    um = UsersMovie.new(movie_attributes:)

    assert um.save, um.errors.full_messages * "\n"

    movie = Movie.find_by(title: "Blankman")
    assert_not_nil movie
    assert_equal movie, um.movie, "Movie should be a new one"
  end

  test "amazon is used to create a movie we can't find one in the db" do
    movie = Movie.find_by(title: "Blankman")

    assert_nil movie

    movie_attributes = {
      title: "Blankman",
      upc: "1234",
      format: "DVD"
    }

    amazon_attributes = {
      title: "Blankman [Extended Edition]",
      upc: "1234",
      format: "DVD",
      asin: "99999"
    }

    Movie.expects(:lookup_on_amazon).at_least_once.returns(amazon_attributes)

    um = UsersMovie.new(movie_attributes:)

    assert um.save, um.errors.full_messages * "\n"

    movie = Movie.find_by(title: "Blankman [Extended Edition]")
    assert_not_nil movie
    assert_equal "99999", movie.asin, "ASIN should be saved from amazon"
    assert_equal movie, um.movie, "Movie should be a new one"
  end
end
