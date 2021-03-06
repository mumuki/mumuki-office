class ApiClient < ApplicationRecord

  belongs_to :user
  accepts_nested_attributes_for :user
  validates_presence_of :description

  #TODO add JWT expiration and api client invalidation
  #TODO rename toke to encoded_token
  before_create :set_encoded_token!

  def verify!
    raise 'Invalid Api Client' if Mumukit::Auth::Token.decode(token).uid != user.uid
  end

  def self.verify_token!(token)
    client = find_by token: token
    raise 'No Api Client found for Token' unless client
    client.verify!
  end

  private

  def set_encoded_token!
    self.token = Mumukit::Auth::Token.encode user.uid, {}
  end

end
