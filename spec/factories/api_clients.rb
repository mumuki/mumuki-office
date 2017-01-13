FactoryGirl.define do
  factory :api_client do |t|
    transient do
      role :janitor
      grant "test/*"
    end

    description "foo"
    user { create :user, first_name: 'foo', last_name: 'bar', email: 'foo+1@bar.com', permissions: Hash[role, grant] }
  end
end
