# frozen_string_literal: true

require_relative './storage'
require_relative './read_first_scale'
require_relative './../io_adapter'

FORMULAS = [
  { first: 'C', second: 'F', func: ->(value) { value * 1.8 + 32 } },
  { first: 'F', second: 'C', func: ->(value) { (value - 32) / 1.8 } },
  { first: 'C', second: 'K', func: ->(value) { value + 273.15  } },
  { first: 'K', second: 'C', func: ->(value) { value - 273.15  } },
  { first: 'K', second: 'F', func: ->(value) { ((value - 273.15) * 1.8) + 32 } },
  { first: 'F', second: 'K', func: ->(value) { ((value - 32) / 1.8) + 273.15 } }
].freeze

module States
  class CalculateValue < Storage
    def execute
      @firstscale = context[:first_scale]
      @secondscale = context[:second_scale]
      @value = context[:value].to_i

      rule = FORMULAS.find { |rule| rule[:first] == @firstscale && rule[:second] == @secondscale }
      result = rule[:func].call(@value)

      IO_Adapter.instance.write("Result: #{@value.round(3)} °#{@firstscale} = #{result.round(3)} °#{@secondscale}")
    end

    def next
      ReadFirstScale.new
    end
  end
end
