require 'spec_helper'

describe "AuthenticationPages" do
 
 	subject {page}

 	describe "sign in page" do

 		before {visit signin_path}
 		it {should have_content('Username')}
 		it {should have_title('Sign In')}

 		describe "improper login" do
 			before {click_button "Sign In"}
 			
 			it {should have_title('Sign In')}			
 			it {should have_selector('div.alert.alert.-error')}
 			describe "after hitting another link" do
 				before {click_link "Home"}
 				it {should_not have_selector('div.alert.alert.-error')}
 			end

 		end

 		describe "with valid information" do
 			let(:user) {FactoryGirl.create(:user)}
 			before do
 				fill_in "Username", with: user.name
 				fill_in "Password", with: user.password 
 				click_button "Sign In"
 			end
 			it {should have_title('Home')}
 			it {should have_link('Profile', href: user_path(user))}
 			it {should have_link('Sign Out', href: signout_path)}
 			it {should_not have_link('Sign In/Out', href: signin_path)}

 			describe "followed by a sign out" do
 				before {click_link 'Sign Out'}
 				it {should have_link 'Sign In/Up'}
 			end
 		end


 	end


 
end
