require 'rails_helper'

RSpec.describe BoardGenerator do
  let(:instance) { described_class.new }

  it "raises errors if arguments are invalid" do
    expect { instance.generate(5, 5, "5a") }.to raise_error(InvalidArgument) # W: Prefer single-quoted strings when you don't need string interpolation or specia
    expect { instance.generate(5, [5], 5) }.to raise_error(InvalidArgument)
    expect { instance.generate("test", 5, 5) }.to raise_error(InvalidArgument) # W: Prefer single-quoted strings when you don't need string interpolation or speci
    expect { instance.generate(0, 5, 5) }.to raise_error(InvalidArgument)
    expect { instance.generate(-1, 5, 5) }.to raise_error(InvalidArgument)
    expect { instance.generate(2, 0, 5) }.to raise_error(InvalidArgument)
    expect { instance.generate(2, -1, 5) }.to raise_error(InvalidArgument)
    expect { instance.generate(2, 2, 5) }.to raise_error(InvalidArgument)
  end

  it "generates a board" do # W: Prefer single-quoted strings when you don't need string interpolation or special symbols.
    Board = Struct.new(:mines_count, :rows, :columns) # W: has no descriptive comment
    [
      Board.new(mines_count: 14, rows: 5, columns: 5),
      Board.new(mines_count: 500, rows: 50, columns: 50),
      Board.new(mines_count: 5000, rows: 500, columns: 4000)
    ].each do |test|
      result = instance.generate(test.rows, test.columns, test.mines_count)
      expect(result.length).to eq(test.rows)
      result.each do |row|
        expect(row.length).to eq(test.columns)
      end
      mines_count = result.flatten.count { |i| i == 1 }
      expect(mines_count).to eq(test.mines_count)
    end
  end
end
