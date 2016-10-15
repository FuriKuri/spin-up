# spin-up

## Usage
```
# Prepare DigitalOcean API access
$ export TF_VAR_do_token=...

# Prepare ssh access
$ export TF_VAR_ssh_fingerprint=...

# Run terraform apply
$ terraform apply -var 'names=name1,name2,name3'
```
