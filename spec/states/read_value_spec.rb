# frozen_string_literal: true

require_relative './../../src/states/calculate_value'
require_relative './../../src/states/read_value'
require_relative './../../src/io_adapter'

describe States::ReadValue do
  let(:adapter) { double 'IO_Adapter' }

  before do
    allow(IO_Adapter).to receive(:instance).and_return(adapter)
    allow(adapter).to receive(:write)
  end

  describe '#execute' do
    it 'execute correct sentence' do
      subject.execute
      expect(adapter).to have_received(:write).with('Please, enter convertation value')
    end
  end

  describe '#next' do
    subject { described_class.new(source_scale: 'K').next }
    before { allow(adapter).to receive(:read).and_return(value) }

    context 'When user enter number' do
      let(:value) { '24' }
      it { is_expected.to be_a(States::CalculateValue) }
    end

    context 'When user not enter number' do
      let(:value) { 'Not_number' }
      it { is_expected.to be_a(States::ReadValue) }
      it 'execution error' do
        subject
        expect(adapter).to have_received(:write).with('Not_number is not correct value')
      end
    end
  end
end
