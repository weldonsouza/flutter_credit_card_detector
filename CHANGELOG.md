## [3.0.4] - 21 de Março 2026.

* `CreditCardWidget`: ação opcional de escaneamento do cartão (`showCardScanAction`, `onCardScan`, `cardScanIcon`, `cardScanIconColor`, `cardScanTooltip`) com modelo `CardScanResult` exportado pelo pacote; o app implementa câmera/OCR e o widget preenche número, nome e validade quando informados.
* Example: nova aba **Horizontal** (`viewLayout: true`) com demo do ícone de escaneamento; chaves de widget por aba para estado independente.
* `CreditCardWidget`: `cardScanButtonBuilder` opcional para substituir o layout do botão de escaneamento; modelo `CardScanButtonData` e typedef `CardScanButtonBuilder` exportados.
* Example: aba *Custom* demonstra botão tonal customizado (`IconButton.filledTonal`).

## [3.0.3] - 20 de Março 2026.

* `CreditCardWidget`: parâmetros opcionais para personalizar os campos de texto (`inputDecoration`, `inputContentPadding`, bordas `input*Border`), repassados a todos os `CreditCardInputField`.
* Export público de `CreditCardInputField` no barrel do pacote.
* Correções de estabilidade no fluxo de seleção manual de bandeira.
* Correção de inicialização no `ControllerBase` para evitar `LateInitializationError`.
* Ajustes e otimizações internas no `BodyWidget`.
* Atualização do projeto iOS do `example` para compatibilidade com ferramentas atuais.
* Melhorias no `README` (exemplos, parâmetros e links de imagens para renderização no pub.dev).

## [3.0.0] - 17 de Março 2026.

* Migração do pacote para Flutter/Dart atuais:
  * `sdk: >=3.0.0 <4.0.0`
  * `flutter: >=3.10.0`
* Atualização de dependências e ajustes para build moderno do exemplo Android.
* Melhorias de design e customização do widget:
  * presets visuais do cartão (`custom`, `modern`, `glass`, `midnight`)
  * novos parâmetros de estilo (tipografia, raio, elevação, margens e padding)
* Ampliação da detecção de bandeiras (incluindo Maestro, UnionPay, Troy, Dankort e UATP) com regra de prioridade em colisões.
* Refatoração interna para componentes reutilizáveis (campos, seção de formulário, botão de submit e opção de bandeira).
* Correções de estabilidade na seleção manual de bandeira e inicialização de estado do controller.

## [2.3.0] - 13 de Fevereiro 2023.

* Atualização das dependências

## [2.2.0] - 26 de Novembro 2022.

* Atualização das dependências
 
## [2.1.0] - 29 de Outubro 2021.

* Atualização das dependências do Provider

## [2.0.0] - 07 de Agosto 2021.

* Migrate to null safety
* Removidas as dependências do Mobx 

## [1.0.0] - 30 de Maio 2020.

* Orientação de layout pode ser vertical ou horizontal
* Adicionado campo CPF do tilular(Campo opcional)

## [0.1.7] - 27 de Abril 2020.

* Adicionado parâmetros opcionais para definir o tamanho dos textos no cartão:
    * Número
    * Nome
    * Data
    * CVC

## [0.1.6] - 16 de Abril 2020.

* Renomeando CreditCardDetector para CreditCardWidget

## [0.1.5] - 15 de Abril 2020.

* Corrigindo erro de sintaxe.

## [0.1.4] - 15 de Abril 2020.

* Opção para definir quais cartões estarão disponíveis

## [0.1.3] - 13 de Abril 2020.

* Atualização do README.

## [0.1.2] - 12 de Abril 2020.

* Corrigindo erro de sintaxe.

## [0.1.1] - 12 de Abril 2020.

* Atualização do README para corrigir o erro de sintaxe.

## [0.1.0] - 12 de Abril 2020.

* TODO: Describe initial release.
