# Os Sete — A Descoberta

Vertical slice jogável do Ato 1, feita em Godot 4.6.3, como homenagem não comercial ao autor André Vianco.

## Rodar

1. Instale Godot 4.6 ou compatível.
2. Abra esta pasta no editor.
3. Execute o projeto (`F6` para testar a cena atual ou `F5` para o menu).

O projeto também é validado sem interface com:

```bash
godot4 --headless --path . --editor --quit
```

## Controles

- `WASD` ou setas: mover/nadar/conduzir.
- `E`, `Enter` ou `Espaço`: avançar, fotografar e interagir.
- `Esc`: pausa.

## Fluxo do Ato 1

`1.1 abertura → 1.2 lancha → 1.3 fenda → 1.4 porão → 1.5 içamento → 1.6 laboratório → 1.7 investigação → 1.8 corte → 1.9 Inverno → Capítulo 2`.

O Ato 1 não possui combate nem inimigos. O medo vem da água escura, oxigênio, corrente, madeira rangendo, cardume e frio.

## Arquitetura

- `scenes/acto1/`: uma cena por fase.
- `scripts/core/`: estado, save e base da HUD.
- `scripts/phases/`: mecânica de cada fase.
- `scripts/ui/`: menu e sistema de quadros HQ.
- `assets/source/`: fontes SVG autorais.
- `assets/generated/`: PNGs carregados pelo jogo.
- `docs/`: decisões, tarefas e estado dos assets.

Gere novamente os PNGs com `bash tools/generate_assets.sh` se editar os SVGs.

## Nota de escopo

Esta entrega implementa o Ato 1 inteiro. Os Atos 2–4 não são simulados nem declarados como prontos. O próximo prompt modular está em [`PROMPT_UNICO_OS_SETE_ATO_1.md`](PROMPT_UNICO_OS_SETE_ATO_1.md).
