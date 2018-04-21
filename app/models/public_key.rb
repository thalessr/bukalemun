# frozen_string_literal: true

class PublicKey < ApplicationRecord

  belongs_to :user

  validates :key, presence: true

end
