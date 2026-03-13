# MOBILE_ARQUITETURA_02
Atividade 2 – Evolução da Aplicação Flutter com Arquitetura em Camadas

**Disciplina:** Desenvolvimento para Dispositivos Móveis II  
**Tema:** Arquitetura em Camadas  
**API utilizada:** https://fakestoreapi.com/products  

---

# 1. Introdução

Esta atividade tem como objetivo evoluir a aplicação Flutter desenvolvida na Atividade 1, aplicando melhorias arquiteturais comuns em aplicações reais. O foco principal é compreender como uma arquitetura em camadas permite que um sistema evolua sem comprometer sua organização estrutural.

A aplicação desenvolvida consome uma API pública de produtos (Fake Store API) e exibe uma lista de produtos contendo informações como identificador, título, preço e imagem.

Na Atividade 2 foram implementadas melhorias relacionadas ao gerenciamento de estado da interface, tratamento de erros e implementação de um mecanismo simples de cache local.

---

# 2. Estrutura Arquitetural do Projeto

A aplicação foi organizada seguindo uma arquitetura em camadas, separando responsabilidades entre diferentes partes do sistema.

lib
 ├── core
 │
 ├── data
 │   ├── datasources
 │   │   └── product_remote_datasource.dart
 │   │
 │   ├── models
 │   │   └── product_model.dart
 │   │
 │   └── repositories
 │       └── product_repository_impl.dart
 │
 ├── domain
 │   ├── entities
 │   │   └── product.dart
 │   │
 │   └── repositories
 │       └── product_repository.dart
 │
 └── presentation
     ├── pages
     │   └── product_page.dart
     │
     └── viewmodels
         ├── product_viewmodel.dart
         └── product_state.dart


### Camadas

**Domain**

Contém as regras de negócio e as entidades principais da aplicação.

**Data**

Responsável por acessar dados externos, como APIs.

**Presentation**

Responsável pela interface do usuário e gerenciamento de estado da aplicação.

---

# 3. Melhorias Implementadas

## 3.1 Estado da Interface

Foi implementado um sistema de estados para representar as diferentes situações da aplicação.

Estados implementados:

- `Idle`
- `Loading`
- `Success`
- `Error`

Esses estados permitem que a interface reaja de maneira adequada durante o funcionamento da aplicação.

Exemplos:

**Loading**

Exibe um indicador de carregamento (`CircularProgressIndicator`).

**Error**

Exibe uma mensagem informando que ocorreu um erro na requisição.

**Success**

Exibe a lista de produtos carregados.

---

## 3.2 Tratamento de Erros

Foi implementado tratamento de erros para capturar falhas durante a comunicação com a API.

Caso ocorra um erro durante a requisição HTTP, o sistema captura a exceção e altera o estado da interface para `error`, exibindo uma mensagem ao usuário.

Esse tratamento evita falhas inesperadas e melhora a experiência do usuário.

---

## 3.3 Cache Local Simples

Foi implementado um mecanismo simples de cache dentro do `Repository`.

Quando os dados são carregados com sucesso pela API, eles são armazenados temporariamente em memória.

Fluxo de funcionamento:

1. A aplicação tenta buscar dados da API
2. Se a requisição for bem-sucedida, os dados são armazenados no cache
3. Se a requisição falhar, o sistema tenta utilizar os dados armazenados
4. Caso não exista cache disponível, um erro é exibido

---

# 4. Benefícios da Arquitetura em Camadas

A utilização dessa arquitetura trouxe diversas vantagens:

- **Separação de responsabilidades**
- **Maior organização do código**
- **Facilidade de manutenção**
- **Facilidade para testes**
- **Escalabilidade do sistema**

Essa abordagem é muito utilizada em aplicações modernas, principalmente em projetos Flutter de médio e grande porte.

---

# 5. Questionário de Reflexão

## 5.1 Em qual camada foi implementado o mecanismo de cache?

O mecanismo de cache foi implementado na camada **Repository**.

Isso ocorre porque o Repository é responsável por decidir **de onde os dados serão obtidos**, podendo escolher entre dados remotos, dados locais ou cache.

Essa abordagem mantém as outras camadas desacopladas da lógica de armazenamento de dados.

---

## 5.2 Por que o ViewModel não deve realizar chamadas HTTP diretamente?

O ViewModel não deve realizar chamadas HTTP diretamente porque isso quebraria o princípio de separação de responsabilidades.

O acesso a dados externos deve ser feito pelos **DataSources**, enquanto o ViewModel deve apenas coordenar o estado da interface e interagir com o Repository.

---

## 5.3 O que poderia acontecer se a interface acessasse diretamente o DataSource?

Se a interface acessasse diretamente o DataSource, haveria um forte acoplamento entre a camada de apresentação e a camada de dados.

Isso tornaria o sistema mais difícil de manter, testar e evoluir.

---

## 5.4 Como essa arquitetura facilitaria a substituição da API por um banco de dados local?

Como a interface depende apenas do **Repository**, seria possível substituir a fonte de dados sem alterar a interface ou o ViewModel.

Bastaria criar uma nova implementação do Repository utilizando um banco de dados local como SQLite ou Hive.

---


