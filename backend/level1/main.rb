require 'json'
require 'date'

class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id, price_per_day, price_per_km)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end
end

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  def price
    (duration * car.price_per_day) + (distance * car.price_per_km)
  end
end

class RentalService
  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
  end

  def process_rentals
    input_data = load_input_data
    cars = build_cars(input_data['cars'])
    rentals = build_rentals(input_data['rentals'], cars)
    output_data = calculate_output(rentals)

    save_output_data(output_data)
  end

  private

  def load_input_data
    json_content = File.read(@input_file)
    JSON.parse(json_content)
  end

  def build_cars(cars_data)
    cars_data.map { |car_data| Car.new(car_data['id'], car_data['price_per_day'], car_data['price_per_km']) }
  end

  def build_rentals(rentals_data, cars)
    rentals_data.map do |rental_data|
      car = cars.find { |car| car.id == rental_data['car_id'] }
      Rental.new(rental_data['id'], car, rental_data['start_date'], rental_data['end_date'], rental_data['distance'])
    end
  end

  def calculate_output(rentals)
    { rentals: rentals.map { |rental| { id: rental.id, price: rental.price } } }
  end

  def save_output_data(output_data)
    File.write(@output_file, JSON.pretty_generate(output_data))
  end
end

input_file = './data/input.json'
output_file = './data/expected_output.json'

rental_service = RentalService.new(input_file, output_file)
rental_service.process_rentals