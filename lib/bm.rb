require 'benchmark'

Benchmark.bm do |x|
  x.report("generate 1000x1000")   { BoardGenerator.new.generate(1000, 1000, 10000) }
  x.report("generate 10000x10000") { BoardGenerator.new.generate(10000, 10000, 200000) }
  x.report("generate 10000x10000") { BoardGenerator.new.generate(10000, 10000, 20000000) }
end

Benchmark.bm do |x|
  x.report("generate with fibers 1000x1000")   { BoardGenerator.new.generate(1000, 1000, 10000) }
  x.report("generate with fibers 10000x10000") { BoardGenerator.new.generate(10000, 10000, 200000) }
  x.report("generate with fibers 10000x10000") { BoardGenerator.new.generate(10000, 10000, 20000000) }
end
