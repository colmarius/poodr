class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * diameter
  end

  def diameter
    rim + (tire * 2)
  end
end

# puts Gear.new(52, 11, 26, 1.5).ratio
# puts Gear.new(52, 11, 26, 1.5).gear_inches
# puts Gear.new(30, 27, 24, 1.25).ratio
# puts Gear.new(30, 27, 24, 1.25).gear_inches

class RevealingReferences
  attr_reader :wheels

  Wheel = Struct.new(:rim, :tire)

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect { |wheel| diameter(wheel) }
  end

  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  def wheelify(data)
    data.collect { |cell|
      Wheel.new(cell[0], cell[1])
    }
  end
end

# puts RevealingReferences.new([[10, 20], [5, 10]]).wheels
# puts RevealingReferences.new([[10, 20], [5, 10]]).diameters


class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end
end

# puts Gear.new(52, 11, 26, 1.5).ratio
# puts Gear.new(52, 11, 26, 1.5).gear_inches

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel = nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference

@gear = Gear.new(52, 11, @wheel)
puts @gear.gear_inches
puts @gear.ratio
