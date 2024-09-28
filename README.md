# Desafio iOS


## Introdução 

Este é o projeto de conclusão do desafio-iOS do Banco Cora, cujo objetivo foi simular o fluxo de acesso de um usuário ao app do banco.

Antes de desenvolvê-lo, me guiei a partir das seguintes informações, buscando entregar um projeto com a cara da Cora ser assertiva nas tomadas de decisão que permeiam sua implementação.

- Cora App na Appstore: iOS Deployment Target = 13.0 
- CoraBank GitHub Repository: iOS Community

A partir do Deployment Target, optei por trabalhar com UIKit por entender que geraria uma compatibilidade de implementação com o aplicativo original. 
Quanto ao repositório do Git do Cora, achei interessante trabalhar sob o modelo de template disposto por vocês. Portanto, utilizo o design pattern __MVVM__ e a __Clean architecture__. Pois além de gerar escalabilidade e testabilidade, também sigo as boas práticas de implementação da equipe de desenvolvimento do Cora.

## Funcionalidades: 

Em específico, o projeto dispõe das seguintes funcionalidades. 

- Login do usuário: 
- Extrato do usuário 
- Detalhes da transação

## Execução do projeto 

Para executar o projeto, você deve clonar o repositório através do terminal utilizando o seguinte comando: 
``` 
git clone https://github.com/vilelanatalia/desafio-ios.git
```


## Testes 

Até o momento, a cobertura de testes do projeto possui uma baixa porcentagem. Contudo, a prioridade a partir de agora é mudar o atual escopo e cobrir uma porcentagem maior. 

Entretanto, em respeito ao prazo proposto pelo desafio, os testes serão implementados em uma outra branch apenas para exercer a boa prática de criar e executar testes.

## Pontos de melhoria 

Durante a implementação, enfrentei alguns dilemas, especialmente em relação a UI do projeto e acredito que o principal motivo foi por não estar tão habituada com UIKit. 

Obtive tanto as questões já pontuadas, quanto uma dificuldade em manter um código consistente e padrão. Optei por refatorar ao fim do projeto e essa não foi uma boa decisão. O projeto parece simples e eu me enganei nesse ponto. Por isso, uma parte do código começou a ser refatorada enquanto as outras ainda precisam receber esse cuidado. 

#### Button 

Não consegui replicar o padrão de alguns botões conforme o protótipo, devido a dificuldades no posicionamento correto do símbolo.

###### Melhorias necessárias nos botões:

* IntroView: signUpButton
* RegisterView: nextButton
* PasswordView: nextButton
* TransferDetailsView: shareButton

#### TableView no BankStatement 
Há um espaçamento extra na altura da TableView na tela de BankStatement, cujo motivo não consegui identificar..  
 
#### SegmentedControl 
Outra melhoria envolve a adição de um SegmentedControl na tela de BankStatement, com opções de filtro entre "Tudo", "Entrada", "Saída" e "Futuro". Como não tive tempo para implementar essa funcionalidade, ela foi deixada de lado, considerando que sua presença seria puramente visual, sem agregar valor significativo ao projeto.

#### Tela de loading
Dentro das prioridades do projeto, não coube dentro do escopo de tempo criar o placeholder de loading pras telas de BankStatement e TransferDetails. 

#### Atualização do token
Apesar de ser um requisito do projeto, não foi implementado um método que atualizasse o valor do token após 1 minuto. Estudei previamente o tópico e sei deve ser utilizado o OAuth.

Por fim, pode ser que eu não tenha me atentado a algum outro ponto, mas acredito que esses tenham sido os principais. 

## Considerações finais 

Primeiro de tudo, gostaria de agradecer pela oportunidade de participar do desafio-iOS. 
Pelas escolhas que definiram as características do projeto, acredito que o nome "desafio" fez jus a ele. Foi mesmo um desafio, estou contente pela jornada até aqui, mas sei que há vários pontos que devem ser trabalhados para que o projeto esteja ao nível daquilo que eu gostaria de entregar. 
