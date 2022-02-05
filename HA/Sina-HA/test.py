import requests
import json
from time import sleep

api_url_1 = "http://192.168.2.2:8000"
api_url_2 = "http://192.168.2.3:8000"

master_count_1 = 0
slave_count_1 = 0
master_count_2 = 0
slave_count_2 = 0
error_count_1 = 0
error_count_2 = 0

iter_1 = 1000
iter_2 = 1000
wait_1 = 0.01
wait_2 = 0.01

max_time_1 = 0
max_time_2 = 0

for i in range(iter_1):
    try:
        resp = requests.get(url=api_url_1)
    except:
        error_count_1 += 1
        continue
    if "slave" in resp.json()['message']:
        # print("ERROR: Server switched!")
        slave_count_1 += 1
    elif "master" in resp.json()['message']:
        master_count_1 += 1
    else:
        error_count_1 += 1
    if resp.elapsed.total_seconds() > max_time_1:
        max_time_1 = resp.elapsed.total_seconds()
    sleep(wait_1)

for i in range(iter_2):
    try:
        resp = requests.get(url=api_url_2)
    except:
        error_count_2 += 1
        continue
    if "slave" in resp.json()['message']:
        # print("ERROR: Server switched!")
        slave_count_2 += 1
    elif "master" in resp.json()['message']:
        master_count_2 += 1
    else:
        error_count_2 += 1
    if resp.elapsed.total_seconds() > max_time_2:
        max_time_2 = resp.elapsed.total_seconds()
    sleep(wait_2)

print("############ Result ############")
print("####### VIP: 192.168.2.2 #######")
print(" - Total requets: ", iter_1)
print(" - Wait time b/w requests: ", wait_1, " seconds")
print(" - Master responses: ", master_count_1)
print(" - Slave responses: ", slave_count_1)
print(" - Errors: ", error_count_1)
print(" - Maximum response time: ", max_time_1, " seconds")
print("####### VIP: 192.168.2.3 #######")
print(" - Total requets: ", iter_2)
print(" - Wait time b/w requests: ", wait_2, " seconds")
print(" - Master responses: ", master_count_2)
print(" - Slave responses: ", slave_count_2)
print(" - Errors: ", error_count_2)
print(" - Maximum response time: ", max_time_2, " seconds")
