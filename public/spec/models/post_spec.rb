require 'spec_helper'

describe Post do
 	let (:admin) {FactoryGirl.create(:admin)}

 	before do
 		@post = admin.posts.build(title: "title", content: "content")
 	end

 	subject {@post}

 	it {should respond_to(:title)}
 	it {should respond_to(:content)}
 	it {should respond_to(:user_id)}
 	it {should respond_to(:user)}
 	it {should respond_to(:tag!)} 
 	it {should respond_to(:has_tag?)}
 	it {should respond_to(:tags)}
 	


 	describe "tagging" do
 		let(:tag) {FactoryGirl.create(:tag)}
 	end


 	its(:user) {should eq admin}

 	it {should be_valid}

 	describe "when a user_id is not present" do
 		before {@post.user_id = nil}
 		it {should_not be_valid}
 	end

 	describe "with blank content" do
 		before {@post.content = " "}
 		it {should_not be_valid}
 	end

 	describe "with blank title" do
 		before {@post.title = " "}
 		it {should_not be_valid}
 	end
end
