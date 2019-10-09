require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  describe Oystercard do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end


  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1}.to raise_error "Maximum balance of 90 exceeded"
  end

  it 'raises an error if insufficient balance' do
    expect{ subject.touch_in entry_station}.to raise_error "insufficient balance"
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    subject.top_up(2)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq true
  end

  it "can touch out" do
    subject.top_up(2)
    subject.touch_in(entry_station)
    expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_AMOUNT)
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to eq false
  end

  it 'stores the entry station' do
    subject.top_up(2)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'stores exit station' do
    subject.top_up(2)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    subject.top_up(2)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.journeys).to include journey
end

  it 'fail to touch in' do
    subject.top_up(2)
    expect{ subject.touch_out(exit_station) }.to raise_error 'failed to touch in'
  end

  it 'fail to touch out' do
    subject.top_up(2)
    subject.touch_in(entry_station)
    expect{ subject.touch_in(entry_station)}.to raise_error 'failed to touch out'
  end
  end

  end
