class Station 
  attr_reader :name, :zone
  DEFAULT_ZONE = 1

  def initialize(name: name, zone: zone)
    @name = name
    @zone = zone
  end

end
