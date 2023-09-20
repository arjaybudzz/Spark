require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'associations test' do
    it { should belong_to(:subject) }
  end

  describe 'topic name validation' do
    it { should validate_presence_of(:name) }

    context "should validate topic's uniqueness" do
      before { create(:topic) }

      it { should validate_uniqueness_of(:name).scoped_to(:subject_id) }
    end
  end

  describe 'discussion attribute validation' do
    it { should validate_presence_of(:discussion) }
  end
end
