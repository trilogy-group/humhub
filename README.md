HumHub - Social Network Kit
===========================

[![Build Status](https://travis-ci.org/humhub/humhub.svg?branch=master)](https://travis-ci.org/humhub/humhub)
[![Yii2](https://img.shields.io/badge/Powered_by-Yii_Framework-green.svg?style=flat)](http://www.yiiframework.com/)

HumHub is a feature rich and highly flexible OpenSource Social Network Kit written in PHP.

It's perfect for individual:
- Social Intranets
- Enterprise Social Networks
- Private Social Networks

More information:
- [Homepage & Demo](http://www.humhub.org)
- [Documentation & Class Reference](http://docs.humhub.org)
- [Community](http://community.humhub.com/)
- [Licence](http://www.humhub.org/licences)

### Running locally using Docker

In case you want to run the product locally on a fast and simple way, we have configured simple docker-compose ecosystem that lets you build and run the different HumHub components.

In order to simplify the running process we are providing a docker-cli bash shell that helps you configure your local environment, this script asumes you have installed docker on your local machine, in case you haven't please follow the guide for your OS found at https://docs.docker.com/install/

When we run our cli we are given the following options, first we need to build our ecosystem, then we can run it; once its running we need to head to http://yourDockerHost and we'll be able to start the HubmHub setup


`./docker-cli`<br/>
`---------------------------------------------------------------------------`<br/>

`Build container: `
`  docker-cli build`

`Start container: `
`  docker-cli start`

`Stop container: `
`  docker-cli stop`

`Connect to server container: `
`  docker-cli exec`

#### The images

In order to enable the development environment we have 2 images defined as part of our docker-compose.yml, this images helps us fullfill the dependencies defined on http://docs.humhub.org/beta/admin-requirements.html 

First we have the server side, defined on Dockerfile; this image is based on official php image, and has composer and all the dependencies needed by HumHub ro run, then we have a standard MySQl 5 image to hold the data for our instance.

#### HumHub setup

Once we start the setup, the web wizard will ask about the dabatase information, so you'll need to provide the following values:

DBHost: db
DBUser: humhub_dbuser
DBPassword: humhub_dbpass
DBName: humhub

Once the setup is finished, you'll have a local HumHub instance up and running


