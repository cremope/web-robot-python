# web-robot-python

Projeto de automação de testes web utilizando Robot Framework com Python, executando via GitHub Actions e relatório publicado no GitHub Pages.

## Dependências
- Python: 3.11
- Robot Framework: 6.1.1
- SeleniumLibrary: 6.2.0

## Instalação
Baixando as dependências

```bash
  cd web-robot-python
  pip install -r requirements.txt
```

## Rodando os testes
Para rodar os testes, rode o seguinte comando

```bash
  robot --outputdir results tests
```

## Relatório dos testes
Relatório é gerado nativamente pelo Robot

Para visualizar o relatório de testes [Clique aqui](https://cremope.github.io/web-robot-python/)

## ScreenShots
<img src="https://github.com/cremope/web-robot-python/blob/main/ScreenShots/Log_Overview.png" width="400" /> 
<img src="https://github.com/cremope/web-robot-python/blob/main/ScreenShots/Report_Overview.png" width="400" /> 
<img src="https://github.com/cremope/web-robot-python/blob/main/ScreenShots/TC01_CaminhoFeliz_Overview.png" width="800" /> 
<img src="https://github.com/cremope/web-robot-python/blob/main/ScreenShots/TC02_FluxoValidacao_Overview.png" width="800" /> 