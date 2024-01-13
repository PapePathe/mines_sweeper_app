# frozen_string_literal: true

require 'benchmark'

Benchmark.bm do |x|
  x.report('generate 1000x1000')   { BoardGenerator.new.generate(1000, 1000, 10_000) }
  x.report('generate 10000x10000') { BoardGenerator.new.generate(10_000, 10_000, 200_000) }
  x.report('generate 10000x10000') { BoardGenerator.new.generate(10_000, 10_000, 20_000_000) }
end

Benchmark.bm do |x|
  x.report('generate with fibers 1000x1000')   { BoardGenerator.new.generate(1000, 1000, 10_000) }
  x.report('generate with fibers 10000x10000') { BoardGenerator.new.generate(10_000, 10_000, 200_000) }
  x.report('generate with fibers 10000x10000') { BoardGenerator.new.generate(10_000, 10_000, 20_000_000) }
end
