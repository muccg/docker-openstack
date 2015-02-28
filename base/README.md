The CCG Openstack base image
===========================

The base Openstack image that all other service containers are based on.
This image must be available in the local registry.

Pupulate local registry manually with the muccg/osbase tag:

```
$ docker build --tag=muccg/osbase .
```
