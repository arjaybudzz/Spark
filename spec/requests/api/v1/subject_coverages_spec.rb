require 'rails_helper'

RSpec.describe "Api::V1::SubjectCoverages", type: :request do

  setup do
    @subject_coverage = create(:subject_coverage)
    @subject_coverage_valid_attributes = attributes_for(:subject_coverage)
    @subject_coverage_invalid_attributes = attributes_for(:empty_name)
  end

  describe "GET /index" do
    before do
      create_list(:subject_coverage, 9)
      get api_v1_subject_coverages_url, as: :json
    end

    it { expect(json[:data].length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_subject_coverage_url(@subject_coverage), as: :json
    end

    it { expect(json[:data][:attributes][:name]).to match(@subject_coverage.name) }
    it { expect(response).to have_http_status(:success) }

    it 'should match its associations' do
      expect(json[:data][:relationships][:admin][:data][:id]).to match(@subject_coverage.admin.id.to_s)
    end
  end

  describe 'POST /create' do
    context 'create a coverage if input is valid and with existing admin' do
      before do
        post api_v1_subject_coverages_url,
            params: { subject_coverage: @subject_coverage_valid_attributes },
            headers: { Authorization: JsonWebToken.encode(admin_id: @subject_coverage.admin_id) },
            as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a coverage if input is empty' do
      before do
        post api_v1_subject_coverages_url,
            params: { subject_coverage: @subject_coverage_invalid_attributes },
            headers: { Authorization: JsonWebToken.encode(admin_id: @subject_coverage.admin_id) },
            as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a coverage if there is no admin' do
      before do
        post api_v1_subject_coverages_url,
            params: { subject_coverage: @subject_coverage_valid_attributes },
            as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
