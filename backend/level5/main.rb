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

  def travel
    time = rental * @price_per_day
    fare = @distance * @price_per_km
    total = time + fare
    return total
  end

  def dynamic
    if @end_date >= @start_date.next_day(1)
      variable_pricing =  travel - (travel * 0.10)
    elsif @end_date >= @start_date.next_day(4)
      variable_pricing = travel - ( travel * 0.3)
    elsif @end_date >= @start_date.next_day(10)
      variable_pricing = travel - ( travel * 0.5)
    else
      variable_pricing = travel
    end
    return variable_pricing
  end

  def insurance_fee
    fee = (dynamic * 1/3) / 2
    return fee
  end

  def fee
    days = @start_date - @end_date
    if days == 0
      days = 100
    elsif days == 1
      days = 100 * 2
    else
     days = days * 100
    end
    ass_fee = insurance_fee - roadside
    return ass_fee
  end

  def roadside
    days = @start_date - @end_date
    roadside = rental * 100
    return roadside
  end

  def options
    days = @start_date - @end_date
    gps = 5 + day
    baby_seat = 2 + day
    add_insurance = 10 + day
  end
  def home
    file = File.read('./data/input.json')
    data = JSON.parse(file)
    demo1 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][0]['distance'], Date.parse(data['rentals'][0]['start_date']), Date.parse(data['rentals'][0]['end_date']))
    demo2 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][1]['distance'], Date.parse(data['rentals'][1]['start_date']), Date.parse(data['rentals'][1]['end_date']))
    demo3 = Car.new(data['cars'][0]['price_per_day'],data['cars'][0]['price_per_km'],data['rentals'][2]['distance'], Date.parse(data['rentals'][2]['start_date']), Date.parse(data['rentals'][2]['end_date']))
    tempHash = {
        "rentals": [
          {
            "id": 1,
            "actions": [
              {
                "who": "driver",
                "type": "debit",
                "amount": demo1.dynamic
              },
              {
                "who": "owner",
                "type": "credit",
                "amount": demo1.dynamic - (demo1.insurance_fee - demo1.fee)
              },
              {
                "who": "insurance",
                "type": "credit",
                "amount": demo1.insurance_fee
              },
              {
                "who": "assistance",
                "type": "credit",
                "amount": demo1.roadside
              },
              {
                "who": "drivy",
                "type": "credit",
                "amount": demo1.fee
              }
            ]
          },
           {
            "id": 2,
            "actions": [
              {
                "who": "driver",
                "type": "debit",
                "amount": demo2.dynamic
              },
              {
                "who": "owner",
                "type": "credit",
                "amount": demo2.dynamic - (demo2.insurance_fee - demo2.fee)
              },
              {
                "who": "insurance",
                "type": "credit",
                "amount": demo2.insurance_fee
              },
              {
                "who": "assistance",
                "type": "credit",
                "amount": demo2.roadside
              },
              {
                "who": "drivy",
                "type": "credit",
                "amount": demo2.fee
              }
            ]
          },
          {
            "id": 3,
            "actions": [
              {
                "who": "driver",
                "type": "debit",
                "amount": demo3.dynamic
              },
              {
                "who": "owner",
                "type": "credit",
                "amount": demo3.dynamic - (demo3.insurance_fee - demo3.fee)
              },
              {
                "who": "insurance",
                "type": "credit",
                "amount": demo3.insurance_fee
              },
              {
                "who": "assistance",
                "type": "credit",
                "amount": demo3.roadside
              },
              {
                "who": "drivy",
                "type": "credit",
                "amount": demo3.fee
              }
            ]
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
