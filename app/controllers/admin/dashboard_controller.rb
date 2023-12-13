class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
  end

  private
    def require_admin
      render file: "#{Rails.root}/public/404.html" unless current_admin?
    end
end