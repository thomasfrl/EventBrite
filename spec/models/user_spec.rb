require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#invalid" do
    it "should have a first_name" do
      invalid_user = FactoryBot.build(:user, first_name: nil)
      expect(invalid_user).not_to be_valid
      expect(invalid_user.errors.include?(:first_name)).to eq(true)
    end

    it "should have a last_name" do
      invalid_user = FactoryBot.build(:user, last_name: nil)
      expect(invalid_user).not_to be_valid
      expect(invalid_user.errors.include?(:last_name)).to eq(true)
    end

    it "should have an email" do
      invalid_user = FactoryBot.build(:user, email: nil)
      expect(invalid_user).not_to validate_presence_of(:email)
    end
  end
end
