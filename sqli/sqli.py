#!/usr/bin/env python3

import requests

target = 'http://127.0.0.1/login.php' # Your target page here
headers = {'Host': '127.0.0.1', # Your POST headers here
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q-0.5',
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': '38',
        'Origin': 'http://127.0.0.1',
        'Connection': 'keep-alive',
        'Referer': 'http://127.0.0.1/login.php',
        'Cookie': 'security_level-8; PHPSESSID=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
        'Upgrade-Insecure-Requests': '1'
     }

with open ('payload.txt','r') as text: # Payload file 
    payloads = text.readlines()
    
# try payload file
for item in payloads:
    payload = item.strip('\n')
    data = {'login': payload,
            'password':'pass',
            'form':'submit'
            }
    
    post = requests.post(target, data=data, headers=headers) # POST shouldn't contains
    if 'Invalid credentials!' not in post.text and 'Error: ' not in post.text:
        print(f'[+] Possible SQLi found: {payload}')
 
