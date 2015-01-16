require 'spec_helper'

describe "UserPages" do
  
  subject {page}

  describe "index" do
    let (:admin) {FactoryGirl.create(:admin)}
    before do
    
      sign_in admin
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end
    it {should have_title('All Users')}
    it {should have_content('All Users')}

    describe "delete links" do
      describe "as an admin user" do
        it { should have_link('delete') }
        it "should be able to delete another user" do
        expect do
          click_link('delete', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('delete', href: user_path(admin)) }
    end
  
  end

    describe "pagination" do
      before(:all) {30.times {FactoryGirl.create(:user)}}
      after(:all) {User.delete_all}

      it {should have_selector('div.pagination')}

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

  describe "signup page" do
  	before {visit signup_path}

  	it {should have_content('Sign up')}
  	it {should have_title(full_title('Sign up'))}

  	describe "with valid info" do
  		before do
	  		fill_in "Username", with: "Test User"
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
		  	fill_in "Username", with: "Test User"
		  	fill_in "Email", with: "testcom"
		  	fill_in "Password", with: "password"
		  	fill_in "Confirmation", with: "password"
		  end
		  	it "should create a user" do
	  			expect {click_button "Submit"}.not_to change(User, :count)
	  		end
  	end
  


  end

  describe "edit page" do
    let (:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit User") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Submit" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) {"New Name"}
      let(:new_email) {"new@example.com"}

      before do
        fill_in "Username", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Submit"
      end

      it {should have_title(new_name)}
      it {should have_selector('div.alert.alert.-success')}
      it {should have_link('Sign Out', href: signout_path)}
      specify{expect(user.reload.name).to eq new_name}
      specify{expect(user.reload.email).to eq new_email}
    end

  end

  describe "profile page" do
  	let (:user) {FactoryGirl.create(:user)}
  	before{visit user_path(user)}

  	it {should have_content(user.name)}
  	it {should have_title(user.name)}

  end
end
