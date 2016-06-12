json.array! @profiles do |profile|
  json.user profile.user
  json.profile profile
end