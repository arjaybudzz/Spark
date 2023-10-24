require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association validations' do
    it { should belong_to(:admin) }
    it { should have_many(:answer_sheets).dependent(:destroy) }
    it { should have_many(:quizzes).through(:answer_sheets) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:post_up_votes).through(:posts) }
    it { should have_many(:post_down_votes).through(:posts) }
  end

  describe 'credibility validations' do
    it { should validate_presence_of(:credibility) }
  end

  describe 'Search test' do
    setup do
      @sample_first_user = create(:first_user)
      @sample_second_user = create(:second_user)
      @sample_third_user = create(:third_user)
      @sample_fourth_user = create(:fourth_user)
    end

    context 'should filter by first name' do
      it { expect(User.filter_by_first_name('Rayver').count).to eq(2) }
    end

    context 'should find all the first name and sort them' do
      it { expect([@sample_third_user, @sample_fourth_user]).to match(User.filter_by_first_name('Rayver').sort) }
    end

    context 'should filter by middle name' do
      it { expect(User.filter_by_middle_name(@sample_third_user.middle_name).count).to eq(2) }
    end

    context 'should filter by last name' do
      it { expect(User.filter_by_last_name(@sample_third_user.last_name).count).to eq(1) }
    end

    context "should not find 'Rayver' with last name 'Johnson'" do
      search_hash = { keyword: 'Rayver', last_name: 'Johnson' }
      it { expect(User.search(search_hash).empty?).to eq(true) }
    end

    context "should find 'Rayver' with last name 'Marasigan'" do
      search_hash = { last_name: 'Marasigan', first_name: 'Rayver' }

      it { expect([@sample_fourth_user]).to match(User.search(search_hash)) }
    end

    context 'should return all the users when no parameters' do
      it { expect(User.all.to_a).to match(User.search({})) }
    end
  end
end
