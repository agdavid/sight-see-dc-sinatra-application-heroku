require 'spec_helper'

describe User do 
    
    before(:each) do 
        @user = User.create(username: "Tourist Man", email: "touristman@gmail.com", password: "allthesights")
    
        @monument = Sight.create(name: "Monument", description: "something tall")
        @museum = Sight.create(name: "Museum", description: "something wide")
    
        @review1 = Review.create(content: "so tall")
        @review2 = Review.create(content: "so wide")
    end

    after(:each) do
        User.destroy_all
        Sight.destroy_all
        Review.destroy_all
    end
        
    context "instantiates a User" do 
        it "has a username" do 
            expect(@user.username).to eq("Tourist Man")
        end

        it "has an email" do 
            expect(@user.email).to eq("touristman@gmail.com")
        end

        it "has a password" do 
            expect(@user.password).to be_truthy
        end
    end

    context "properly uses slugs" do 
        it "properly slugifies" do 
            expect(@user.slug).to eq("tourist-man")
        end

        it "returns the right user based on a slug" do 
            expect(User.find_by_slug("tourist-man")).to eq(@user)
        end
    end

    context "knows its relationships" do 
        it "has many reviews" do 
            @user.reviews << @review1
            @user.reviews << @review2
            expect(@user.reviews.length).to eq(2)
            expect(@user.reviews).to include(@review1)
            expect(@user.reviews).to include(@review1)            
        end

        it "has many sights" do 
            @user.sights << @museum
            @user.sights << @monument 
            expect(@user.sights.length).to eq(2)
            expect(@user.sights).to include(@museum)
            expect(@user.sights).to include(@monument)
        end
    end
end