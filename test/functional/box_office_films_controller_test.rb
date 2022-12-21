# frozen_string_literal: true

require 'test_helper'

class BoxOfficeFilmsControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:films)
    assert_not_nil assigns(:this_weeks_films)
  end
end
