### 10/10/24 - Commands for Docker:

- Create docker image:
```
docker build -t <image_name_here> .
```
Ex: docker build -t client-app-test4000

- Run docker container:
```
docker run -p <port#>:<port#_from_dockerfile> <image_name>
```
Ex: docker run -p 8080:80 client-app-test4000
