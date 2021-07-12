# Things Todo Terraform

Shared resources infrastructure for Things Todo application. It's a revisited [ttd-terraform](https://github.com/mjedrasz/ttd-terraform) with a new approach to modules and some minor changes and fixes.

## Getting Started

This project, combined with [ttd-infra-v2](https://github.com/mjedrasz/ttd-infra) and [ttd-serverless-v2](https://github.com/mjedrasz/ttd-serverless-v2), sets up the whole AWS infrastructure needed to run the application.

The idea is to keep cross-service, shared resources like DynamoDB, Cognito or Elasticsearch in Terraform/Terragrunt and to use [Serverless framework](https://serverless.com/) to build and manage lambda functions and lambda related resources (e.g. permissions). AWS Parameter Store is used to "pass" parameters from terraform/terragrunt to serverless framework.

## Installing

The actual setup is done via [ttd-infra-v2](https://github.com/mjedrasz/ttd-infra-v2) project.

## License

This project is licensed under the MIT License - see the [LICENSE.MD](LICENSE.MD) file for details

