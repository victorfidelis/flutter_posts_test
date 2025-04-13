# Flutter Posts Test

## Visão Geral do Projeto
Aplicativo móvel desenvolvido em Flutter para exibição de posts de uma API pública com autenticação via Firebase Auth. O projeto demonstra boas práticas de desenvolvimento, arquitetura em camadas e testabilidade.

## 📋 Pré-requisitos Técnicos

- **Git** (versão 2.x ou superior)
- **Flutter SDK** (versão 3.x ou superior)
- **Android Studio/Xcode** (para emuladores)
- **Dispositivo físico** (opcional - Android 8.0+)
- **VS Code** (recomendado) com extensões:
  - Flutter
  - Dart

## 🚀 Executando o Projeto

### Configuração Inicial
```bash
# Clone o repositório
git clone https://github.com/victorfidelis/flutter_posts_test.git
cd flutter_posts_test

# Instale as dependências
flutter pub get
```

### Execução em Ambiente de Desenvolvimento

1. **Com emulador:**
   ```bash
   flutter run
   ```

2. **Em dispositivo físico:**
   - Conecte via USB (modo desenvolvedor ativado)
   - Execute:
     ```bash
     flutter run
     ```

## 🔑 Credenciais de Teste
```
Email: testevictor180@gmail.com
Senha: 123456
```

## 🏗️ Arquitetura do Projeto

### Estrutura de Pastas
```
lib/
├── app/
│   ├── bloc/        # Lógica de negócio e gerenciamento de estado
│   ├── model/       # Entidades
│   ├── repository/  # Camada de acesso a dados
│   ├── shared/      # Recursos compartilhados
│   ├── view/        # Camada de apresentação
│   └── app.dart     # Configuração inicial do app
└── main.dart        # Ponto de entrada
```

O projeto usa o BLoC com o Repository Pattern e se aproxima muito a Layered Architecture (arquitetura em camadas).

1. **Camada de Apresentação (View)**:
   - Widgets e páginas Flutter
   - Responsável pela interface do usuário
   - Comunica-se apenas com a camada BLoC

2. **Camada de Lógica (BLoC)**:
   - Gerencia o estado da aplicação
   - Contém as regras de negócio
   - Faz a ponte entre View e Repository

3. **Camada de Dados (Repository)**:
   - Abstração do acesso a dados
   - Implementa operações com APIs e serviços
   - Isola o resto do app das fontes de dados específicas

### Padrões Utilizados

- **Repository Pattern**: Para abstração de fontes de dados
- **BLoC Pattern**: Para gerenciamento de estado e lógica de negócio
- **Dependency Injection**: Para injeção de dependências
- **State Pattern**: Para representação clara dos estados
- **Either Pattern**: Para tratamento funcional de erros

## ✅ Testando a Aplicação

### Testes
```bash
flutter test
```

## 🔮 Expansão e Escalabilidade

### Adicionando Novos Recursos
1. **Para novas features**:
   - Siga a estrutura existente de BLoC + Repository
   - Considere escrever testes durante o desenvolvimento

2. **Integrações para repositórios**:
   - Implemente novas interfaces de repositório
   - Utilize construtores específicos para conversão de dados das entidades

3. **Componentes UI**:
   - Associar Views a BLoCs que fazem o gerenciamento do estado
   - Widgets específicos devem ficar na pasta da view correspondente
   - Widgets reutilizáveis devem ficam em shared/widgets

## 📝 Decisões Técnicas
- **BLoC Pattern**: Escolhido por sua robustez para estados complexos, facilidade de testes dos disparos de eventos e também por ser a tecnologia recomendada.
- **Firebase Auth**: Simplifica o fluxo de autenticação
- **Arquitetura em Camadas**: Para separação clara de responsabilidades sem muita complexidade por ser um app simples
- **Repository Pattern**: Para abstração do acesso a dados e pelo isolamento do app contra operações externas
- **Either**: Para facilidade e clareza no tratamento de erros
- **State Pattern**: Para clareza e solidez nos estados da aplicação, cada estado possui apenas os dados que precisam


## 🖼️ Capturas de Tela 

<img src="https://github.com/user-attachments/assets/0d56ae34-0682-4c1b-9242-091940a5694b" width="250">
<img src="https://github.com/user-attachments/assets/c56b3c8f-addf-475c-83c9-3478156256a9" width="250">
<img src="https://github.com/user-attachments/assets/887666bb-32a6-4a60-a20c-30db23f4f757" width="250">
<img src="https://github.com/user-attachments/assets/9d79d4c8-35a1-4e55-8c76-b32be6d75bfe" width="250">
<img src="https://github.com/user-attachments/assets/b32535e8-7153-4310-9c18-c96594ce5385" width="250">
<img src="https://github.com/user-attachments/assets/63b9c7bd-ff4c-4d97-b844-8f46155fdd9a" width="250">
<img src="https://github.com/user-attachments/assets/21051cab-314c-4ffe-85ca-f0429de36818" width="250">
<img src="https://github.com/user-attachments/assets/6d301559-4603-4567-8cfa-37dd8f1d255d" width="250">
