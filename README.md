# generator-aws-docker-microservice

## Installation

```
$ git clone https://github.com/marioharper/generator-aws-docker-microservice.git
$ cd generator-aws-docker-microservice
$ npm link
```


## Usage

### Create project

With [Yeoman](http://yeoman.io/).

```
$ mkdir my-microservice
$ cd my-microservice
$ yo aws-docker-microservice my-microservice-name
```

### Deploy infrastructure
```
$ ./build/deploy.sh
```
### Deploy app
```
$ eb init "<app_name>" -r $AWS_DEFAULT_REGION -p "Docker 1.11.2"
$ eb deploy
```
