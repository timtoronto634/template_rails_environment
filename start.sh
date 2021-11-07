[WIP]

docker-compose run --no-deps web rails new . --force --database=postgresql

if [ $(cat /proc/version | grep Linux | wc -l) -eq 0 ]; then
  sudo chown -R $USER:$USER .
fi

docker-compose build

vim config/database.yml

docker-compose up -d
docker-compose run web rake db:create
