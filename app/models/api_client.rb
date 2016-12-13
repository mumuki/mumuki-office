class ApiClient < ApplicationRecord

  include WithPermissions

  validates_presence_of :name
  before_create :set_token

  private

  def set_token
    self.token = Mumukit::Auth::Token.encode permissions
  end

end
