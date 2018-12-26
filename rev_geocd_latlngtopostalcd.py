#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""latlng_to_postalcode

Usage:
    cat CSVFILE | ./rev_geocd_latlngtopostalcd.py

require enviroment valuable
    GMAPS_API_KEY
"""
import os
import sys
import csv
import googlemaps

gmaps = googlemaps.Client(key=os.environ['GMAPS_API_KEY'])

stream = map(lambda l: l.rstrip('\r\n').split(','), sys.stdin)
csvwriter = csv.writer(sys.stdout, delimiter=',')

for id, line in enumerate(stream):
    row_data = []
    lat = line[0]
    lng = line[1]

    row_data.append(lat)
    row_data.append(lng)

    results = reverse_geocode_result = gmaps.reverse_geocode((lat, lng), result_type='postal_code', language='ja')
    for result in results:
        postalcd = result['address_components'][0]['short_name']
        row_data.append(postalcd)
    
    csvwriter.writerow(row_data)