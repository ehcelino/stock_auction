
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

Feito um teste inicial de acesso do sistema.

instalação da gem Devise com os comandos:

`gem 'devise'` no gemfile

`rails generate devise:install`

Em `config/application.rb` ativada a linha
`require "action_mailer/railtie`

Criado modelo de usuário com o comando
`rails generate devise user name:string cpf:integer admin:integer`

Na migration do modelo user do devise, adicionado `default: 0` para o campo admin

Adicionado arquivo `config/locales/rails.pt-BR.yml`

Adicionado arquivo `config/locales/devise.pt-BR.yml`

Adicionado arquivo `config/initializers/locale.rb`

Adicionado arquivo `config/locales/user.pt-BR.yml`

Executado comando `rails g devise:views`
