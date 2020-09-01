# Docker project
## Этапы проекта
### Поиск и загрузка базового образа Ubuntu 18.04
docker search ubuntu-18.04
docker pull dokken/ubuntu-18.04

## Команды сборки и запуска Docker-образа в интерактивном режиме
docker build -t mrog:latest .   
docker run -it mrog bash
