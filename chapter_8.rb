class Bicycle
  attr_reader :size, :parts

  def initialize(args = {})
    @size = args.fetch(:size)
    @parts = args.fetch(:parts)
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

chain = Part.new(name: 'chain', description: '10-speed')

road_tire = Part.new(name: 'tire_size', description: '23')

tape = Part.new(name: 'tape_color', description: 'red')

mountain_tire = Part.new(name: 'tire_size', description: '2.1')

rear_shock = Part.new(name: 'rear_shock', description: 'Fox')

front_shock =
  Part.new(
    name: 'front_shock',
    description: 'Manitou',
    needs_spare: false)

road_bike =
  Bicycle.new(
    size: 'L',
    parts: Parts.new([chain, road_tire, tape]))

puts road_bike.size
puts road_bike.spares.inspect

mountain_bike =
  Bicycle.new(
    size: 'L',
    parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))

puts mountain_bike.size
puts mountain_bike.spares.inspect

puts mountain_bike.spares.size
puts mountain_bike.parts.size
puts mountain_bike.spares.first
puts mountain_bike.spares.last
