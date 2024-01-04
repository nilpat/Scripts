import boto3
import datetime
import time

# Secure AWS credentials (using IAM roles or environment variables)
try:
    session = boto3.Session()
    ec2 = session.resource('ec2')
except Exception as e:
    print("Error establishing AWS connection:", e)
    exit(1)

# Define stopping and starting times for weekdays
weekday_stop_time = datetime.datetime.strptime("20:00", "%H:%M").time()  # Adjust as needed
weekday_start_time = datetime.datetime.strptime("08:00", "%H:%M").time()  # Adjust as needed

def manage_instances(current_time):
    today = datetime.date.today()

    if today.weekday() < 5:  # Weekdays only
        if current_time >= weekday_stop_time:
            stop_or_start_instances('stop')
        elif current_time >= weekday_start_time:
            stop_or_start_instances('start')

# Continuous loop with weekday-only logic
while True:
    current_time = datetime.datetime.now().time()
    manage_instances(current_time)
    time.sleep(60)
