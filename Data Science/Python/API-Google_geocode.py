
import urllib.request as ur
import urllib.parse as up
import json
import pprint

serviceurl = 'http://maps.googlemaps.com/maps/api/geocode/xml?
# This API uses the parameters (sensor and address) .
# If you visit the URL with no parameters, you get a list of all of the address values which can be used with this API.
address_input = input("Enter location: ")
params = {"sensor": "false", "address": address_input}
url = serviceurl + up.urlencode(params)
print("Retrieving ", url)
data = ur.urlopen(url).read().decode('utf-8')
print('Retrieved', len(data), 'characters')
json_obj = json.loads(data)
place_id = json_obj["results"][0]["place_id"]
print("Place id", place_id)
# Sample Execution
# $ python solution.py
# Enter location: South Federal University
# Retrieving http://...
# Retrieved 2101 characters
# Place id ChIJJ8oO7_B_bIcR2AlhC8nKlok
