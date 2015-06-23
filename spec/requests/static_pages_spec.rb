require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    it { should have_content ('Sample App') }
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    it { should have_title (full_title('')) }
    it { should_not have_title ('| Home') }
    
    	  describe "Help page" do
	    before { visit help_path }
	
	    it { should have_content ('Help') }
	    it { should have_title (full_title('Help')) }
	  end
	
	  describe "About page" do
	    before { visit about_path }
	
	    it { should have_content('About') }
	    it { should have_title(full_title('About Us')) }
	  end
	
	  describe "Contact page" do
	    before { visit contact_path }
	
	    it { should have_content('Contact') }
	    it { should have_title(full_title('Contact')) }
	  end
	  
	  describe "for signed-in users" do
		  let(:user) { FactoryGirl.create(:user) }
		  before do
			  FactoryGirl.create(:micropost, user: user, content: "Lorem")
			  FactoryGirl.create(:micropost, user: user, content: "Ipsum")
			  sign_in user
			  visit root_path
			end
			
			it "should render the user's feed" do
		    user.feed.each do |item|
			    expect(page).to have_selector("li#{item.id}", text: item.content)
			  end
		  end
		  
		  describe "follower/following counts" do
	      let(:other_user) { FactoryGirl.create(:user) }
	      before do
		      other_user.follow!(user)
		      visit root_path
		    end
		    
		    it { should have_link("0 following", href: following_user_path(user)) }
		    it { should have_link("1 followers", href: followers_user_path(user)) }
			end
	  end
  end
end