# PROMPT ÚNICO — OS SETE: BLOCO DO ATO 1

## Função deste arquivo

Este é o primeiro bloco modular do prompt geral. Ele pode ser executado sozinho para produzir, testar ou polir somente o **Ato 1 — A Descoberta**. O Ato 2 deve entrar depois como outro bloco, sem exigir que este texto repita ou reimplemente o Ato 1.

## Fontes e hierarquia

Use as notas unificadas para estrutura de jogo e o PDF como autoridade factual quando houver divergência. A solicitação do usuário define o entregável. Não copie longos trechos do romance: converta os fatos em cenas, objetivos, falas curtas e mecânicas originais.

## Entregável

Entregue um projeto Godot 4.x 2D executável e jogável de ponta a ponta:

`1.1 → 1.2 → 1.3 → 1.4 → 1.5 → 1.6 → 1.7 → 1.8 → 1.9 → “Capítulo 2 — O Despertar.”`

Inclua cenas reais, scripts GDScript comentados em português, assets locais, menu, save/continue, pausa, créditos, README, estado de assets e tarefas futuras. Rode o projeto e relate somente o que foi verificado.

## Restrições fixas do bloco

1. Godot 4.x e GDScript.
2. 2D puro: sem nós 3D e sem câmera 3D.
3. Ato 1 sem combate e sem inimigos. Não criar barras de vida, ataques ou perseguição.
4. Lancha em vista de cima; mergulho em vista lateral; laboratório em top-down 3/4.
5. A caixa é encontrada e marcada no mergulho. No primeiro içamento ela cai de volta; a recuperação acontece na cutscene 1.5.
6. O susto é o rangido amplificado e o cardume; não usar jumpscare com monstro.
7. A caixa mostra sete corpos; Inverno é o mais íntegro, com o nariz se formando antes do dedo se mover.
8. Eliana se corta na lâmina da serra durante a abertura. O gatilho precisa ser uma `Area2D` na lâmina.
9. O frio do laboratório surge sem ar-condicionado ligado; aquecedores são pontos de ambientação.
10. Todo asset carregado em runtime deve existir localmente e ter origem documentada. Não use hotlink, logo ou material protegido.

## Fases e critérios

### 1.1 — Abertura HQ

Apresente praia de Amarração, Tiago, César e Olavo, a caravela e a decisão de mergulhar. Avançar por quadros com `E`/Enter/clique.

### 1.2 — Lancha

Controle top-down, mar calmo, ponto de mergulho e âncora. Diálogos curtos podem aparecer como mensagens. A fase só termina depois que o jogador chega à boia e confirma a âncora.

### 1.3 — Fenda e casco

Oxigênio decrescente e HUD com alertas. O jogador fotografa três pontos: casco sem arranhões, escotilhas lacradas e portinhola de canhão. Uma corrente empurra o mergulhador; uma tartaruga ou fauna serve como respiro ambiental. Depois de três fotos, encontre a abertura entre paredão e casco.

### 1.4 — Porão

Escuridão, algas, musgo, rangido amplificado e cardume. Recolha uma peça, encontre a caixa prateada de 800 kg, aceite a leitura inicial `INFERNO?` e revele `INVERNO`. Marque a caixa com cabo-guia e retorne à abertura. Não faça o jogador içar a caixa nesta fase.

### 1.5 — Salvamento HQ

Mostre balões laranja, a proa cedendo, a caixa caindo de volta e a recuperação no dia seguinte pela USPA.

### 1.6 — Galpão HQ

Mostre laboratório improvisado nas docas, plástico prateado, cientistas, soldados, caixa limpa e as sete inscrições.

### 1.7 — Laboratório

Top-down 3/4. Eliana limpa a caixa, lê `Lobo, Tempestade, Inverno, Gentil, Espelho, Acordador, Sétimo` e inspeciona o aviso. Ao completar os registros, aproxime-se da serra.

### 1.8 — Corte HQ

A multidão empurra Eliana contra a lâmina. O corte é pequeno e sangra muito; o sangue escorre para dentro da caixa.

### 1.9 — Sangue em Inverno HQ

O frio cresce sem fonte. Mostre sete corpos, destaque o corpo mais íntegro, o nariz se formando, a gota de sangue, silêncio e um dedo se movendo. Termine com `Capítulo 2 — O Despertar.`

## Qualidade e validação

- Abra no Godot 4 sem erros de carregamento.
- Faça o fluxo inteiro sem recurso ausente.
- Verifique que menu, novo jogo, continuar, pausa e save funcionam.
- Verifique oxigênio, lanterna/visibilidade, corrente, três fotos, entrada, item, inscrição e `Area2D` da serra.
- Confirme que não há inimigos nem combate.
- Registre limitações de arte, áudio e polimento em `docs/ASSET_STATUS.md`; nunca chame placeholder de asset final.

## Regra para blocos seguintes

Quando o Ato 1 estiver verde, acrescente um novo arquivo `PROMPT_UNICO_OS_SETE_ATO_2.md` com as próprias cenas, mecânicas, assets e critérios. O bloco novo deve reutilizar sistemas estáveis, não reabrir o escopo do Ato 1 e declarar explicitamente o que foi testado.
