require 'spec_helper'

describe "UserPages" do
  
  subject {page}

  describe "signup page" do
  	before {visit signup_path}

  	it {should have_content('Sign up')}
  	it {should have_title(full_title('Sign up'))}

  	describe "with valid info" do
  		before do
	  		fill_in "Name", with: "Test User"
		  	fill_in "Email", with: "test@email.com"
		  	fill_in "Password", with: "password"
		  	fill_in "Confirmation", with: "password"
		  end
		it "should create a user" do
	  		expect {click_button "Submit"}.to change(User, :count).by(1)
	 	end
      describe "after saving the user" do
        before {click_button "Submit"}
        let(:user) {User.find_by(name: 'Test User')}

        it {should have_link('Sign Out')}
        it{should have_title(user.name)}
        it {should have_selector('div.alert.alert.-success', text: 'Welcome')}
      end
  	end

  	describe "with invalid info" do
  		before do
		  	fill_in "Name", with: "Test User"
		  	fill_in "Email", with: "testcom"
		  	fill_in "Password", with: "password"
		  	fill_in "Confirmation", with: "password"
		  end
		  	it "should create a user" do
	  			expect {click_button "Submit"}.not_to change(User, :count)
	  		end
  	end
  


  end

  describe "profile page" do
  	let (:user) {FactoryGirl.create(:user)}
  	before{visit user_path(user)}

  	it {should have_content(user.name)}
  	it {should have_title(user.name)}

  end





end
