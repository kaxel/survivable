json.extract! animal, :id, :name, :type, :meat, :difficulty, :created_at, :updated_at
json.url animal_url(animal, format: :json)
