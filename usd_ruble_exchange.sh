#!/bin/sh
#rub to usd exchange rate
if [ -f /usr/local/bin/jq ]
then 
  curl -s "http://api.fixer.io/latest?base=USD&symbols=RUB" | jq '.rates.RUB'
else 
  curl -s "http://api.fixer.io/latest?base=USD&symbols=RUB" | grep -Eo '(\d+\.\d+)'
fi

