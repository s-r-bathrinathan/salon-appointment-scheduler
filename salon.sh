#!/bin/bash

#salon appointment scheduler

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"


GET_SERVICE(){
  while IFS="|" read SERVICE_ID SERVICE
  do
    echo "$SERVICE_ID) $SERVICE"
  done <<< "$($PSQL "SELECT * FROM services;")"

  echo -e "\nEnter a service_id:"
  read SERVICE_ID_SELECTED
}

echo Services
GET_SERVICE

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
while [[ -z $SERVICE_NAME ]]
do
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  if [[ -z $SERVICE_NAME  ]]
  then
    GET_SERVICE
  fi
done

echo -e "\nEnter your phone number:"
read CUSTOMER_PHONE

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")

if [[ -z $CUSTOMER_ID ]]
then
  echo -e "\nIt seems you are a new customer. Welcome!"
  echo -e "\nEnter your name:"
  read CUSTOMER_NAME
  INSERT_CUSTOMER_DATA_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME';")
else
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID;")
  echo -e "\nWelcome Back! $CUSTOMER_NAME"
fi

echo -e "\nEnter the time for your appointment:"
read SERVICE_TIME

CREATE_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."