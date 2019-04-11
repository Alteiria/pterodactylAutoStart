# Pterodactyl Auto Start
[![Build Status](https://travis-ci.com/Alteiria/pterodactylAutoStart.svg?branch=master)](https://travis-ci.com/Alteiria/pterodactylAutoStart)

This bash script auto start (at boot for example) the servers in Pterodactyl that have `alwaysStart` in their description.

You need to set two environment variables to get this script working:
* `baseURL` : The URL of your Pterodactyl panel + `/api`. Example: `https://panel.minecraft.com/api`
* `apiToken` : The token generated from the Account API page.