class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args = {})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def post_initialize(args)
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError,
      "This #{ self.class } cannot respond to: default_tire_size"
  end

  def spares
    { tire_size: tire_size,
      chain: chain }.merge(local_spares)
  end

  def local_spares
    {}
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def default_tire_size
    '23'
  end

  def local_spares
    { tape_color: tape_color }
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_schock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_schock = args[:rear_schock]
  end

  def default_tire_size
    '2.1'
  end

  def local_spares
    { rear_schock: rear_schock }
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end

  def local_spares
    { flag: flag }
  end
end

rb = RoadBike.new(size: 'M', tape_color: 'red')
puts rb.spares

mb = MountainBike.new(size: 'S', front_shock: 'Fox', rear_schock: 'Fox')
puts mb.spares

rb = RecumbentBike.new(size: 'XL', flag: 'red')
puts rb.spares
