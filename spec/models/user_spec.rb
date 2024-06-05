require "rails_helper"

RSpec.describe User, type: :model do
    describe "validations" do
      it "ensures presence of email" do
        is_expected.to validate_presence_of :email
      end 

      it "ensures uniqueness of email" do
        is_expected.to validate_uniqueness_of(:email).case_insensitive
      end 

      it "ensures presence of first name" do
        is_expected.to validate_presence_of :first_name
      end 

      it "ensures presence of last name" do
        is_expected.to validate_presence_of :last_name
      end 

      it "ensures presence of twitter handle" do
        is_expected.to validate_presence_of :twitter_handle
      end 

      it "ensures uniqueness of twitter handle" do
        is_expected.to validate_uniqueness_of(:twitter_handle).case_insensitive
      end 
    end
end
