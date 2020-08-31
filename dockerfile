# Make new directory for file
mkdir ~/myimages
cd myimages/
touch Dockerfile
# open file with VIM
vim Dockerfile
#Загрузить базовый образ Ubuntu 18.04
FROM ubuntu:18.04
#Обновить программный репозиторий Ubuntu
RUN apt-get update
