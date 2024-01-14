# frozen_string_literal: true

class Board < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :data, presence: true
  validates :number_of_mines, presence: true, numericality: true

  scope :by_email, ->(email) { where(email:) }
  scope :by_number_of_mines, ->(mines_count) { where('number_of_mines >= ?', mines_count.to_i) }

  def self.search(search_params)
    results = where(nil)
    search_params.each do |key, value|
      raise BoardSearchCriteriaNotFound unless results.respond_to?(key)
      results = results.public_send(key, value) if value.present?
    end
    results
  end
end
