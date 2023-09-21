require 'rails_helper'

RSpec.describe 'Api::V1::Subjects', type: :request do
  setup do
    @subject = create(:subject_with_topics)
    @subject_valid_attribute = attributes_for(:subject)
    @subject_invalid_attribute = attributes_for(:empty_subject_name)
  end

  describe 'GET /index' do
    before do
      create_list(:subject, 9)
      get api_v1_subjects_url, as: :json
    end

    it { expect(json[:data].length).to eq(10) } # @subject object included
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_subject_url(@subject), as: :json
    end

    it { expect(json[:data][:attributes][:name]).to match(@subject.name) }

    it 'should match its related admin' do
      expect(json[:data][:relationships][:admin][:data][:id]).to match(@subject.admin.id.to_s)

      expect(json[:included][0][:attributes][:email]).to match(@subject.admin.email)
    end

    it 'should match its related topic' do
      expect(json[:data][:relationships][:topics][:data][0][:id]).to match(@subject.topics.first.id.to_s)
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create subject if there logged in' do
      before do
        post api_v1_subjects_url,
          params: { subject: @subject_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @subject.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create if subject if input is invalid but logged in' do
      before do
        post api_v1_subjects_url,
          params: { subject: @subject_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @subject.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create subject if not logged in' do
      before do
        post api_v1_subjects_url,
          params: { subject: @subject_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update subject if input is valid and logged in' do
      before do
        put api_v1_subject_url(@subject),
          params: { subject: @subject_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @subject.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update subject if input is invalid but logged in' do
      before do
        put api_v1_subject_url(@subject),
          params: { subject: @subject_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @subject.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid update subject if admin is not logged in' do
      before do
        put api_v1_subject_url(@subject),
          params: { subject: @subject_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy subject if admin is the owner' do
      before do
        delete api_v1_subject_url(@subject),
          headers: { Authorization: JsonWebToken.encode(admin_id: @subject.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy subject if admin is the owner' do
      before do
        delete api_v1_subject_url(@subject), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
