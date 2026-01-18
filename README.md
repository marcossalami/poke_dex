# 🔴 Pokédex - Flutter App

Aplicação Flutter que exibe dados de Pokémon usando a **PokéAPI v2**, implementando **Clean Architecture** com Domain, Data e Presentation layers.

---

## 📊 Funcionalidades

### ✅ Obrigatórias
- ✅ **Listagem com paginação** (limit/offset com scroll infinito)
- ✅ **Tela de detalhes** com tipos, altura, peso e stats
- ✅ **Consumo real da API** PokéAPI v2
- ✅ **Estados** loading, erro e sucesso
- ✅ **Navegação** entre telas com argumentos tipados
- ✅ **Clean Architecture** Domain/Data/Presentation

### 🌟 Diferenciais
- ⭐ **Pull-to-Refresh** (refresh manual de dados)
- ⭐ **Tratamento robusto de erros** (timeout, conexão, servidor)
- ⭐ **Cache em memória** para otimizar performance
- ⭐ **65 testes unitários** (cobertura 70-80%)
- ⭐ **Injeção de dependência** com GetIt
- ⭐ **Gerenciamento de estado** com Provider + ChangeNotifier
- ⭐ **UI polida** com Material Design 3

---

## 🏗️ Arquitetura

### Clean Architecture com 3 Camadas

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  (Pages, Widgets, State Management - PokemonProvider)      │
└──────────────┬──────────────────────────────────────────────┘
               │ (Dependency Injection)
┌──────────────▼──────────────────────────────────────────────┐
│                     DOMAIN LAYER                             │
│  (Entities, Repositories Interface, UseCases)              │
└──────────────┬──────────────────────────────────────────────┘
               │ (Abstraction)
┌──────────────▼──────────────────────────────────────────────┐
│                      DATA LAYER                              │
│  (Models, DataSources, Repository Implementation)           │
└─────────────────────────────────────────────────────────────┘
```

### Estrutura de Pastas

```
lib/
│
├── core/                          # Código compartilhado
│   ├── di/
│   │   └── injector.dart         # Configuração GetIt
│   ├── error/
│   │   └── failures.dart         # Classes de erro
│   ├── network/
│   │   └── dio_client.dart       # Configuração HTTP
│   ├── usecase/
│   │   └── usecase.dart          # Base UseCase
│   ├── enums/
│   │   ├── pokemon_type.dart
│   │   └── pokemon_type_extension.dart
│   └── assets/
│       └── Images e recursos
│
├── features/
│   └── pokemon/                   # Feature Pokemon
│       │
│       ├── domain/               # Entidades e regras de negócio
│       │   ├── entities/
│       │   │   ├── pokemon_entity.dart
│       │   │   └── pokemon_stat_entity.dart
│       │   ├── repositories/
│       │   │   └── pokemon_repository.dart  # Interface
│       │   └── usecases/
│       │       ├── get_pokemons.dart
│       │       └── get_pokemon_detail.dart
│       │
│       ├── data/                 # Implementação e acesso a dados
│       │   ├── datasources/
│       │   │   ├── pokemon_remote_datasource.dart       # Interface
│       │   │   └── pokemon_remote_datasource_impl.dart  # Implementação
│       │   ├── models/
│       │   │   └── pokemon_model.dart  # Extensão de PokemonEntity
│       │   └── repositories/
│       │       └── pokemon_repository_impl.dart
│       │
│       └── presentation/         # UI e gerenciamento de estado
│           ├── pages/
│           │   ├── pokemon_list_page.dart      # Listagem com paginação
│           │   ├── pokemon_detail_page.dart    # Detalhes
│           │   └── pokemon_detail_skeleton.dart # Loading skeleton
│           ├── widgets/
│           │   ├── pokemon_card.dart
│           │   ├── info_column.dart
│           │   └── pokemon_stat_bar.dart
│           └── state/
│               └── pokemon_provider.dart  # ChangeNotifier (gerenciamento)
│
└── main.dart                      # Entry point
```

### Fluxo de Dados

```
UI (Pages/Widgets)
    ↓
Provider (State Management)
    ↓ (chama UseCase)
GetPokemons / GetPokemonDetail
    ↓ (chama Repository)
PokemonRepository (Interface)
    ↓ (implementação)
PokemonRepositoryImpl
    ↓ (chama DataSource)
PokemonRemoteDatasource
    ↓ (faz requisição HTTP)
Dio HTTP Client
    ↓ (requisita)
PokéAPI
```

---

## 📡 API Utilizada

### PokéAPI v2
- **URL Base**: `https://pokeapi.co/api/v2`
- **Documentação**: https://pokeapi.co/docs/v2
- **Tipo**: REST, sem autenticação necessária
- **Rate Limit**: 100 requisições por IP por minuto

### Endpoints Utilizados

#### 1. **Listagem de Pokémon**
```
GET /pokemon?limit=20&offset=0
```

**Resposta:**
```json
{
  "count": 1025,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    ...
  ]
}
```

#### 2. **Detalhes do Pokémon**
```
GET /pokemon/{name_ou_id}
```

**Resposta:**
```json
{
  "id": 1,
  "name": "bulbasaur",
  "height": 7,
  "weight": 69,
  "sprites": {
    "other": {
      "official-artwork": {
        "front_default": "https://raw.githubusercontent.com/..."
      }
    }
  },
  "types": [
    { "type": { "name": "grass" } },
    { "type": { "name": "poison" } }
  ],
  "stats": [
    {
      "stat": { "name": "hp" },
      "base_stat": 45
    },
    ...
  ]
}
```

---

## 🚀 Como Rodar o App

### 📦 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Flutter** 3.8.1 ou superior
  - [Instalar Flutter](https://flutter.dev/docs/get-started/install)
- **Dart** 3.8.1+ (incluído no Flutter)
- **Git** para clonar o repositório
- Um **emulador Android/iOS** ou **dispositivo físico**

### ✅ Verificar Instalação

```bash
# Verificar versões
flutter --version
dart --version

# Verificar dependências
flutter doctor
```

### 🎯 Passo a Passo para Rodar

#### 1️⃣ Clone o Repositório

```bash
git clone https://github.com/seu-usuario/poke_dex.git
cd poke_dex
```

#### 2️⃣ Instale as Dependências

```bash
# Baixar pacotes do pub.dev
flutter pub get

# Saída esperada:
# Running "flutter pub get" in poke_dex...
# ✓ Got dependencies in X seconds
```

#### 3️⃣ Execute a Aplicação

```bash
# Rodar no dispositivo/emulador padrão
flutter run

# Rodar especificando um dispositivo
flutter run -d emulator-5554

# Rodar em modo release (mais otimizado e rápido)
flutter run --release

# Rodar e manter conectado para reload rápido
flutter run --hot
```

#### 4️⃣ Desfrutar! 🎉

A aplicação deve abrir mostrando a listagem de Pokémon com scroll infinito.

### 📱 Configurar Emuladores

**Android:**
```bash
# Listar emuladores disponíveis
emulator -list-avds

# Iniciar emulador específico
emulator -avd <nome_emulador>

# Ou via Flutter
flutter emulators --launch <nome>

# Listar dispositivos disponíveis
flutter devices
```

**iOS (Mac apenas):**
```bash
# Listar simuladores disponíveis
xcrun simctl list devices

# Iniciar simulator
open -a Simulator

# Depois rodar
flutter run
```

### 🔧 Troubleshooting

**Problema**: "Flutter not found"
```bash
# Adicione Flutter ao PATH do seu sistema
# Windows: C:\flutter\bin
# Mac/Linux: ~/flutter/bin
export PATH="$PATH:~/flutter/bin"
```

**Problema**: "No devices found"
```bash
# Certifique-se de ter emulador/dispositivo conectado
flutter devices

# Se vazio, inicie um emulador ou conecte dispositivo físico
```

**Problema**: Erro de dependências
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🧪 Como Executar os Testes

### 📊 Resumo de Testes

| Camada | Quantidade | Cobertura | Status |
|--------|-----------|-----------|--------|
| Data Layer | 16 testes | 100% | ✅ |
| Domain Layer | 15 testes | 100% | ✅ |
| Presentation Layer | 34 testes | 90% | ✅ |

### 🎯 Executar Todos os Testes

```bash
# Rodar todos os testes do projeto
flutter test

# Saída esperada:
# 00:14 +65: All tests passed!
```

### 🔍 Rodar com Cobertura

```bash
# Gerar relatório de cobertura (lcov)
flutter test --coverage

# Visualizar cobertura em HTML (Mac/Linux)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Verificar cobertura de arquivo específico
flutter test --coverage test/features/pokemon/domain/
```

### 📁 Rodar Testes Específicos

```bash
# Testes de um arquivo específico
flutter test test/features/pokemon/domain/usecases/get_pokemons_test.dart

# Testes de um diretório inteiro
flutter test test/features/pokemon/data/

# Testes com padrão de nome (contém "pokemon_model")
flutter test -k "pokemon_model"

# Testes que NÃO contém "entity"
flutter test -k "not entity"

# Testes de um grupo específico
flutter test -k "GetPokemons"
```

### 🏃 Opções Úteis

```bash
# Modo verbose (mais detalhes)
flutter test -v

# Parar no primeiro erro
flutter test -x

# Testar arquivo específico
flutter test test/features/pokemon/domain/usecases/

# Recarregar testes automaticamente (watch mode)
flutter test --watch
```

### 📋 Estrutura de Testes

```
test/
├── features/
│   └── pokemon/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── pokemon_remote_datasource_test.dart (4 testes)
│       │   ├── models/
│       │   │   └── pokemon_model_test.dart (7 testes)
│       │   └── repositories/
│       │       └── pokemon_repository_impl_test.dart (5 testes)
│       │
│       ├── domain/
│       │   └── usecases/
│       │       ├── get_pokemons_test.dart (5 testes)
│       │       └── get_pokemon_detail_test.dart (10 testes)
│       │
│       └── presentation/
│           ├── pages/
│           │   └── pokemon_detail_page_test.dart (7 testes)
│           └── providers/
│               └── pokemon_provider_test.dart (27 testes)
│
├── core/
└── mocks/
    └── Mocks utilizados nos testes
```

### ✅ Padrão de Testes (Arrange-Act-Assert)

Todos os testes seguem o padrão **AAA**:

```dart
test('deve retornar lista de pokémons quando sucesso', () async {
  // 1️⃣ ARRANGE - Preparar dados e mocks
  final mockPokemons = [
    const PokemonEntity(id: 1, name: 'bulbasaur', ...),
  ];
  when(() => repository.getPokemons(limit: 20, offset: 0))
    .thenAnswer((_) async => mockPokemons);

  // 2️⃣ ACT - Executar a ação sendo testada
  final result = await usecase(limit: 20, offset: 0);

  // 3️⃣ ASSERT - Verificar resultado esperado
  expect(result, mockPokemons);
  verify(() => repository.getPokemons(limit: 20, offset: 0)).called(1);
});
```

### 🛠️ Ferramentas de Teste

- **Framework**: Flutter Test (incluído no SDK)
- **Mock Library**: Mocktail 1.0.3
- **Matcher**: matcher (expect, contains, throwsException, etc)
- **Coverage**: LCOV e genhtml

### 📝 Exemplo: Testar um UseCase

```bash
# Testar apenas GetPokemons
flutter test -k "GetPokemons"

# Resultado esperado:
# ✓ deve retornar lista de pokémons
# ✓ deve retornar lista vazia
# ✓ deve lançar exceção quando há erro
# ✓ deve chamar repositório com parâmetros corretos
# 
# 00:05 +4: All tests passed!
```

---

## 🔧 Tecnologias e Dependências

### Dependências Principais

| Pacote | Versão | Propósito |
|--------|--------|-----------|
| `provider` | ^6.1.2 | Gerenciamento de estado (State Management) |
| `dio` | ^5.4.0 | Cliente HTTP robusto e eficiente |
| `get_it` | ^7.6.7 | Injeção de dependência (Service Locator) |
| `equatable` | ^2.0.5 | Comparação de objetos (value equality) |
| `cached_network_image` | ^3.3.1 | Cache de imagens da rede |

### Dependências de Desenvolvimento

| Pacote | Versão | Propósito |
|--------|--------|-----------|
| `flutter_test` | SDK | Framework de testes do Flutter |
| `mocktail` | ^1.0.3 | Mocks para testes unitários |
| `flutter_lints` | ^5.0.0 | Análise de código e linting |

### Configuração do Flutter

```yaml
environment:
  sdk: ^3.8.1

flutter:
  uses-material-design: true
```

---

## 📐 Padrões e Princípios

### ✅ SOLID Principles

- **S**ingle Responsibility
  - Cada classe tem uma responsabilidade única
  - `PokemonProvider` gerencia estado, não acessa API

- **O**pen/Closed
  - Aberto para extensão, fechado para modificação
  - Interfaces definem contrato, implementações podem variar

- **L**iskov Substitution
  - Implementações podem substituir interfaces
  - `PokemonRepositoryImpl` implementa `PokemonRepository`

- **I**nterface Segregation
  - Interfaces específicas e não genéricas
  - `PokemonRemoteDatasource` tem métodos específicos

- **D**ependency Inversion
  - Depender de abstrações, não de implementações
  - GetIt injeta interfaces, não classes concretas

### ✅ Design Patterns Utilizados

- **Repository Pattern**: Abstração de acesso a dados
- **Dependency Injection**: GetIt para injeção automática
- **Factory Pattern**: Criação de instâncias via GetIt
- **Singleton Pattern**: Instâncias únicas (Dio, GetIt)
- **Observer Pattern**: ChangeNotifier/Provider para reatividade

### ✅ Boas Práticas Flutter

- Widgets funcionais quando possível
- `StatefulWidget` apenas quando necessário
- Provider para gerenciamento de estado
- `const` constructors para performance
- Nomes descritivos e significativos
- Separação clara de responsabilidades

---

## 🎨 UI/UX

- **Design System**: Material Design 3
- **Responsivo**: Adapta-se a diferentes tamanhos de tela
- **Animações**: Hero animation nas imagens (transição suave)
- **Loading States**: Skeleton loading visual
- **Tratamento de Erros**: UI clara com mensagem e botão de retry
- **Pull-to-Refresh**: Padrão esperado em apps profissionais

---

## 📊 Fluxo de Dados Detalhado

### 1. Carregar Listagem de Pokémon

```
User abre app
    ↓
main.dart inicializa GetIt (DI)
    ↓
PokemonListPage cria PokemonProvider
    ↓
Provider.fetchPokemons() (Limit: 20, Offset: 0)
    ↓
GetPokemons UseCase (DDD pattern)
    ↓
PokemonRepository.getPokemons() (Interface)
    ↓
PokemonRepositoryImpl (Implementação)
    ↓
PokemonRemoteDatasource.getPokemons()
    ↓
Dio HTTP Client
    ↓
PokéAPI /pokemon?limit=20&offset=0
    ↓
Response JSON parseado em PokemonModel
    ↓
Convertido para PokemonEntity
    ↓
Atualiza UI via notifyListeners()
```

### 2. Carregar Detalhes de Pokémon

```
User toca no card
    ↓
Navigator.pushNamed('/detail', arguments: 'bulbasaur')
    ↓
PokemonDetailPage.fetchPokemonDetail('bulbasaur')
    ↓
Verifica _detailsCache (Cache em memória)
    ↓
Se em cache: retorna do cache ⚡
Se não: chama API
    ↓
GetPokemonDetail UseCase
    ↓
PokemonRepository.getPokemonDetail()
    ↓
Dio requisita /pokemon/bulbasaur
    ↓
JSON parseado em PokemonModel
    ↓
Armazena em _detailsCache
    ↓
FutureBuilder renderiza UI
```

---

## 🔐 Tratamento de Erros

O app trata diferentes tipos de erro:

```dart
// ConnectionTimeout
"Tempo de conexão esgotado. Tente novamente."

// Unknown (sem internet)
"Erro de conexão. Verifique sua internet."

// 404 Not Found
"Pokémon não encontrado."

// 500 Server Error
"Erro no servidor. Tente mais tarde."
```

---



## 📄 Licença

Este projeto foi desenvolvido como teste técnico.

```
MIT License - Sinta-se livre para usar e modificar!
```
  
---

## 💻 Autor

**Marcos Antonio Salami**  

---

## �📈 Próximas Melhorias 

Se quiser expandir o projeto:

- [ ] Adicionar Favoritos (persistência com Hive)
- [ ] Search/Filter de Pokémon
- [ ] Modo offline com cache local
- [ ] Animations mais fluidas
- [ ] Widget tests expandidos
- [ ] Integration tests
- [ ] Firebase Analytics

---


Última atualização: 18 de janeiro de 2026
