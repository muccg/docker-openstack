The CCG Openstack base image
============================

The base Openstack image that all other service containers are based on.

<<<<<<< HEAD
Populate local registry manually with the muccg/openstackbase:juno tag:

```
$ docker build -t muccg/openstackbase:juno .
=======
Populate local registry manually with the muccg/openstackbase tag:

```
$ docker build --tag=muccg/openstackbase:icehouse .
>>>>>>> icehouse
```
