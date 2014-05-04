devbox
======

The scripted VM I use for development. Orchestrated with Vagrant, and
provisioned with Chef.

It exists as a public repository mainly to simplify my own access, but feel
free to grab any useful tidbits from here (or use it outright).

Setup
-----

- Download and install [Vagrant](https://www.vagrantup.com/downloads)
- If VirtualBox:
  - `vagrant up`
- If VMware Fusion:
  - `VAGRANT_DEFAULT_PROVIDER=vmware_fusion vagrant up`

