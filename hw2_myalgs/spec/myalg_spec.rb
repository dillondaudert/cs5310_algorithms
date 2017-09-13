#Date: 09/13/2017
#Class: CS5310
#Assignment: Assignment 2
#Author: Dillon Daudert

require 'spec_helper'

#all tests for the myalg class
describe MyAlg do

    #before each test, create a new myalg object
    before :each do
        @myalg = MyAlg.new [8, 6, 7, 5, 3, 0, 9]
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
            expect(@myalg.array).to eql [8, 6, 7, 5, 3, 0, 9] 
        end
    end

    describe "#bubble_sort" do
        it "returns the array" do
            expect(@myalg.bubble_sort).to be_an_instance_of Array
        end

        it "sorts the array" do
            arr = @myalg.bubble_sort
            expect(arr.each_cons(2).all? {|a, b| (a <= b)}).to be true
        end
    end

    describe "#linear_search" do

    end

    describe "#swap" do

    end

end
