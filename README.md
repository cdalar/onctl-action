# onctl-action
github action for onctl preview environments


## Usage

```yaml
name: onctl-pr

on:
  pull_request:
    branches:
      - main
    types: [opened, reopened, synchronize, closed]

 
env:
  # Cloud Provider aws or hetzner
  CLOUD_PROVIDER: ${{ vars.CLOUD_PROVIDER }}
  # Hetzner Cloud Token
  HCLOUD_TOKEN: ${{ secrets.HCLOUD_TOKEN }}
  # AWS Credentials
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_DEFAULT_REGION: ${{ vars.AWS_REGION }}
  # Github Token with pull-request write permissions
  GH_TOKEN: ${{ github.token }}

jobs:
  preview-env:
    runs-on: ubuntu-latest

    permissions:
      contents: read
      packages: write
      pull-requests: write

    steps:
      - uses: actions/checkout@v3
      - name: up
        if: github.event.action != 'closed'
        uses: cdalar/onctl-action@v2
        env:
          ONCTL_LOG: DEBUG
        with:
          args: up
          SSH_PUBLIC_KEY: ${{ secrets.SSH_PUBLIC_KEY }}
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}

      - name: up
        if: github.event.action == 'closed'
        uses: cdalar/onctl-action@v2
        with:
          args: down self
```
