# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password_digest) }
  end

  describe 'db indexes' do
    it { is_expected.to have_db_index(:username) }
    it { is_expected.to have_db_index(:password_digest) }
  end

  describe 'associations' do
    it { is_expected.to have_one(:public_key) }
    it { is_expected.to have_one(:encrypted_private_key) }
  end
end
