# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  describe ".search" do
    it 'raises error when search criteria is unknown' do
      search_params = { by_name: 'test' }
      expect { Board.search(search_params) }.to raise_error(BoardSearchCriteriaNotFound)
    end
  end
end
