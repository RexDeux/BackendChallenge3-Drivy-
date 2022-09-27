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
    days = (@end_date - @start_date).to_i
    if days == 0
      days = 1
    elsif days == 1
      days = 2
    else
      days = days
    end
    return days
  end

  def discount_rate
    rate = 1
    case rate
    when rental > 1
      rate = 0.1
    when rental > 4
      rate = 0.3
    when rental > 10
      rate = 0.5
    else
      rate
    end
    return rate
  end

  def discount
    if rental > 1
      discount = (discount_rate * @price_per_day)
    elsif rental > 4
      discount = (discount_rate * @price_per_day)
    elsif rental > 10
      discount = (discount_rate * @price_per_day)
    else
      discount = @price_per_day
    end
    return discount
  end

   def travel
    time = rental * discount
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
