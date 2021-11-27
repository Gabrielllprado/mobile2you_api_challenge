# mobile2you Api Challenge
Desafio de desenvolvimento de API para a empresa mobile2you

A solução proposta para o desafio consiste na criação de uma rota POST que vai receber um arquivo no formato CSV, para que o endpoint faça a inserção dos registros do CSV no banco de dados, e de uma rota GET que será responsável por exibir os registros inseridos filtrados por ano e ainda podendo ser adicionados outros filtros (release_year, media_type, country)

## Tecnologias utilizadas
  - Ruby 2.5.1
  - Rails 6.1.3
  - PostgreSQL
  - Rspec
  - Rswag


## Primeiros comandos
  ```
    gem install bundler
    bundle install
    rails db:create
    rails db:migrate
  ```

## Executar o projeto

  ```
    rails s
  ```

## Executar os testes

  ```
    rspec
  ```