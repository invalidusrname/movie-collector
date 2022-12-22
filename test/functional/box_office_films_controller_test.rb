# frozen_string_literal: true

require "test_helper"

class BoxOfficeFilmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get box_office_path

    assert_response :success
    assert_not_nil assigns(:films)
    assert_not_nil assigns(:this_weeks_films)
  end
end
