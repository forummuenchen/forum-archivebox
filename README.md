# Archivebox for Forum Queeres Archiv München

[Archivebox](https://archivebox.io/) is a software to archive websites in multiple formats. 
The queer archive in Munich we use it to send snapshots of websites important to queer history or the current queer movement to the Internet Archive. 
The goal is to preserve them for future research.

## Archivebox setup and goodtoknow

### Installation

```
sudo apt-get update
sudo apt-get upgrade

mkdir archivebox && cd archivebox
curl -O 'https://raw.githubusercontent.com/forummuenchen/forum-archivebox/main/docker-compose.yml'

# change permissions
sudo chown -R $USER ./archivebox/
sudo chown -R :$USER ./archivebox/

# make crontabs writable
sudo mkdir -p ./etc/crontabs; chmod -R 777 ./etc/crontabs

# setup
docker-compose run archivebox init --setup

```

### Start web application

```
docker-compose up
```

### Add scheduled tasks

following: https://github.com/ArchiveBox/ArchiveBox/issues/1155#issuecomment-1590146616

```
# add cron task
docker-compose run archivebox schedule --every=hour 'https://letra.de'

# add cron task with url list
curl -O 'https://raw.githubusercontent.com/forummuenchen/forum-archivebox/main/data/urls_test.txt'
docker-compose run archivebox schedule --every=hour urls_test.txt

# restart the scheduler container to pick up the new scheduled job 
docker-compose restart archivebox_scheduler

# check logs
docker-compose logs archivebox_scheduler
```


### Update docker-compose.yml

https://github.com/ArchiveBox/ArchiveBox/wiki/Upgrading-or-Merging-Archives#upgrading-with-docker-compose-%EF%B8%8F

```
cd ~/archivebox        # or wherever your data folder is
docker-compose down    # stop the currently running archivebox containers
docker-compose down    # run twice to clear stopped containers
curl -O 'https://raw.githubusercontent.com/forummuenchen/forum-archivebox/main/docker-compose.yml'
docker-compose up      # collection will be automatically upgraded as it starts
```

## Websites

The websites are fetched from Wikidata: Get all official websites from LGBT associations and LGBT bars.

* [Wikidata Query Service](https://query.wikidata.org/#SELECT%20DISTINCT%20%3Fitem%20%3FitemLabel%20%3FitemDescription%20%3Furl%20WHERE%20%7B%0A%20%20%7B%20%3Fitem%20%28wdt%3AP31%2F%28wdt%3AP279%2a%29%29%20wd%3AQ64606659.%20%7D%0A%20%20UNION%0A%20%20%7B%20%3Fitem%20%28wdt%3AP31%2F%28wdt%3AP279%2a%29%29%20wd%3AQ61710689.%20%7D%0A%20%20%20%20UNION%0A%20%20%7B%20%3Fitem%20%28wdt%3AP31%2F%28wdt%3AP279%2a%29%29%20wd%3AQ105321449.%20%7D%0A%20%20%3Fitem%20wdt%3AP856%20%3Furl%0A%20%20SERVICE%20wikibase%3Alabel%20%7B%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%22.%20%7D%0A%7D%0AORDER%20BY%20%28%3FitemLabel%29)