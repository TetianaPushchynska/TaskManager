# frozen_string_literal: true

require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:tasks) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#task_author?' do
    let(:user) { create(:user) }

    it 'returns true if the user has the task author role' do
      expect(user.task_author?).to eq(true)
    end
  end

  describe '#today_task_activity' do
    let(:user) { create(:user) }

    context  '' do
      before {
        create_list(:task, 2, user: user, created_at: Time.now.utc)
        travel_to(2.days.ago) { create(:task, user: user, created_at: Time.now.utc) }
      }

      it 'returns the number of updated tickets for today' do
        expect(user.today_task_activity).to eq(2)
      end
    end

    it 'returns 0 if there are no updated tickets for today' do
      expect(user.today_task_activity).to eq(0)
    end
  end
end
