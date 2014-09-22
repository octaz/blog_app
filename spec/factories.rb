FactoryGirl.define do
  # factory :user do
  #   name     "Thomas"
  #   email    "Thomas@example.com"
  #   password "foobar"
  #   password_confirmation "foobar"
  # end

  ##above is not a sequence
  factory :user do
  	sequence(:name) {|n| "Person #{n}"}
  	sequence(:email){|n| "person_#{n}@example.com"}
  	password "foobar"
  	password_confirmation "foobar"
  	factory :admin do
  		admin true
  	end
  end

  factory :post do
    title "title"
    content "content"
    user
  end

  factory :tag do
    title "tag"
  end

  

end