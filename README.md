## Boundary

### Commands

```bash
# set target ID
export TARGET_ID='ttcp_1HfVmYW8AD'
# login:
boundary authenticate password -addr 'https://kimtask.germanywestcentral.cloudapp.azure.com' -tls-insecure -scope-id=o_fm080vnehQ

# http proxy
boundary connect -target-id $TARGET_ID -addr 'https://kimtask.germanywestcentral.cloudapp.azure.com' -tls-insecure

# http request
boundary connect http -target-id $TARGET_ID -scheme https -addr 'https://kimtask.germanywestcentral.cloudapp.azure.com' -tls-insecure -- -k

#http proxy
boundary connect -target-id $TARGET_ID -scheme https -addr 'https://kimtask.germanywestcentral.cloudapp.azure.com' -tls-insecure -- -k
```
