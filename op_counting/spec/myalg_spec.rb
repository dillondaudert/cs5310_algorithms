#Date: 09/13/2017
#Class: CS5310
#Assignment: Assignment 2
#Author: Dillon Daudert

require 'spec_helper'

#all tests for the myalg class
describe MyAlg do

    #before each test, create a new myalg object
    before :each do
        @myalg = MyAlg.new [8, -6, 7, -5, 3, 0, -9]
    end

    describe "#new" do
        it "takes an integer array parameter and returns a MyAlg object" do
            expect(@myalg).to be_an_instance_of MyAlg
        end

        it "makes sure the array only contains integers" do
            expect {MyAlg.new [2, 3, 4.4]}.to raise_error ArgumentError
        end

        it "makes sure that at least one element is in the array" do
            expect {MyAlg.new []}.to raise_error ArgumentError
        end
    end

    describe "#array" do
        it "returns the correct array" do
            expect(@myalg.array).to eql [8, -6, 7, -5, 3, 0, -9] 
        end
    end

    describe "#bubble_sort" do
        it "returns an array" do
            expect(@myalg.bubble_sort).to be_an_instance_of Array
        end

        it "sorts the array" do
            arr = @myalg.bubble_sort
            expect(arr.each_cons(2).all? {|a, b| (a <= b)}).to be true
        end

        context "with all the same integer" do
            it "sorts the array" do
                myalg2 = MyAlg.new [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
                expect(myalg2.bubble_sort).to eql [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
            end
        end
    end

    describe "#linear_search" do
        it "returns -1 when item not found" do
            expect(@myalg.linear_search 10).to be -1
        end

        it "returns the item index if found" do
            ind = @myalg.linear_search 3
            expect(@myalg.array[ind]).to eql 3
        end

        it "throws an error if a non-integer is passed in" do
            expect {ans = @myalg.linear_search 3.3}.to raise_error ArgumentError

        end
    end

    describe "#swap" do
        it "swaps even indices with consecutive odd indices" do
            expect(@myalg.swap).to eql [-6, 8, -5, 7, 0, 3, -9]
        end

        it "returns the same array if array.length is 1" do
            myalg2 = MyAlg.new [3]
            expect(myalg2.swap).to eql [3]
        end
    end

end
