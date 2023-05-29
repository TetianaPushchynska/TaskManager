# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to define_audits }

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it 'validates enum' do
      is_expected.to define_enum_for(:status).with_values(described_class::STATUSES).backed_by_column_of_type(:string)
      is_expected.to define_enum_for(:priority).with_values(described_class::PRIORITIES).
        backed_by_column_of_type(:string)
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:priority) }
  end

  describe 'scopes' do
    describe '.by_priority' do
      let!(:high_priority_task) { create(:task, priority: 'high') }
      let!(:medium_priority_task) { create(:task, priority: 'medium') }
      let!(:low_priority_task) { create(:task, priority: 'low') }

      it 'returns tasks with the specified priority' do
        expect(Task.by_priority('high')).to eq([high_priority_task])
      end

      it 'returns all tasks when no priority is specified' do
        expect(Task.by_priority(nil)).to eq([high_priority_task, medium_priority_task, low_priority_task])
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:priority) }
  end
end
