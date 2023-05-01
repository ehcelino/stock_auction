
App gerado com o comando `rails new stock_auction --minimal -j esbuild --css bootstrap`

Um teste demonstrou que o javascript do bootstrap não estava ativo. Para corrigir foram usados os seguintes comandos:
`bundle add jsbundling-rails`
`rails javascript:install:esbuild`

Depois foi adicionado o comando
`import * as bootstrap from "bootstrap"`
no arquivo `app/javascript/application.js`

Este procedimento ativou corretamente o javascript do bootstrap.

Adicionados os comandos
`gem "rspec-rails"`
`gem "capybara"`
ao gemfile e executado `bundle install`
em seguida, executado `rails generate rspec:install`

adicionado
```
config.before(type: :system) do
  driven_by(:rack_test)
end
```
em `rails_helper.rb`
