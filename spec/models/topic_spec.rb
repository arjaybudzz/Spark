require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'associations test' do
    it { should belong_to(:subject) }
    it { should have_many(:quizzes).dependent(:destroy) }

    context 'destroyed topic should destroy linked quizzes' do
      let(:sample_topic) { create(:topic_with_quizzes) }

      before { sample_topic.destroy }

      it { expect(Quiz.count).to eq(0) }
    end
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
