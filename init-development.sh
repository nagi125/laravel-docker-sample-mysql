#!/bin/bash
set -e

COLOR="\e[1;32m"
COLOR_END="\e[00m"

printf "$COLOR:: Build Start ...$COLOR_END\n"
docker-compose build

printf "$COLOR:: Starting Laravel ...$COLOR_END\n"
docker-compose up -d

printf "$COLOR:: Composer install ...$COLOR_END\n"
docker-compose exec app composer install

printf "$COLOR:: npm install ...$COLOR_END\n"
docker-compose exec app npm install

printf "$COLOR:: build static files ...$COLOR_END\n"
docker-compose exec app npm run dev

printf "$COLOR:: generating app-key ...$COLOR_END\n"
docker-compose exec app php artisan key:generate

printf "$COLOR:: init success!! $COLOR_END\n"
docker-compose logs -f --tail='100' -t

