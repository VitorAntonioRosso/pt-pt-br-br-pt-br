# Ato 1 — leitura aplicada

## Hierarquia das fontes

1. A solicitação do usuário define o entregável: um projeto funcional do Ato 1 e uma versão modular do prompt.
2. O PDF de referência orienta os fatos narrativos quando diverge das notas.
3. `os_sete_notas_unificadas PT II.txt` organiza o jogo em fases, mecânicas e produção.
4. O prompt anexado transforma isso em critérios técnicos e checklist.

## Reconciliações usadas

- O jogador encontra e marca a caixa; ela cai no primeiro içamento e só é recuperada na cutscene 1.5.
- O susto subaquático é um rangido amplificado e um cardume de espadinhas, sem inimigo.
- A caixa contém sete corpos; Inverno é o mais íntegro e recupera o nariz antes do movimento do dedo.
- Eliana se corta ao ser empurrada contra a lâmina da serra. A implementação usa uma `Area2D` chamada `SawBladeTrigger_Area2D`.
- O frio do galpão não vem de ar-condicionado: o aparelho foi retirado. Os aquecedores aparecem como parte da ambientação.

## Vertical slice implementada

`1.1 → 1.2 → 1.3 → 1.4 → 1.5 → 1.6 → 1.7 → 1.8 → 1.9 → Capítulo 2`.

As fases jogáveis são reais: condução da lancha, fotografia de três pontos, oxigênio, corrente, item do porão, inspeção `INFERNO? / INVERNO`, limpeza e leitura das sete inscrições e acionamento do corte.
