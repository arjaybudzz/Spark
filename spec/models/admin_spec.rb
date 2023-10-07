require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'first name validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(2).is_at_most(30) }
  end

  describe 'middle name validation' do
    it { should validate_length_of(:middle_name).is_at_least(2).is_at_most(30) }
  end

  describe 'last name validations' do
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(2).is_at_most(30) }
  end

  describe 'email validation' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_least(10).is_at_most(30) }

    context 'should reject invalid email formats' do
      sample_invalid_email = %w[example @example example.com example@example,com]

      sample_invalid_email.each do |email|
        it { should_not allow_value(email).for(:email) }
      end
    end
  end

  describe 'password validations' do
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(20) }
  end

  describe 'associations test' do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:subject_coverages).dependent(:destroy) }

    context 'destroyed admin should destroy linked subject coverages' do
      let(:admin_sample) { create(:admin_with_subject_coverages) }

      before { admin_sample.destroy }

      it { expect(SubjectCoverage.count).to eq(0) }
    end

    context 'destroyed admin should destroy linked users' do
      let(:admin_sample) { create(:admin_with_users) }

      before { admin_sample.destroy }

      it { expect(User.count).to eq(0) }
    end
  end
end
