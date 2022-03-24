require 'json'
require 'date'
class Car
  def initialize(price_per_day, price_per_km, distance, start_date, end_date)
    @price_per_day = price_per_day
    @price_per_km = price_per_km
    @distance = distance
    @start_date = start_date
    @end_date = end_date
  end

  def rental
    rentaldays = @start_date - @end_date
    return rentaldays
  end

  def travel
    total = (rental * @price_per_day) + (@distance * @price_per_km)
    return total
  end

  def home
    file = File.read('./data/input.json')
    data = JSON.parse(file)
    demo1 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][0]['distance'], Date.parse(data['rentals'][0]['start_date']), Date.parse(data['rentals'][0]['end_date']))
    print demo1
    tempHash = {
        "rentals": [
          {"id" => 1,
          "price" => demo1.travel },
          {"id" => 2,
          "price" => demo1.travel},
          {"id" => 3,
          "price" => demo1.travel}
        ]
      }
    File.open("./data/expected_output.json" , "w") do |f|
      f.write(JSON.pretty_generate(tempHash))
    end
    jsonified = JSON.generate(tempHash)
    puts jsonified
  end
a = Car.new(1,1,1,1,1)
puts a.home
end
