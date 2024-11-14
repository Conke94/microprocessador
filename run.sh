#!/bin/bash

# Verifica se a flag -f foi passada e se tem um valor
while getopts "f:" opt; do
  case $opt in
    f) nome_do_arquivo=$OPTARG ;;
    *) echo "Uso: $0 -f <nome_do_arquivo>"; exit 1 ;;
  esac
done

# Verifica se o nome do arquivo foi fornecido
if [ -z "$nome_do_arquivo" ]; then
  echo "Erro: Nome do arquivo não fornecido."
  echo "Uso: $0 -f <nome_do_arquivo>"
  exit 1
fi

# Comandos GHDL
ghdl -a "${nome_do_arquivo}.vhd"
ghdl -e "${nome_do_arquivo}"
ghdl -a "${nome_do_arquivo}_tb.vhd"
ghdl -e "${nome_do_arquivo}_tb"

# Rodar a simulação e gerar o arquivo de onda
ghdl -r "${nome_do_arquivo}_tb" --wave="${nome_do_arquivo}_tb.ghw"

# Abrir o GTKWave com o arquivo de onda gerado
gtkwave "${nome_do_arquivo}_tb.ghw"
