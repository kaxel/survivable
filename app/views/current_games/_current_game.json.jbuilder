json.extract! current_game, :id, :sig, :ip, :created_at, :updated_at
json.url current_game_url(current_game, format: :json)
