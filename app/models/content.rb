# frozen_string_literal: true

class Content < ApplicationRecord

  belongs_to :owner, class_name: 'User' # rubocop:disable InverseOf
  belongs_to :recipient, class_name: 'User' # rubocop:disable InverseOf

end
