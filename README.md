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

`1.1 abertura → 1.2 lancha → 1.3 fenda → 1.4 porão → 1.5 içamento → 1.6 laboratório → 1.7 investigação → 1.8 corte → 1.9 despertar, matança roteirizada e fuga → fim do Ato 1`.

O Ato 1 não possui combate jogável nem inimigos controlados por IA. O despertar de Inverno e a morte dos médicos e guardas são uma sequência roteirizada, sugerida por sombras, silhuetas, som e iluminação. Depois há uma fuga curta em top-down 3/4, sem sistema de combate.

O título de trabalho para o capítulo seguinte é **Capítulo 2 — A Fuga de Inverno**. Ele é uma proposta de nomenclatura; o Ato 2 ainda não está implementado.

## Câmeras e apresentação

- 2D puro em todas as fases jogáveis.
- Lancha: vista de cima.
- Mergulho: vista lateral, com câmera 2D e visibilidade limitada pela lanterna.
- Laboratório e fuga final do Ato 1: top-down 3/4, com `Camera2D`, Y-sort e iluminação 2D.
- Cutscenes: quadros HQ independentes da câmera de jogo, com `AnimationPlayer` quando houver animação.

## Arquitetura

- `scenes/acto1/`: uma cena por fase.
- `scripts/core/`: estado, save e base da HUD.
- `scripts/phases/`: mecânica de cada fase.
- `scripts/ui/`: menu e sistema de quadros HQ.
- `assets/source/`: fontes SVG autorais.
- `assets/generated/`: PNGs carregados pelo jogo.
- `docs/`: decisões, tarefas e estado dos assets.
- `tools/`: geração de assets e smoke tests.

Gere novamente os PNGs com `bash tools/generate_assets.sh` se editar os SVGs.

## Nota de escopo

Esta entrega implementa o Ato 1 inteiro. Os Atos 2–4 não são simulados nem declarados como prontos. O próximo prompt modular está em [`PROMPT_UNICO_OS_SETE_ATO_1.md`](PROMPT_UNICO_OS_SETE_ATO_1.md).
