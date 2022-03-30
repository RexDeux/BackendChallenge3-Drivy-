require 'json'
require 'date'
class Car
  #initiliaze method with the constants needed for each case. Used the relevant ones needed by following the JSON file
  def initialize(price_per_day, price_per_km, distance, start_date, end_date)
    @price_per_day = price_per_day
    @price_per_km = price_per_km
    @distance = distance
    @start_date = start_date
    @end_date = end_date
  end

  def rental
    #days method using count so the 1st and last day are counted as well
    days = (@start_date.mjd..@end_date.mjd).count
    return days
  end

  def discount
    #if statement for the discount rate
    if rental <= 1
      discount = 0
    elsif rental > 1 && rental <=
      discount = (@price_per_day * 0.1)
    elsif rental >= 4 && rental <= 10
      discount = (@price_per_day * 0.3)
    elsif rental >= 10
      discount = (@price_per_day * 0.5)
    end
    return discount
  end

  def travel
    @price_per_day = (@price_per_day - discount)
    time = rental * @price_per_day
    fare = @distance * @price_per_km
    total = time + fare
    return total
  end

  def home
    file = File.read('./data/input.json')
    data = JSON.parse(file)
    demo1 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][0]['distance'], Date.parse(data['rentals'][0]['start_date']), Date.parse(data['rentals'][0]['end_date']))
    demo2 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][1]['distance'], Date.parse(data['rentals'][1]['start_date']), Date.parse(data['rentals'][1]['end_date']))
    demo3 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][2]['distance'], Date.parse(data['rentals'][2]['start_date']), Date.parse(data['rentals'][2]['end_date']))
    print demo1
    tempHash = {
        "rentals": [
          {"id" => 1,
          "price" => demo1.travel,
          "days" => demo1.rental
        },
          {"id" => 2,
          "price" => demo2.travel,
          "days" => demo2.rental
        },
          {"id" => 3,
          "price" => demo3.travel,
          "days" => demo3.rental
        }
        ]
      }
    File.open("./data/output.json" , "w") do |f|
      f.write(JSON.pretty_generate(tempHash))
    end
    jsonified = JSON.generate(tempHash)
    puts jsonified
  end
a = Car.new(1,1,1,1,1)
print a.home
end
