require 'spec_helper'

describe "Posts" do
  
  subject {page}

  describe "create post" do
    before {visit root_url}
    it {should_not have_link('Create Post')}

    describe "as a non admin user" do
      let(:user) {FactoryGirl.create(:user)}
      before {sign_in user}
      it {should_not have_link('Create Post')}
    end

    describe "as an admin" do
      let(:admin) {FactoryGirl.create(:admin)}
      before {sign_in admin}
      it {should have_link('Create Post')}
    end 
  end

  describe "Index Page" do
   #  let(:admin) {FactoryGirl.create(:admin)}
   #  let!(:p1) {FactoryGirl.create(:post, user: admin, content: "foo")}
   #  let!(:p2) {FactoryGirl.create(:post, user: admin, content: "bar")}

   #  before {visit posts_path}

   #  it {should have_content(admin.name)}

   #  describe "posts" do
   #    it {should have_content(p1.content)}
   #    it {should have_content(p2.content)}
   #    it {should have_content(admin.posts.count)}
   #  end


  	# it "should have the content 'Posts Home'" do
  	# 	visit '/posts/home/'
  	# 	expect(page).to have_content('Posts Home')
  	# end

  	# it "should have the title 'Posts Home'" do
  	# 	visit '/posts/home/'
  	# 	expect(page).to have_title('Thomas DeFina Blog App')
  	# end

   #  it "should not have a custom page title" do
   #    visit '/posts/home/'
   #    expect(page).not_to have_title('| Posts Home')
   #  end

  end

   describe "Home Page" do
      let(:admin) {FactoryGirl.create(:admin)}
      let!(:p1) {FactoryGirl.create(:post, user: admin, content: "foo")}
      let!(:p2) {FactoryGirl.create(:post, user: admin, content: "bar")}



      before do
        visit home_path
        p1.tag!("gaming");
      end

      it {should have_content(admin.name)}

      describe "posts" do
        it {should have_content(p1.content)}
        it {should have_content(p2.content)}
        it {should have_content(admin.posts.count)}

        
        it "should have the right tags" do
          p1.tags.each do |tag|
            expect(page).to have_selector('tags', tag)
          end
        end

        describe "tag cloud" do
          it {should have_selector('tag-cloud')}
          it "should have all current tags" do
            Tag.all.each do |tag|
              expect(page).to have_selector('tag-cloud', tag)
            end
          end
        end

        
      end
    end

    describe "as the wrong user" do
      let(:user1) {FactoryGirl.create(:user)}
      let(:admin) {FactoryGirl.create(:admin)}
      let!(:m1) {FactoryGirl.create(:post, user: admin)}

      before {sign_in user1, no_capybara: true}

      describe "submitting a PATCH request to the Users#update action" do
        before {patch post_path(m1)}
        specify {expect(response).to redirect_to(root_url)}
      end
    end
end
