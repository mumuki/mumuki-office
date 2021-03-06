class OrganizationsController < ApplicationController
  helper_method :login_methods

  include OrganizationsControllerTemplate
  before_action :authorize_owner!

  def index
    @organizations = Organization.by_full_text(params[:q]).accessible_as(current_user, :janitor)
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    with_flash @organization, I18n.t(:organization_saved_successfully) do
      @organization.save_and_notify!
    end
  end

  def update
    with_flash @organization, I18n.t(:organization_saved_successfully) do
      @organization.update_and_notify! organization_params
    end
  end

  private

  def login_methods
    Mumukit::Login::Settings.login_methods
  end
end
