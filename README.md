### Consul

```shell
cd consul
# Export CONSUL_LICENSE_PATH for Enterprise builds
VERSION=1.13.1 docker compose up --build --force-recreate
```

### Nomad

Note: initial leader is not deterministic as Nomad only supports bootstrap_expect

```shell
cd nomad
# Export NOMAD_LICENSE_PATH for Enterprise builds
VERSION=1.3.5 docker compose up --build --force-recreate
```

### Vault

```shell
cd vault
# Export VAULT_LICENSE_PATH for Enterprise builds
VERSION=1.11.3+ent docker compose up --build --force-recreate
```
