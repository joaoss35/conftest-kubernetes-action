# conftest-kubernetes-action

## About

A Github action that uses [Conftest](https://www.conftest.dev/) as tool to run tests against your configuration data through [OPA](https://www.openpolicyagent.org/) policies.

## Introduction

[Conftest](https://www.conftest.dev/) is a utility tool that helps developers write tests against structured configuration data. As such, Conftest allows you to write tests against [Kubernetes](https://kubernetes.io/) configurations, [Terraform](https://www.terraform.io/) code, Serverless configs or any other structured data by taking advantage of [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/): a structured document language provided by [OPA](https://www.openpolicyagent.org/).

## Inputs

| Option | Description | Default | Required |
| :-: | --- | :-: | :-: |
| combine |  Combines files into one input data structure | `false` | No |
| token | The [github private access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) to perform pull requests authenthication | n/a | No |
| namespace | The namespace which to search for rules | `main` | No |
| output | The output format used by Conftest for displaying the results | `stdout` | No |
| parser | Force a specific file parser type | `yaml` | No |
| file | The path for the files that Conftest will test | `.` | **Yes** |
| policy | The path where Conftest will look for the rego policies | `policy` | No |
| comment | Perform a pull-request comment with the tests output | n/a | No |
| trace | Make conftest output more verbose during tests | `false` | No |
| update | A list of remote policies that will be downloaded before the tests run | n/a | No |

## Usage

### Default

Minimal action usage.
```yaml
name: conftest
on: [pull_request]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: conftest
        uses: joaoss35/conftest-kubernetes-action@1.0
        with:
          file: example/deployment.yml
```
### Remote

Use [**REMOTE**]() policies through Conftest policy option.
```yaml
name: conftest
on: [pull_request]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: conftest
        uses: joaoss35/conftest-kubernetes-action@1.0
        with:
          file: example/deployment.yml
          update: github.com/instrumenta/policies.git//kubernetes
```

### Custom

Use your own **LOCAL** custom policies through Conftest ``policy`` option.

```yaml
name: conftest
on: [pull_request]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: conftest
        uses: joaoss35/conftest-kubernetes-action@1.0
        with:
          file: example/deployment.yml
          policy: your_custom_policies_path_here
```

### Custom Remote

Use your own custom **REMOTE** policies through Conftest multiple options.

```yaml
name: conftest
on: [pull_request]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: conftest
        uses: joaoss35/conftest-kubernetes-action@1.0
        with:
          file: example/deployment.yml
          policy: your_custom_policies_path_here
          update: your_policies_url_here
          namespace: your_policies_namespace_here
```

### Advanced

Take advantage of Conftest multiple options to perform advanced testing.

```yaml
name: conftest
on: [pull_request]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      - name: conftest
        uses: joaoss35/conftest-kubernetes-action@1.0
        with:
          combine: true
          file: main.tf
          namespace: your_policies_namespace_here
          policy: your_custom_policies_path_here
          update: your_policies_url_here
          trace: true
          parser: hcl1
```

## Building locally
```shell
git clone git@github.com:joaoss35/conftest-kubernetes-action.git
cd conftest-kubernetes-action
docker build -t foo_bar:foo_biz .
```

## Running locally

```shell
git clone git@github.com:joaoss35/conftest-kubernetes-action.git
cd conftest-kubernetes-action
docker run -v "$PWD:/action" -e COMBINE=true -e NAMESPACE=main -e PARSER=yaml -e FILE=/action/example/deployment.yml -e TRACE=false -e OUTPUT=stdout -e UPDATE=github.com/instrumenta/policies.git//kubernetes -e POLICY=policy joaoss35/conftest-kubernetes-action:1.1
```

## Actions CI

To be included.

## Special Mentions
**@makocchi-git** for such an amazing sandbox project.




