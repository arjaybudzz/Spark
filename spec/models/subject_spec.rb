require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'associations test' do
    it { should belong_to(:admin) }
    it { should have_many(:topics).dependent(:destroy) }

    context 'destroyed subjects must destroy linked topics' do
      let(:subject) { create(:subject_with_topics) }

      before { subject.destroy }

      it { expect(Topic.count).to eq(0) }
    end
  end

  describe 'subject name validation' do
    it { should validate_presence_of(:name) }

    context 'should ensure subject uniqueness with scope to admin' do
      before { create(:subject) }

      it { should validate_uniqueness_of(:name).scoped_to(:admin_id) }
    end
  end
end
