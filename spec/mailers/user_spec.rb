require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  setup do
    @mail_to_user = UserMailer.received_confirmation
    @user_sample = create(:user)
  end

  describe "received_confirmation" do
    let(:mail) { UserMailer.received_confirmation(@user_sample) }

    it "renders the headers" do
      expect(mail.subject).to eq("Thank you for signing up!")
      expect(mail.to).to eq([@user_sample.email])
      expect(mail.from).to eq([@user_sample.admin.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thank you for joining Spark! I hope it will help you achieve your dreams!")
    end
  end

end
