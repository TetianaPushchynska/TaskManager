# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it 'validates enum' do
      is_expected.to define_enum_for(:status).with_values(described_class::STATUSES).backed_by_column_of_type(:string)
      is_expected.to define_enum_for(:priority).with_values(described_class::PRIORITIES).
        backed_by_column_of_type(:string)
    end
  end
end
