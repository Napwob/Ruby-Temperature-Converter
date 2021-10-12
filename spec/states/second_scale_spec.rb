# frozen_string_literal: true

require_relative './../../src/states/read_second_scale'
require_relative './../../src/states/read_value'
require_relative './../../src/io_adapter'

describe States::ReadSecondScale do
  let(:adapter) { double 'IO_Adapter' }

  before do
    allow(IO_Adapter).to receive(:instance).and_return(adapter)
    allow(adapter).to receive(:write)
  end

  describe '#execute' do
    it 'execute correct sentence' do
      subject.execute
      expect(adapter).to have_received(:write).with('Please, enter second convertation scale(C, F, K)')
    end
  end

  describe '#next' do
    subject { described_class.new(first_scale: 'K').next }
    before { allow(adapter).to receive(:read).and_return(value) }

    context 'When the user enter right scale that equal to previous one' do
      let(:value) { 'K' }
      it { is_expected.to be_a(States::ReadSecondScale) }
      it 'execution error' do
        subject
        expect(adapter).to have_received(:write).with('Second convertation scale must not be the same as first one "K"')
      end
    end

    context 'When the user enter right scale that equal to previous one but low char' do
      let(:value) { 'k' }
      it { is_expected.to be_a(States::ReadSecondScale) }
      it 'execution error' do
        subject
        expect(adapter).to have_received(:write).with('Second convertation scale must not be the same as first one "K"')
      end
    end

    context 'When the user enter right scale' do
      let(:value) { 'C' }
      it { is_expected.to be_a(States::ReadValue) }
    end

    context 'When the user enter right low char scale' do
      let(:value) { 'c' }
      it { is_expected.to be_a(States::ReadValue) }
    end

    context 'When the user dont enter scale' do
      let(:value) { 'U' }
      it { is_expected.to be_a(States::ReadSecondScale) }
      it 'execution error' do
        subject
        expect(adapter).to have_received(:write).with('U is not conversation scale')
      end
    end
  end
end
