#!/bin/bash

if [[ -z ${baseURL} || -z ${apiToken} ]]; then
    echo "Please set baseURL and apiToken environment variables."
    echo "Help available in the README: https://github.com/Alteiria/pterodactylAutoStart/blob/master/README.md"
    exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo 'jq is not installed.' >&2
  exit 1
fi

temp_headers=$(mktemp)

dataOfServers=$(curl -s "${baseURL}""/client" \
    -H "Authorization: Bearer $apiToken" \
    -H "Content-Type: application/json" \
    -D "${temp_headers}" \
-H "Accept: Application/vnd.pterodactyl.v1+json" | jq '.data')

read STATUS < <(
      echo $temp_headers |
      awk '/^HTTP/ { STATUS = $2 }
           END { printf("%s\n",STATUS) }'
    )

rm -f $temp_headers

if [[ $STATUS = 404 ]]; then
	echo "The baseURL is wrong and/or cannot be accessed."
	exit 1
elif [[ $STATUS = 403 ]]; then
	echo "Wrong token"
	exit 1
fi

numberOfServers=$(echo "${dataOfServers}" | jq length)

for (( i=0; i < "$numberOfServers"; i++ ))
do
    dataOfServer=$(echo "${dataOfServers}" | jq ".[$i]")
    description=$(echo "${dataOfServer}" | jq ".attributes.description" | jq -r)
	uuid=$(echo "$dataOfServer" | jq ".attributes.uuid" | jq -r)
	id=${uuid::8}
    if [[ $description == *"alwaysStart"* ]]; then
        curl -s "$baseURL""/client/servers/${id}/power" \
        -H "Authorization: Bearer $apiToken" \
        -H "Content-Type: application/json" \
        -H "Accept: Application/vnd.pterodactyl.v1+json" \
        -X POST \
        -d '{ "signal": "start" }'
    fi
done
