Given /^the following movies:$/ do |movies|
  user = User.find(session[:user_id])
  movies.hashes.each do |hash|
    user.movies << Movie.create!(hash)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) movie$/ do |pos|
  visit users_movies_url
  within("table > tbody tr:nth-child(#{pos.to_i})") do
    click_link "Delete"
  end
end

Then /^I should see the following movies:$/ do |movies|
  movies.rows.each_with_index do |row, i|
    response.should have_selector("tbody tr[#{i+1}] > td[2]") { |td|
      td.inner_text.should == row[0]
    }
  end
end
