# mobile2you Api Challenge
Desafio de desenvolvimento de API para a empresa mobile2you

A solução proposta para o desafio foi o desenvolvimento de uma rota POST que vai receber um arquivo no formato CSV, para que a aplicação faça a inserção dos registros do CSV no banco de dados, e de uma rota GET que será responsável por exibir os registros inseridos ordenados pelo ano de lançamento, está disponível também a possibilidade de filtragem dos registros pelos seguintes campos: `release_year`, `media_type` e `country`

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
  Foi utilizado o rspec para a codificação dos testes unitários, para executá-los use o seguinte comando:

  ```
    rspec
  ```
  Um arquivo com a cobertura dos testes pode ser encontrado no seguinte caminho `coverage/index.html` abra-o após a execução dos testes.
## Gerando documentação
  Para gerar a documentação da API foi utilizado o Rswag, para executá-lo utilize o seguinte comando:
  ```
    SWAGGER_DRY_RUN=0 RAILS_ENV=test rails rswag
  ```
  Na sequência acesse o caminho `localhost:3000/api-docs` para visualizar a documentação gerada.