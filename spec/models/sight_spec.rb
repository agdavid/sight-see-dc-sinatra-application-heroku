require 'spec_helper'

describe Sight do 
    before(:each) do 
        @sight = Sight.create(name: "The White House", description: "Home of the US President.")
    
        @him = User.create(username: "Tourist Man", email: "touristman@gmail.com", password: "allthesights")
        @her = User.create(username: "Tourist Woman", email: "touristwoman@gmail.com", password: "allthesights")
    
        @review1 = Review.create(content: "so tall")
        @review2 = Review.create(content: "so wide")
    end

    after(:each) do
        Sight.destroy_all
        User.destroy_all
        Review.destroy_all
    end

    context "instantiates a Sight" do 
        it "has a name" do 
            expect(@sight.name).to eq("The White House")
        end
        it "has a description" do 
            expect(@sight.description).to eq("Home of the US President.")
        end
    end

    context "knows its relationships" do 
        it "has many reviews" do
            @sight.reviews << @review1
            @sight.reviews << @review2

            expect(@sight.reviews.length).to eq(2)
            expect(@sight.reviews).to include(@review1) 
            expect(@sight.reviews).to include(@review2) 
        end
        it "has many users" do 
            @sight.users << @him
            @sight.users << @her 

            expect(@sight.users.length).to eq(2)
            expect(@sight.users).to include(@him)
            expect(@sight.users).to include(@her)
        end
    end
end