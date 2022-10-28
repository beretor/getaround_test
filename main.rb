require 'json'
require 'date'

  $raw_input = File.read "data/input.json"
  $rental_input = JSON.parse($raw_input)
  $cars = $rental_input['cars']
  $rentals = $rental_input['rentals']

  def price_duration(id, car_id)
    duration = (DateTime.parse($rentals[id]["end_date"]) - DateTime.parse($rentals[id]["start_date"])+1).to_i
    price_per_day = $cars[car_id]["price_per_day"]
    price_duration = duration * price_per_day
  end

  def price_mileage(id, car_id)
    distance = $rentals[id]["distance"]
    price_per_km = $cars[car_id]["price_per_km"]
    price_mileage = (distance * price_per_km).to_i
  end

  def price_rental(id, car_id)
    price_rental = price_duration(id, car_id) + price_mileage(id, car_id)
  end

#p price_rental(0, 0)
#p price_rental(1, 0)
#p price_rental(2, 1)
#$rentals.each {|i| p i["id"],i["car_id"]}

expected_output= {
  "rentals:" => [
    $rentals.each {|i| 
      {"id:" => i["id"], "price:" => price_rental(i["id"], i["car_id"])}
    }
  ]
}
p expected_output

File.open("data/expected_output.json","w") do |f|
  f.write(JSON.pretty_generate(expected_output))
end

