# mobile2you_api_challenge
Desafio de desenvolvimento de API para a empresa mobile2you

A solução proposta para o desafio consiste na criação de uma rota POST que vai receber o path de um arquivo CSV salvo no computador, para que o endpoint faça a inserção dos registros do CSV no banco de dados, e de uma rota GET que será responsável por exibir os registros inseridos filtrados por ano e ainda podendo ser adicionados outros filtros (release_year, media_type, country)

## Técnologias utilizadas
  -- Ruby
  -- Rails
  -- PostgreSQL
  -- Rspec


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