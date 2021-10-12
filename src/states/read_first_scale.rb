# frozen_string_literal: true

require_relative './storage'
require_relative './read_second_scale'
require_relative './../io_adapter'

module States
  class ReadFirstScale < Storage
    def execute
      IO_Adapter.instance.write('Please, enter first convertation scale(C, F, K)')
    end

    def next
      scale = IO_Adapter.instance.read.upcase
      exit if scale == 'E'
      if SCALES.include?(scale)
        ReadSecondScale.new(context.merge(first_scale: scale))
      else
        IO_Adapter.instance.write("#{scale} is not conversation scale")
        self
      end
    end
  end
end
