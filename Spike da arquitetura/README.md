# Spike Arquitetura

## 1ª etapa - Exploração

- Modular Architecture
- Clean Architecture
- MVVM
- VIPER
- Redux
- Composable Architecture

### Referências
- [Modular Architecture 1](https://medium.com/@leandromperez/a-modular-architecture-in-swift-aafd9026aa99)
- [Modular Architecture 2](https://tech.olx.com/modular-architecture-in-ios-c1a1e3bff8e9)
- [Clean Architecture 1](https://www.linkedin.com/pulse/pragmatic-guide-clean-architecture-ios-adrian-dieter-bilescu-beilf/)
- [Clean Architecture 2](https://medium.com/@walfandi/a-beginners-guide-to-clean-architecture-in-ios-building-better-apps-step-by-step-53e6ec8b3abd)
- [Clean Architecture 3](https://paulallies.medium.com/clean-architecture-ios-app-100539550110)
- [MVVM](https://www.linkedin.com/pulse/mvvm-desenvolvimento-ios-com-swift-gutemberg-ara%C3%BAjo-64ssc/?originalSubdomain=pt)
- [Viper 1](https://www.linkedin.com/pulse/understanding-viper-architecture-pattern-ios-app-mehmet-ali-demir/)
- [Viper 2](https://www.objc.io/issues/13-architecture/viper/)
- [Redux](https://www.kodeco.com/books/advanced-ios-app-architecture/v3.0/chapters/6-architecture-redux)
- [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture?tab=readme-ov-file)

### Conclusão
Explorando e discutindo todas as arquiteturas listadas, decidimos usar a MVVM, pensando no tempo do challenge, curva de aprendizado da arquitetura e que nenhum membro do grupo tinha trabalhado com MVVM então todos poderiam aprender mais sobre novas arquiteturas.


## 2ª etapa - Aprofundamento

### Aplicação
Cada View tem uma ViewModel equivalente para separar a lógica e os dados da interface. Os Models são criados de acordo com a necessidade dos dados da aplicação.
Estrutura das pastas:

```
ProjectFolder
└───Models
│   │   SomeModel.swift
│
└───ViewModels
│   │   ViewModel.swift
│
└───Views
│   │   View.swift 
│
│   App.swift
```

**Models**: Representa as estruturas de dados e as regras de negócios da aplicação, sem saber como os dados são usados pela interface

**ViewModels**: Representa a camada que faz a ponte entre o Model e a View

**Views**: Representa a interface de interação da aplicação

### Referências
- [Discussão sobre uso do MVVM](https://forums.developer.apple.com/forums/thread/699003)
- [Aplicação e discussão sobre uso do MVVM](https://matteomanferdini.com/mvvm-swiftui/)
- [Aplicação MVVM](https://medium.com/@nindyalita/introducing-mvvm-in-swiftui-how-to-easily-implement-mvvm-in-swiftui-93e110a978a1)
- [Aplicação MVVM](https://www.kodeco.com/books/swiftui-cookbook/v1.0/chapters/10-implement-mvvm-architecture-in-swiftui)
- [Aplicação MVVM - Hacking with swift](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project)

### Conclusão
Pesquisando mais sobre a arquitetura e vendo diferentes exemplos de aplicação, criamos um projeto de demonstração da aplicação da arquitetura, usando os padrões de aplicação definidos acima acima, para usarmos como referência durante o processo de desenvolvimento do projeto.