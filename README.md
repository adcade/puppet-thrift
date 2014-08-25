# thrift

[![Build Status](https://travis-ci.org/Spantree/puppet-thrift.svg?branch=master)](https://travis-ci.org/Spantree/puppet-thrift)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with thrift](#setup)
    * [What thrift affects](#what-thrift-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with thrift](#beginning-with-thrift)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The thrift module downloads, compiles and installs. The module has been tested on Centos and Ubuntu but it should work on RedHat, Amazon Linux and Debian 7.

## Module Description

This module installs thrift with java bindings, in order to do it, it will install openjdk 7 and ant from the apache ant website.

## Setup

### What thrift affects

* Install the thrift binary `/usr/local/bin/thrift`.
* Install openjdk7 and ant from the apache-ant website.

### Setup Requirements

None at the moment.

### Beginning with thrift

`include thrift` is enough to get you up and running. If you wish to pass in parameters specifying a specific version of thrift, then:
```puppet
class { 'thrift':
  version => '0.9.0'
}
```

##Usage

All interaction with the thrift module can be done through the main thrift class.

###I just want Thrift, what's the minimum I need?
```puppet
include thrift
```

###I want a specific version of thrift
```puppet
class { 'thrift':
  version => '0.9.0',
}
```

###I want to specify a different download source because I am behind a firewall
```puppet
class { 'thrift':
  base_url => 'http://myinternalhost/thrift'
}
```

##Reference

###Classes

####Public Classes

* thrift: Main class

###Parameters

The following parameters are available in the thrift module:

####`version`

Specify the version of thrift to use, at the moment defaults to 0.9.1

####`base_url`

Sets the base url for the download location

###Facts

####`thrift_version`

Set to the thrift version that is installed.

####`thrift_path`

Set to the path of the thrift binary

##Limitations

This module has been built on and tested against Puppet 3.2 and higher.

The module has been tested on:

* CentOS 6
* Ubuntu 14.04

Testing on other platforms has been light and cannot be guaranteed.

## Development

## Release Notes/Contributors/Etc
