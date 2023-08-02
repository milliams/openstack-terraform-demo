Create an "Application credential" in OpenStack with the role "member" and download the `clouds.yaml` file into this directory.

Edit the `main.tf` to change the `key_pair` from `"my_key_pair_name"` to be the name of a key pair you have created in the OpenStack UI.

Optionally edit `main.tf` to change the `name` of your instance from `"my-tf-test"` to something of your choosing.

First run:

```
./terraform init
```

to initialize the Terraform working directory, and then

```
HTTPS_PROXY=socks5://localhost:3128 ./terraform apply
```

It will print out the IP address after applying.

You can then SSH in via the jump host with:

```
ssh -J dl-admin-jump.acrc.bris.ac.uk cloud-user@the.ip.address.from.above
```

If you have your SSH private key stored on the VDI, you can SSH directly from a VDI session to the instance floating IP without specifying a jump host

```
ssh cloud-user@the.ip.address.from.above
```