json.array! @profiles do |profile|
  json.profile profile
  json.user profile.user
end
# json.array! @profiles.each do |profile|
#   json.id profile.id
#   json.user profile.user
#   json.name profile.name
#   json.age profile.age
#   json.phone_number profile.phone_number
#   json.location profile.location
#   json.instruments profile.instruments
#   json.genre profile.genre
#   json.availability profile.availability
# end