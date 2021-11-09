# frozen_string_literal: true

require_relative './../../src/states/calculate_value'
require_relative './../../src/states/read_first_scale'
require_relative './../../src/io_adapter'

describe States::CalculateValue do
  let(:adapter) { double 'IO_Adapter' }

  before do
    allow(IO_Adapter).to receive(:instance).and_return(adapter)
    allow(adapter).to receive(:write)
  end

  describe '#execute' do
  end
end
