class ApiClientsController < ApplicationController
  before_action :parse_permissions, only: :create
  before_action :authorize_janitor!, only: [:new, :create]

  def new
    @api_client = ApiClient.new
    @user = @api_client.build_user
  end

  def create
    ApiClient.create! api_client_params
    redirect_to :root
  end

  private

  def api_client_params
    params.require(:api_client).permit(:description, user_attributes: [:first_name, :last_name, :email, permissions: Mumukit::Auth::Roles::ROLES])
  end

  def parse_permissions
    User.parse! params[:api_client][:user_attributes]
  end
end
