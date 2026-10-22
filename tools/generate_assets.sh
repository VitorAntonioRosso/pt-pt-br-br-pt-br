#!/usr/bin/env bash
set -euo pipefail

# Gera os PNGs locais a partir das ilustrações SVG autorais do Ato 1.
# O jogo carrega somente PNG em runtime; os SVGs ficam como fontes editáveis.

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
asset_cache="${TMPDIR:-/tmp}/os-sete-asset-cache"
mkdir -p "$asset_cache/config" "$asset_cache/cache" "$asset_cache/inkscape"
export XDG_CONFIG_HOME="$asset_cache/config"
export XDG_CACHE_HOME="$asset_cache/cache"
export INKSCAPE_PROFILE_DIR="$asset_cache/inkscape"
mkdir -p "$root_dir/assets/generated"
for source in "$root_dir"/assets/source/*.svg; do
  name="$(basename "$source" .svg)"
  output="$root_dir/assets/generated/$name.png"
  if [[ "$name" == "menu_bg" || "$name" == "boat_map" || "$name" == "dive_exterior" || "$name" == "dive_interior" || "$name" == "lab_map" || "$name" == cutscene_* ]]; then
    inkscape "$source" --export-type=png --export-filename="$output" --export-width=1152 --export-height=648 >/dev/null
  else
    inkscape "$source" --export-type=png --export-filename="$output" >/dev/null
  fi
done
