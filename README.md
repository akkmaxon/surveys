# README

Services:
* update export.csv file by cron
* RAILS_ENV=production current/bin/delayed_job start for complete previous step

Deployment:
* eval `ssh-agent -s` && ssh-add
* cap production deploy
* passenger-config restart-app(on server)
