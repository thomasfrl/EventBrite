require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do 
    @event = FactoryBot.build(:event)   
    @unvalid_event = FactoryBot.build(:event)    
 
  end

  it "has a valid factory" do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:event)).to be_valid
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@event).to be_a(Event)
    end

    describe "#duration" do
      it { expect(@event).to validate_presence_of(:duration) }
    end

    describe "#start_date" do
      it { expect(@event).to validate_presence_of(:start_date) }
    end

    describe "#title" do
      it { expect(@event).to validate_presence_of(:title) }
      it { expect(@event).to validate_length_of(:title).is_at_least(5) }
      it { expect(@event).to validate_length_of(:title).is_at_most(140) }
    end


    describe "#description" do
      it { expect(@event).to validate_presence_of(:description) }
      it { expect(@event).to validate_length_of(:description).is_at_least(20) }
      it { expect(@event).to validate_length_of(:description).is_at_most(1000) }
    end

  end

  context "associations" do

    describe "admin" do
      it { expect(@event).to belong_to(:administrator) }
      it { expect(@event).to have_many(:users) }
      it { expect(@event).to have_many(:attendances) }
    end

  end
end
