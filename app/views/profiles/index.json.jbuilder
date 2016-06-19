json.array! @profiles do |profile|
  json.id profile.id
  json.name profile.name
  json.age profile.age
  json.gender profile.gender
  json.location profile.location
  json.phone_number profile.phone_number
  json.genre profile.genre
  json.availability profile.availability
  json.email profile.user.email
end