# stock_auction

Projeto de leilão de lotes

Usa bootstrap para estilos e active storage para imagens dos produtos.

### Orientações

Na página inicial são listados os lotes em andamento e os lotes futuros.

Clicando no código de um lote o usuário vê detalhes daquele lote, seus ítens e perguntas e respostas se houver, além de acompanhar os lances efetuados para aquele lote.

Na barra de navegação há um formulário de busca onde o usuário pode inserir o código (parcial ou completo) de um lote, ou o nome (também parcial ou completo) de um produto.

Ao tentar fazer um cadastro é verificado o CPF do usuário, se ele consta da lista de CPFs banidos o cadastro é negado. Se o usuário logar com um CPF que foi banido posteriormente à criação da conta, uma mensagem avisa do bloqueio no momento do login e as funções do sistema lhe são negadas.

Um usuário logado no sistema pode dar um lance em leilões correntes, adicionar um leilão aos favoritos ou fazer uma pergunta em um lote.

Ele também pode ver uma lista de lotes finalizados, e ao clicar em seu nome e email na barra de navegação ele vê seus dados bem como os lotes onde ele foi vencedor.

Um administrador ao logar no sistema vê um dropdown de nome "Funções administrativas", com as seguintes opções:

* Cadastrar item - cadastra um item que pode ser adicionado a um lote
* Itens avulsos - itens que não estão vinculados a um lote
* Novo lote para leilão - cria um novo lote
* Lotes aguardando aprovação - lista os lotes que ainda não foram aprovados
* Lotes expirados - lista os lotes expirados aguardando um administrador
* Responder perguntas - lista as perguntas dos usuários em diferentes lotes
* Bloqueio de CPF - lista os CPFs bloqueados e permite adicionar outros à lista

Usuários adicionados ao banco de dados a partir do arquivo seeds (todos usam a senha "password"):

administradores:

john@leilaodogalpao.com.br

paul@leilaodogalpao.com.br

usuários:

george@ig.com.br

ringo@ig.com.br (usuário restrito por CPF)

pete@ig.com.br

michael@ig.com.br

alex@ig.com.br

Originalmente meu sistema havia sido desenvolvido para cadastrar administradores apenas pelo console, por isso existem duas validações relacionadas no modelo User. Porém depois de uma pergunta de um colega durante um dos encontros alterei o sistema para que qualquer usuário cadastrado com o domínio @leilaodogalpao.com.br seja automaticamente transformado em administrador.

Para executar: bin/dev

### Documento usado durante o desenvolvimento do aplicativo:
[documento do google](https://docs.google.com/document/d/1nbUgFEDsCoDWohQGvsMc1p699bbuLrHR4jbBfwN2npI/edit?usp=sharing)

### Mockups de tela:
[tela inicial](https://excalidraw.com/#json=qnHL3yEYa4TwYO1UeC8ur,MU5dxEDRSWSjo2gHNaajQA)

[tela de lote](https://excalidraw.com/#json=P427IC1ZGvr1TUzyztIq7,mvG10dgt5NOg71IH5_WQBQ)

[administrador](https://excalidraw.com/#json=c-x-uycNkM0vhZrOCfdgv,de__sAKWHWzevRJb9RWD7Q)


### Dependências e instalação

Ruby versão 3.2.2

Rails 7.0.4

Requer a instalação do esbuild, `rails javascript:install:esbuild`

O script `bin/setup` foi alterado para incluir a instalação do esbuild.

### Gems utilizadas

Devise - gerenciamento de usuários e permissões

jsbundling-rails - javascript bundling

rspec-rails e capybara - testes

simplecov - cobertura de testes


### Breve histórico de desenvolvimento

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

no arquivo `rails_helper.rb` adicionado
```
config.before(type: :system) do
  driven_by(:rack_test)
end
```

instalação da gem Devise com os comandos:

`gem 'devise'` no gemfile

`rails generate devise:install`

Em `config/application.rb` ativada a linha
`require "action_mailer/railtie"`

Criado modelo de usuário com o comando
`rails generate devise user name:string cpf:integer admin:integer`

Na migration do modelo user do devise, adicionado `default: 0` para o campo admin

Adicionado arquivo `config/locales/rails.pt-BR.yml`

Adicionado arquivo `config/locales/devise.pt-BR.yml`

Adicionado arquivo `config/initializers/locale.rb`

Adicionado arquivo `config/locales/user.pt-BR.yml`

Executado comando `rails g devise:views`

Criado modelo de categoria com o comando
`rails g model category name`

Criado modelo de item com o comando
`rails g model item name description image:attachment weight:integer width:integer height:integer depth:integer category:references code`

Criada a pasta `spec/support` e adicionado o arquivo `devise_methods.rb`

Em `spec/rails_helper`, habilitada a linha
`Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }`

Em `config/application.rb` ativada a linha
`require "active_storage/engine"`

Executado comando `bin/rails active_storage:install`

Criado o arquivo `config/storage.yml`

No arquivo `environment/development.rb` adicionada a linha

`config.active_storage.service = :local`

No arquivo `environment/test.rb` adicionada a linha

`config.active_storage.service = :test`

No arquivo `config/application.rb` adicionado

```
config.action_view.field_error_proc = Proc.new { |html_tag, instance|
  html_tag
}
```
para impedir que os formulários percam formatação em caso de erros
