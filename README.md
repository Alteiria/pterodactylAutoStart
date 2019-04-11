# Pterodactyl Auto Start
[![Build Status](https://travis-ci.com/Alteiria/pterodactylAutoStart.svg?branch=master)](https://travis-ci.com/Alteiria/pterodactylAutoStart)

## Description

This bash script auto start (at boot for example) the servers in Pterodactyl that have `alwaysStart` in their description.

## Requirements

* You need to set two environment variables:
  * `baseURL` : The URL of your Pterodactyl panel + `/api`. Example: `https://panel.minecraft.com/api`
  * `apiToken` : The token generated from the Account API page.
* And having jq >1.6 installed: https://github.com/stedolan/jq/releases