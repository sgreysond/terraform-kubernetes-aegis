# Contributing

## Local validation

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate

tflint --init
tflint
```

## CI contract

PRs must pass:
- formatting
- terraform validation
- tflint
- example init/validate checks
