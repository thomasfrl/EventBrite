require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase

  before(:each) do 
    @attendance = FactoryBot.create(:attendance)    
  end

  context "validation" do

    describe "#stripe_customer_id" do
      it { expect(@attendance).to validate_presence_of(:stripe_customer_id) }
    end
  end
end
