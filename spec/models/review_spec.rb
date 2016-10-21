require 'spec_helper'

describe Review do 
    before(:each) do 
        @review = Review.create(content: "so tall")
        @sight = Sight.create(name: "The White House", description: "Home of the US President.")
        @user = User.create(username: "Tourist", email: "tourist@gmail.com", password: "allthesights")
    end

    after(:each) do 
      Review.destroy_all
      Sight.destroy_all
      User.destroy_all
    end

    context "instantiates a Review" do 
        it "has content" do 
            expect(@review.content).to eq("so tall")
        end
    end

    context "knows its relationships" do 
        it "has one user" do 
            @user.reviews << @review 
            expect(@review.user).to eq(@user) 
        end
        it "has one sight" do 
            @sight.reviews << @review 
            expect(@review.sight).to eq(@sight)
        end
    end
end