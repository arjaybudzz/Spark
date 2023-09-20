require 'rails_helper'

RSpec.describe JsonWebToken do
  setup do
    @admin = create(:admin)
  end

  describe 'decoded token should match the original id' do
    before do
      @token = JsonWebToken.encode(admin_id: @admin.id)
    end

    it { expect(JsonWebToken.decode(@token)[:admin_id]).to match(@admin.id) }
  end
end
