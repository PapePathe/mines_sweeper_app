FactoryBot.define do
  factory :board do
    name { Faker::Game.title }
    number_of_mines { 5 }
    email { Faker::Internet.email }
    data do
      9.times.map do
        Faker::Types.rb_array(
          len: 6,
          type: -> { Faker::Types.rb_integer(from: 0, to: 1) }
        )
      end
    end
  end
end
