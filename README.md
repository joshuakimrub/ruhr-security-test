## Hardening Results

### Obsolete Services

| RuleID                                                   | Status | Comment                                                                     |
|----------------------------------------------------------|--------|-----------------------------------------------------------------------------|
| xccdf_org.ssgproject.content_rule_package_rsync_removed  | Error  | Automated evaluation failed. Manual evaluation states a successful exection |
| xccdf_org.ssgproject.content_rule_package_telnet_removed | Error  | Automated evaluation failed. Manual evaluation states a successful exection |


### System Settings

| RuleID                                                                | Status      | Comment                                      |
|-----------------------------------------------------------------------|-------------|----------------------------------------------|
| xccdf_org.ssgproject.content_rule_grub2_password                      | Fail        | Rule has to be executed manually.            |
| xccdf_org.ssgproject.content_rule_partition_for_tmp                   | Fail        | Report doesn't indicate why the rule failed. |
| xccdf_org.ssgproject.content_rule_nftables_ensure_default_deny_policy | Not Checked | Cannot be performed during packer build.     |
| xccdf_org.ssgproject.content_rule_set_nftables_base_chain             | Not Checked | Cannot be performed during packer build.     |
| xccdf_org.ssgproject.content_rule_set_nftables_loopback_traffic       | Not Checked | Cannot be performed during packer build.     |
| xccdf_org.ssgproject.content_rule_set_nftables_table                  | Not Checked | Cannot be performed during packer build.     |


### Risks