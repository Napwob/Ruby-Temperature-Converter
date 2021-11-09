# frozen_string_literal: true

require_relative './storage'
require_relative './read_value'
require_relative './../io_adapter'

module States
  class ReadSecondScale < Storage
    def execute
      IO_Adapter.instance.write('Please, enter second convertation scale(C, F, K)')
    end

    def next
      @scale = IO_Adapter.instance.read.upcase
      exit if @scale == 'E'
      if SCALES.include?(@scale)
        it_familiar?
      else
        IO_Adapter.instance.write("#{@scale} is not conversation scale")
        self
      end
    end

    def it_familiar?
      if @scale == context[:first_scale]
        IO_Adapter.instance.write("Second convertation scale must not be the same as first one \"#{context[:first_scale]}\"")
        self
      else
        ReadValue.new(context.merge(second_scale: @scale))
      end
    end
  end
end
