json.array!(@beers) do |beer|
  json.extract! beer, :id, :name, :description, :style, :abv, :ibu, :brewery, :location
  json.url beer_url(beer, format: :json)
end
