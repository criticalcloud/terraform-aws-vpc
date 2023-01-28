Terraform Module - VPC
==========

Projeto para criação dos seguintes recursos de VPC:

Recurso     | Descrição 
----------  |-----------
**vpc data**      | VPC de Banco de Dados
**vpc app**      | VPC de app
**vpc peering** | Conexão entre as VPCs data e app
**subnet data**  | 3 subnets privadas para a VPC data
**subnet app**  | 3 subnets privadas e uma publica para a VPC app
**internet gateway**       | Internet Gateway para acesso a internet
**nat gateway app**       | Nat Gateway para as subnets privadas da VPC app
**route table** | Rotas para as subnets das VPCs data e app

## COMO UTILIZAR O PROJETO NETWORKING

```shell
# CLONE O REPOSITORIO
$ git clone <repo_url>

# ACESSE O REPOSITORIO
$ cd <repo_folder>

# INICIALIZE O TERRAFORM
$ terraform init

# VISUALIZE O PLANO DE EXECUÇÃO
$ terraform plan

# APLIQUE AS CONFIGURAÇÕES NO PROVIDER
$ terraform apply
```

## COMO FUNCIONA

O Terraform utiliza as variaveis definidas no arquivo [terraform.tfvars](aws/networking/terraform.tfvars).

Obs: Para Terraform Cloud, utilizar [terraform.auto.tfvars](aws/networking/terraform.auto.tfvars)

Algumas variaveis possuem valores default definidas no arquivo [variables.tf](aws/networking/variables.tf), porém você pode substituir o valor default caso queira, definindo o valor no arquivo `terraform.tfvars`.

# CONFIGURAÇÃO
## VARIÁVEIS DE AMBIENTE

Antes de executar o comando `terraform apply`, você deve ajustar as seguintes variaveis no arquivo [terraform.tfvars](aws/networking/terraform.tfvars):

`cidr_vpc_db:` Define o range IP da VPC DB.

`cidr_vpc_app:` Define o range IP da VPC app.

`vpc_name_db:` Define o nome da VPC DB.

`vpc_name_app:` Define o nome da VPC app.

`cidr_block_private_sub_db:` Define o range IP das subnets privadas da VPC DB.

`cidr_block_private_sub_app:` Define o range IP das subnets privadas da VPC app.

`cidr_block_public_sub_app:` Define o range IP das subnets publicas da VPC app.

`private_subnet_db_name:` Define o nome inicial das subnets privadas da VPC DB.

`private_subnet_app_name:` Define o nome inicial das subnets privadas da VPC app.

`public_subnet_app_name:` Define o nome inicial das subnets publicas da VPC app.

`create_public_sub:` Define se as subnets publicas da VPC app serão criadas. Valores possiveis `true` ou `false`.

`role_arn:` Define qual role AWS será utilizada para a conexão com o provider.

`profile:` Define qual será o profile AWS utilizado para a conexão com o provider.

Obs: Var `profile` não deve ser usada com o Terraform Cloud e sim a variavel `role_arn` ou as variaveis de ambiente `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`

**Variaveis com valor default:**

As seguintes variaveis possuem valores default configuradas no arquivo [variables.tf](aws/networking/variables.tf):

`create_public_sub:`
```shell
default = true
```
`availability_zone:` Define as availability zones da região sa-east-1
```shell
default = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
```
`zone:` Define a letra das availability zones da região sa-east-1, utilizadas para definir o nome de cada subnet de acordo com a região.
```shell
default = ["A", "B", "C"]
```
`region:` Define a região AWS ao qual serão aplicadas as configurações.
```shell
default = "sa-east-1"
```
