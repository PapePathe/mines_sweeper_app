class Board < ApplicationRecord
  validates :email, presence: true
  validates :data, presence: true
  validates :number_of_mines, presence: true, numericality: true

  scope :by_email, ->(email) { where(email: email) }
  scope :by_number_of_mines, ->(mines_count) { where("number_of_mines >= ?", mines_count.to_i) }

  def self.search(search_params)
    results = where(nil)
    search_params.each do |key, value|
      results = results.public_send(key, value) if value.present?
    end
    results
  end
end
