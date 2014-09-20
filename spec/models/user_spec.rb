require 'spec_helper'

describe User do 

	before do
		@user = User.new(name: "test", email: "test@example.com", password: "foobar", password_confirmation: "foobar")
		
	end

	subject {@user}

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:remember_token)}

	it {should respond_to(:admin)}

	it {should respond_to(:authenticate)}

	it {should be_valid}

	# describe "admin should be false" do
	# 	@user.admin.should be_false
	# end

	describe "remember_token" do
		before {@user.save}
		its(:remember_token) {should_not be_blank}
	end

	describe "when a name is not present" do
		before {@user.name = " "}
		it {should_not be_valid}
	end

	describe "when a name is too long" do
		before {@user.name = "a" * 51}
		it {should_not be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			@user.email = "test"
			expect(@user).not_to be_valid
		end
	end

	describe "when email address is already taken" do
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it {should_not be_valid}
	end

	describe "with a password that's too short" do
    	before { @user.password = @user.password_confirmation = "a" * 5 }
   		it { should be_invalid }
  	end

	describe "return value of authenticate method" do
		before {@user.save}

		let(:found_user) {User.find_by(email: @user.email)}
		describe "with a valid password" do
			it {should eq found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
    		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    		it { should_not eq user_for_invalid_password }
   			specify { expect(user_for_invalid_password).to be_false }
 		end
	end
end