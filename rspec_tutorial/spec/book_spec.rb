#Date: 09/05/2017
#Class: CS 5310
#Assignment: Assignment 1
#Author: Dillon Daudert

require 'spec_helper'

# the parameter to describe (Book) explains what we're testing
describe Book do

    # the call before :each says to run this code before each test
    before :each do
        @book = Book.new "Title", "Author", :category
    end

    describe "#new" do
        it "takes three parameters and returns a Book object" do
            #@book.should be_an_instance_of Book
            expect(@book).to be_an_instance_of Book
        end
    end

    describe "#title" do
        it "returns the correct title" do
            #@book.title.should eql "Title"
            expect(@book.title).to eql "Title"
        end
    end

    describe "#author" do
        it "returns to correct author" do
            #@book.author.should eql "Author"
            expect(@book.author).to eql "Author"
        end
    end

    describe "#category" do
        it "returns the correct category" do
            #@book.category.should eql :category
            expect(@book.category).to eql :category
        end
    end

end
