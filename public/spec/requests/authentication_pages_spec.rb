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
 			# before do
 			# 	fill_in "Username", with: user.name
 			# 	fill_in "Password", with: user.password 
 			# 	click_button "Sign In"
 			# end

 			before {sign_in user}
 			it {should have_title('Home')}
 			it {should have_link('Profile', href: user_path(user))}
 			it {should have_link('Settings', href: edit_user_path(user))}
 			it {should have_link('Sign Out', href: signout_path)}
 			it {should_not have_link('Sign In/Up', href: signin_path)}

 			describe "followed by a sign out" do
 				before {click_link 'Sign Out'}
 				it {should have_link 'Sign In/Up'}
 			end
 		end


 	end

 	describe "authorization" do

 		 	describe "as non-admin user" do
		      let(:user) { FactoryGirl.create(:user) }
		      let(:non_admin) { FactoryGirl.create(:user) }

		      before { sign_in non_admin, no_capybara: true }

		      describe "submitting a DELETE request to the Users#destroy action" do
		        before { delete user_path(user) }
		        specify { expect(response).to redirect_to(root_url) }
		      end

		      describe  "in the Posts controller" do

		      	describe "submitting to the create action" do
		      		before {post posts_path}
		      		specify { expect(response).to redirect_to(root_url)}
		      	end

		      	describe "submitting to the destroy action" do
		      		before { delete post_path(FactoryGirl.create(:post))}
		      		specify { expect(response).to redirect_to(root_url)}
		      	end
		      end
		    end
		 
 	 	describe "for non-signed in users" do
 	 		let(:user) {FactoryGirl.create(:user)}

 			describe "in the users controller" do

 				describe "Visiting the edit page" do
 					before {visit edit_user_path(user)}
 					it {should have_title('Sign In')}
 				end

 				describe "visiting the user index" do
 					before {visit users_path}
 					it {should have_title('Sign In')}
 				end

 				describe "submitting to the update action" do
 					before {patch user_path(user)}
 					specify {expect(response).to redirect_to(signin_path)}
 				end
 				
 			end

 			describe "when attempting to visit a protected page" do
 				before do 
 					visit edit_user_path(user)
 					sign_in user
 				end

 				describe "after signing in" do
 					it "should render the desired protected page" do
 						expect(page).to have_title('Edit User')
 					end
 				end
 			end
 	 	end
 	 	describe "as the wrong user" do
 	 		let(:user1) {FactoryGirl.create(:user)}
 	 		let(:user2) {FactoryGirl.create(:user, name: "wrongname", email: "wrong@example.com")}

 	 		before {sign_in user1, no_capybara: true}

 	 		describe "visiting the wrong edit page" do
 	 			before {get edit_user_path(user2)}
 	 			specify {expect(response.body).not_to match(full_title('Edit User'))}
 	 			specify {expect(response).to redirect_to(root_url)}
 	 		end

 	 		describe "visiting the user index as a non admin" do
 					before {get users_path}
 					specify {expect(response.body).not_to match(full_title('All Users'))}
 					specify {expect(response).to redirect_to(root_url)}
 			end

 	 		describe "submitting a PATCH request to the Users#update action" do
 	 			before {patch user_path(user2)}
 	 			specify {expect(response).to redirect_to(root_url)}
 	 		end
 	 	end
 	end


 
end
