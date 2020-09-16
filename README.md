# README

Marketplace:

O Marketplace ilustra uma aplicação web utilizando Ruby on Rails, onde colaboradores de uma mesma empresa podem comprar, vender e negociar produtos.

Começando:

Para executar esse projeto, será necessário instalar os seguintes programas:
  * ruby 2.7.0
  * rails 6.0.3.2
  * yarn 1.22.4


Desenvolvimento:

Para iniciar o desenvolvimento, é necessário clonar o projeto GitHub em algum diretório:
  * git clone git@github.com:ccmvcaio/marketplace.git


Construção:

Para construir o projeto você deve executar o seguinte comando no diretório escolhido:
  * bin/setup


Features:

O projeto segue uma linha onde empresas se cadastram no Marketplace e disponibilizam para seus colaboradores entrarem na plataforma para negociarem produtos.
 * Apenas colaboradores das mesmas empresas podem negociar entre eles;
 * Para começarem a negociar, os colaboradores devem ser autenticados no sistema e possuirem o seus perfis preenchidos;
 * O sistema conta com comentários nas páginas dos produtos para os colaboradores poderem negociar;
 * Os colaboradores podem ver seu histórico de compra e vendas;
 * O vendedor de um produto que confirma a venda.


Testes:

Para executar os testes, será necessário instalar as seguintes gems:
  * gem 'rspec-rails', '~> 4.0.1'
  * gem 'capybara'
Para rodar os testes, utilize o comando:
  * rspec
  

Gems:

Algumas gems foram utilizadas no projeto:
  * gem 'devise' (utilizada para a autenticação do usuário no sistema)
  * gem "cpf_cnpj" (utilizada para validação do CPF de um perfil do usuário)


Contribuições:

Contribuições são sempre bem vindas!