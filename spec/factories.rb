FactoryGirl.define do
  factory :user do
    name     "Thomas"
    email    "Thomas@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end