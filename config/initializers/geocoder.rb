Geocoder.configure(
  # We use Nominatim or Base Adresse Nationale FR based on country.
  # See app/models/actor/with_geolocation.rb for details.
  nominatim: {
    http_headers: { "User-Agent" => "communication@slowfest.org" }
  }
)