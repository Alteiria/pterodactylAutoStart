# Pterodactyl Auto Restart
[![Build Status](https://travis-ci.com/Alteiria/pterodactylAutoRestart.svg?branch=master)](https://travis-ci.com/Alteiria/pterodactylAutoRestart)

This bash script auto restart the servers in Pterodactyl that have `alwaysStart` in their description.

You need to set two environment variables to get this script working:
* `baseURL` : The URL of your Pterodactyl panel + `/api`. Example: `https://panel.minecraft.com/api`
* `apiToken` : The token generated from the Account API page.