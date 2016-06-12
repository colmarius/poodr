class Vehicle
end

class Trip
  attr_reader :name, :bicycles, :customers, :vehicle

  def initialize(opts = {})
    @name = opts.fetch(:name, 'Demo Trip')
    @bicycles = opts.fetch(:bicycles, [])
    @customers = opts.fetch(:customers, [])
    @vehicle = opts.fetch(:vehicle, Vehicle.new)
  end

  def prepare(preparers)
    puts "Trip: prepare for #{ name }"
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
end

class Mechanic
  def prepare_trip(trip)
    puts "Mechanic: prepare bicycles for trip"
    trip.bicycles.each do |bicycle|
      prepare_bicycle(bicycle)
    end
  end

  def prepare_bicycle(_bicycle)
  end
end

class TripCoordinator
  def prepare_trip(trip)
    puts "Trip Coordinator: buy food for customers"
    buy_food(trip.customers)
  end

  def buy_food(_customers)
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_wather_tank(vehicle)
  end

  def gas_up(_vehicle)
    puts "Driver: gas up vehicle"
  end

  def fill_wather_tank(_vehicle)
    puts "Driver: fill wather tank for vehicle"
  end
end

preparers = [
  Mechanic.new,
  TripCoordinator.new,
  Driver.new
]

Trip.new(name: 'North Pole')
  .prepare(preparers)
