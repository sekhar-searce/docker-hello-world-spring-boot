Hello World sample shows how to deploy [SpringBoot](http://projects.spring.io/spring-boot/) RESTful web service application with [Docker](https://www.docker.com/)

#### Steps

##### Clone source code from git
```
$  git clone https://github.com/dstar55/docker-hello-world-spring-boot .
```

##### Build Docker image
```
$ docker build -t="hello-world-java" .
```

##### Run Docker Container
```
$ docker run -p 8080:8080 -it --rm hello-world-java
```

##### Test application

```
$ curl localhost:8080
```

the respone should be:
```
Hello World
```
