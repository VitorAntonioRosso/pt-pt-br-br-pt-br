# Ato 1 — leitura aplicada

## Atualização de escopo — final do Ato 1

O Ato 1 agora termina depois de o sangue de Eliana cair em Inverno: ele desperta, mata médicos e guardas do laboratório em uma sequência roteirizada e foge. O terror deve ser sugerido por sombras, sons, silhuetas e iluminação; não há combate jogável no Ato 1. Depois da matança existe uma fuga curta em top-down 3/4, que pode ser jogável.

O título proposto para o capítulo seguinte é **Capítulo 2 — A Fuga de Inverno**. O despertar não é mais o título do capítulo seguinte porque acontece dentro do Ato 1.

O Ato 5 (cripta) está fora do escopo e não deve ser criado ou usado para preencher lacunas.

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
- A matança do laboratório é roteirizada, sem barra de vida, ataque, inimigo ou combate. A câmera pode acompanhar silhuetas e portas, mas não deve mostrar a violência de modo explícito.
- A lancha usa vista de cima; o mergulho permanece lateral; o laboratório e a fuga usam top-down 3/4 com câmera 2D, Y-sort e iluminação 2D.
- As cutscenes usam quadros HQ; quando houver movimento, a cena deve ter `AnimationPlayer`.

## Vertical slice implementada

`1.1 → 1.2 → 1.3 → 1.4 → 1.5 → 1.6 → 1.7 → 1.8 → 1.9 (despertar, matança e fuga) → fim do Ato 1`.

As fases jogáveis previstas são: condução da lancha, fotografia de três pontos, oxigênio, corrente, item do porão, inspeção `INFERNO? / INVERNO`, limpeza e leitura das sete inscrições, acionamento do corte e, na nova versão, uma fuga curta top-down 3/4 depois da sequência roteirizada.

## Câmeras aplicadas

- **Seção 1:** 2D puro; referência de câmera top-down 3/4 em Zelda: The Minish Cap. Don’t Starve Together e Cult of the Lamb entram como referências de clima e composição, convertidas para 2D puro.
- **Seção 3:** tabelas de fases devem ter coluna `Câmera`. Terra e fuga ficam em top-down 3/4; lancha fica em vista de cima; mergulho fica lateral; HQ é independente.
- **Seção 4:** câmera segue o jogador nas fases jogáveis; usar Y-sort na perspectiva 3/4. Grades Tactics futuras usam a mesma lógica top-down.
- **Seção 7:** sprites de personagens para terra usam vista top-down 3/4 e sprite sheet com quatro direções; a arte de referência atual permanece preservada.
- **Seção 8:** cenários de galpão e ruas usam top-down 3/4, tileset em grade e camadas separadas; o subaquático permanece lateral.
- **Seção 10:** incluir `Camera2D`, Y-sort, TileMap/tileset em camadas e iluminação/som 2D.
- **Seção 11:** Gemini gera arte; LibreSprite ajusta sprites e animações; LDtk/Tiled monta mapas; Bfxr/SFXR e Audacity produzem e editam áudio. Essas ferramentas não recebem prompts de texto como um gerador de imagem.
