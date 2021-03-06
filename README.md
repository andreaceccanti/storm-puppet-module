# StoRM puppet module

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Limitations - OS compatibility](#limitations)

## Description

StoRM Puppet module can be used to configure StoRM services.
At the moment, the supported services are:

- storm-webdav
- storm-globus-gridftp

## Setup

Build module as follow:

```
cd storm
puppet module build
```

Then, install:

```
puppet module install ./pkg/mwdevel-storm-0.1.0.tar.gz
```

## Usage

Check [this](storm/examples/init.pp) example and refer to
[REFERENCE](storm/REFERENCE.md) or [documentation](storm/doc/) folder 
to get all the class parameters.

## Limitations

It works only on RedHat distributions.
