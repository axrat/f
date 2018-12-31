#!/bin/bash
herokupush(){
  git push heroku master
}
herokuremoteadd(){
  if [ $# -ne 1 ]; then
    echo "Require [app].herokuapp.com "
  else
    git remote add heroku https://git.heroku.com/$1.git
  fi
}
herokubuildpack(){
  if [ $# -ne 2 ]; then
    echo "Require [app] for buildpack heroku/[lang]"
  else
    heroku buildpacks:set heroku/$2 --app $1
    heroku addons:create heroku-postgresql:hobby-dev --app $1
  fi
}
herokupointdns(){
  if [ $# -ne 1 ]; then
    echo "Require [app].herokuapp.com "
  else
    heroku addons:add pointdns --app $1
  fi
}

