# frozen_string_literal: true

Given(/^the following movies:$/) do |movies|
  movies.hashes.each do |hash|
    Movie.create!(hash)
  end
end

When(/^I delete the (\d+)(?:st|nd|rd|th) movie$/) do |pos|
  visit users_movies_url
  within("table > tbody tr:nth-child(#{pos.to_i})") do
    click_link 'Delete'
  end
end

Then(/^I should see the following movies:$/) do |movies|
  movies.rows.each_with_index do |row, i|
    response.should have_selector("tbody tr[#{i + 1}] > td[2]") { |td|
      td.inner_text.should == row[0]
    }
  end
end

Then(/^I rate "([^"]*)" with a (\d+)$/) do |title, rating|
  movie = Movie.find_by(title:)
  user = User.find(session[:user_id])
  um = user.users_movie.find_by(movie_id: movie.id)
  um.rating = rating
  um.rating
end

Then(/^"([^"]*)" should have a rating of (\d+)$/) do |title, rating|
  movie = Movie.find_by(title:)
  user = User.find(session[:user_id])
  um = user.users_movie.find_by(movie_id: movie.id)
  um.rating.should eql(rating)
end
