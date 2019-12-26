# Things Todo Terraform

Shared resources infrastructure for Things Todo application. 

## Getting Started

This project, combined with [ttd_infra](https://github.com/mjedrasz/ttd_infra) and [ttd_serverless](https://github.com/mjedrasz/ttd_serverless), sets up the whole AWS infrastructure needed to run the application.

The idea is to keep cross-service, shared resources like DynamoDB, Cognito or Elasticsearch in Terraform/Terragrunt and to use [Serverless framework](https://serverless.com/) to build and manage lambda functions and lambda related resources (e.g. permissions).

## Installing

The actual setup is done via [ttd_infra](https://github.com/mjedrasz/ttd_infra) project.

## License

This project is licensed under the MIT License - see the [LICENSE.MD](LICENSE.MD) file for details

