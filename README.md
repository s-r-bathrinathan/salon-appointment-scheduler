# Salon Appointment Scheduler

## Description
The Salon Appointment Scheduler is a Bash script that allows users to book appointments for various services at a salon. 
It manages customers, services, and appointments using a PostgreSQL database.

## Features
- List of available services displayed.
- Validates user input to ensure a valid service is selected.
- Checks if a customer exists based on their phone number; if not, prompts for their name and adds them to the database.
- Stores appointment details, including service, customer, and time.
- Confirms the scheduled appointment with a message.
