class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_AMOUNT = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

   def top_up(amount)
     fail "Maximum balance of 90 exceeded" if amount + balance > MAXIMUM_BALANCE
     @balance += amount
   end

   def deduct(amount)
     @balance -= amount
   end

   def in_journey?
     !!entry_station
   end

   def touch_in(station)
     fail "insufficient balance" if @balance < MINIMUM_AMOUNT
     fail "failed to touch out" if @entry_station == true

     @entry_station = station
   end

   def touch_out(station)
    deduct(MINIMUM_AMOUNT)
    @exit_station = station
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end
end
