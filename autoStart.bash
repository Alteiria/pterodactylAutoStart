#!/bin/bash

if [[ -z ${baseURL} || -z ${apiToken} ]]; then
    echo "Please set baseURL+/api to your Pterodactyl panel URL. Example: https://panel.minecraft.com/api."
    echo "Please set the API Token according to Account API page."
    exit 1
fi

dataOfServers=$(curl -s "${baseURL}""/client" \
    -H "Authorization: Bearer $apiToken" \
    -H "Content-Type: application/json" \
-H "Accept: Application/vnd.pterodactyl.v1+json" | jq '.data')

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