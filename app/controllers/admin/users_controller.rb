class Admin::UsersController < ApplicationController
  before_filter :require_admin

  # GET /admin/users
  # GET /admin/users.xml
  def index
    @users = User.paginate(:conditions => ['admin  = ?', true],
                          :page => params[:page],
                          :per_page => 10,
                          :order => user_sort_order(params)
                          )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.fbml
    end
  end

  protected

    def user_sort_order(params)
      sort = User.column_names.include?(params[:sort]) ? params[:sort] : 'users.id'
      dir = (params[:dir] && params[:dir].downcase == 'desc') ? 'desc' : 'asc'
      "#{sort} #{dir}"
    end
end
