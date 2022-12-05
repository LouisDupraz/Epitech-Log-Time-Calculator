#!/usr/bin/env python3
from sys import argv


start = int(argv[1])
stop = int(argv[2])

secs = stop-start

print(secs)

seconds=(secs)%60

seconds = round(int(seconds), 2)

minutes=(secs//60)%60

minutes = round(int(minutes), 2)

hours= round(( (secs//(60*60))%24 ), 2)

print(f"Hours:{hours}, Minutes:{minutes}, Seconds:{seconds}")
