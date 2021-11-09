# frozen_string_literal: true

require_relative './../../src/states/read_first_scale'
require_relative './../../src/states/read_second_scale'
require_relative './../../src/io_adapter'

describe States::ReadFirstScale do
  let(:adapter) { double 'IO_Adapter' }

  before do
    allow(IO_Adapter).to receive(:instance).and_return(adapter)
    allow(adapter).to receive(:write)
  end

  describe '#execute' do
    it 'execute correct sentence' do
      subject.execute
      expect(adapter).to have_received(:write).with('Please, enter first convertation scale(C, F, K)')
    end
  end

  describe '#next' do
    subject { described_class.new.next }
    before { allow(adapter).to receive(:read).and_return(value) }

    context 'When user enter "K"' do
      let(:value) { 'K' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end

    context 'When user enter "F"' do
      let(:value) { 'F' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end

    context 'When user enter "C"' do
      let(:value) { 'C' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end
    context 'When user enter low char "k"' do
      let(:value) { 'k' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end

    context 'When user enter low char "f"' do
      let(:value) { 'f' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end

    context 'When user enter low char "c"' do
      let(:value) { 'c' }
      it { is_expected.to be_a(States::ReadSecondScale) }
    end

    context 'When user dont enter scale' do
      let(:value) { 'U' }
      it { is_expected.to be_a(States::ReadFirstScale) }
      it 'execution error' do
        subject
        expect(adapter).to have_received(:write).with('U is not conversation scale')
      end
    end
  end
end
