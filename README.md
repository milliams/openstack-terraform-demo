Create an "Application credential" in OpenStack with the role "member" and download the `clouds.yaml` file into this directory.

Edit the `main.tf` to change the `key_pair` to be the name of a key pair you have created in the OpenStack UI.

Then run:

```
HTTPS_PROXY=socks5://localhost:3128 ./terraform apply
```

It will print out the IP address after applying.

You can then SSH in with:

```
ssh -J dl-admin-jump.acrc.bris.ac.uk cloud-user@the.ip.address.from.above
```
