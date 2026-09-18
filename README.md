# Palavras Marcas

Aplicativo desktop desenvolvido em Delphi para gerar e consultar uma base de palavras extraídas de marcas nacionais e internacionais.

O sistema lê os registros de marcas em bancos Firebird, normaliza os textos, relaciona as palavras às classes correspondentes e contabiliza ocorrências por situação do processo. A base resultante pode ser consultada pela interface do programa ou exportada em JSON.

## Funcionalidades

- pesquisa de uma palavra por classe;
- exibição das quantidades de pedidos, registros e processos arquivados;
- remoção de acentos das marcas antes do processamento;
- processamento de marcas nacionais e internacionais em lotes;
- conversão de classes nacionais para classes internacionais;
- retomada do processamento a partir do último lote concluído;
- acompanhamento de progresso, velocidade e tempo estimado;
- registro de falhas sem interromper todo o lote;
- exportação da base de palavras em JSON.

## Tecnologias

- Delphi 7 / Object Pascal;
- VCL para a interface desktop;
- Firebird com componentes IBX;
- ClientDataSet/MIDAS;
- DevExpress VCL, utilizado nos componentes `cx`;
- GraphicEx;
- SuperObject, incluído no código-fonte para manipulação de JSON.

## Estrutura do projeto

```text
.
├── Banco de Dados/              # Bancos e artefatos locais de dados
├── EXE/                         # Saída e arquivos de execução
└── Projeto/
    ├── ProjetoPalavrasArgumentos.dpr
    ├── dmDPA.pas                # Conexões e operações compartilhadas de banco
    ├── untPrincipal.pas         # Tela de pesquisa
    ├── untInicializacao.pas     # Processamento, retomada e exportação JSON
    ├── untMarcaSemAcento.pas    # Normalização das marcas
    ├── untFuncs.pas             # Funções auxiliares
    └── superobject.pas          # Serialização JSON
```

Os arquivos `*.dfm` contêm a definição visual dos formulários e dos componentes não visuais.

## Pré-requisitos

Para compilar e executar o projeto, são necessários:

1. Windows;
2. Delphi 7;
3. servidor Firebird compatível com os bancos utilizados pelo sistema;
4. componentes IBX instalados no Delphi;
5. biblioteca DevExpress VCL compatível com as unidades `cxControls`, `cxContainer`, `cxEdit` e `cxProgressBar`;
6. biblioteca GraphicEx disponível no Library Path;
7. `MIDAS.DLL` disponível no Windows ou no mesmo diretório do executável.

> A versão exata do Firebird deve ser definida de acordo com o formato dos bancos usados no ambiente. O repositório não contém um instalador automatizado das dependências de terceiros.

## Configuração

Antes da compilação, revise as conexões declaradas em `Projeto/dmDPA.dfm`:

- `dbCarga`: base de origem das marcas;
- `dbPalavra`: base gerada para pesquisa de palavras;
- `dbIntelectual`: base auxiliar utilizada pela aplicação.

Também revise o destino do arquivo JSON em `Projeto/untInicializacao.pas`. O código atual utiliza caminhos absolutos, que precisam existir no computador ou ser ajustados para o ambiente de execução.

As credenciais e os caminhos de bancos não devem ser publicados no repositório. Prefira manter configurações específicas de cada ambiente fora do controle de versão.

## Compilação

1. Abra `Projeto/ProjetoPalavrasArgumentos.dpr` no Delphi 7.
2. Confirme o acesso às dependências no **Library Path** da IDE.
3. Configure os caminhos e as credenciais dos bancos Firebird.
4. Compile o projeto pelo menu **Project > Build**.
5. Disponibilize `MIDAS.DLL` e as demais bibliotecas de runtime necessárias junto ao executável.

## Uso

### Gerar a base de palavras

1. Faça backup dos bancos envolvidos.
2. Abra o menu **Processamento**.
3. Use **Prepara Tabelas** somente quando for necessário reiniciar a base de palavras e os controles de retomada.
4. Execute **Processamento Internacionais e Nacionais**.
5. Acompanhe os totais, a velocidade e o tempo estimado apresentados na tela.

O processamento normaliza as marcas, divide os textos em palavras, associa cada palavra às classes e atualiza os contadores conforme a situação do processo. O controle de retomada permite continuar uma execução interrompida.

> **Atenção:** a preparação das tabelas exclui e recria estruturas/dados usados pelo processamento. Não execute essa opção em uma base importante sem um backup validado.

Falhas individuais são gravadas em `log_processamento_palavras.txt`, no diretório do executável.

### Consultar uma palavra

1. Informe a palavra desejada.
2. Informe a classe.
3. Clique em **Buscar**.

A tela apresenta a palavra, a classe e as quantidades encontradas para cada situação contabilizada.

### Exportar JSON

Na tela de processamento, clique em **Exportar JSON**. Cada item exportado contém a palavra, sua classe e os respectivos contadores de ocorrências.

## Cuidados de manutenção

- O projeto é legado e trabalha com strings ANSI; preserve a codificação Windows-1252 dos arquivos Pascal e DFM existentes.
- Faça alterações de banco dentro das transações já utilizadas pelo sistema.
- Evite reduzir arbitrariamente o tamanho dos lotes: isso pode aumentar a quantidade de atualizações e prejudicar o desempenho.
- Valide mudanças com uma cópia dos bancos antes de executar em produção.
- Não versione bancos com dados reais, logs, executáveis, credenciais ou arquivos JSON gerados.
