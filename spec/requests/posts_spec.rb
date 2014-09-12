require 'spec_helper'

describe "Posts" do
  describe "Index Page" do

  	it "should have the content 'Posts Home'" do
  		visit '/posts/home/'
  		expect(page).to have_content('Posts Home')
  	end

  	it "should have the title 'Posts Home'" do
  		visit '/posts/home/'
  		expect(page).to have_title('Thomas DeFina Blog App | Posts Home')
  	end

    it "should not have a custom page title" do
      visit '/posts/home/'
      expect(page).not_to have_title('| Home')
    end

  end
end
