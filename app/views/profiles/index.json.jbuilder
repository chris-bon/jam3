json.array! @profiles do |profile|
  json.id profile.id
  json.name profile.name
  json.age profile.age
  json.gender profile.gender
  json.instruments profile.instruments
  json.location profile.location.city
  json.phone_number profile.phone_number
  json.genre profile.genre
  json.availability profile.availability
  json.hide profile.hide
  json.image_url profile.image_url
end