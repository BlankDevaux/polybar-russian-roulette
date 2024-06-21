#!/usr/bin/env bash
#
# Installs Russian Roulette and its dependencies

readonly CMD=$1

function copy_ini() {
  default_ini_path="$HOME/.config/polybar/modules"
  read -p "Enter the path you want to copy RussianRoulette.ini into [${default_ini_path}]: " ini_path
  cp RussianRoulette.ini ${ini_path:-$default_ini_path}
}

function copy_script() {
  default_script_path="$HOME/.config/polybar/scripts"
  read -p "Enter the path you want to copy roulette.sh into [${default_script_path}]: " script_path
  script_path=${script_path:-$default_script_path}
  mkdir -p $script_path
  cp roulette.sh $script_path
  chmod +x $script_path/roulette.sh
}

function get_config_files() {
  default_config_path="$HOME/.config/polybar/bars"
  read -p "Enter the path where your Polybar config files are located [${default_config_path}]: " config_path
  config_path=${config_path:-$default_config_path}
  mapfile config_files < <(ls $config_path)
}

function set_roulette_module() {
  local config_files
  get_config_files
  
  default_config_file_index=0
  
  config_file_selector="Select the config file you want to put your Russian Roulette in [$default_config_file_index]:"$'\n'
  for i in "${!config_files[@]}"; do
    config_file_selector="$config_file_selector  $i) ${config_files[i]}"
  done
  read -rep "$config_file_selector" config_file_index

  config_file_index=${config_file_index:-$default_config_file_index}
  for i in "${!config_files[@]}"; do
    case $config_file_index in
      $i)
        config_file="$config_path/${config_files[$i]}"
      ;;
    esac
  done

  sides=("left" "center" "right")
  default_side_index=0
  side_selector="Pick a side [$default_side_index]:"$'\n'
  for i in "${!sides[@]}"; do
    side_selector="$side_selector  $i) ${sides[i]}"$'\n'
  done
  read -rep "$side_selector" side_index

  side_index=${side_index:-$default_side_index}
  for i in "${!sides[@]}"; do
    case $side_index in
      $i)
        side="modules-${sides[$i]}"
      ;;
    esac
  done

  read -a existing_modules <<< "$(grep $side $config_file | sed 's/.*=//')"
  # mapfile existing_modules < <(grep $side $config_file | sed 's/.*=//' | tr -d ' ')

  default_module_placement_index=0
  module_placement_selector="Select where to put the module on $side [$default_module_placement_index]:"$'\n'
  for i in "${!existing_modules[@]}"; do
    module_placement_selector="$module_placement_selector  $i) Before ${existing_modules[i]}"$'\n'
  done
  module_placement_selector="$module_placement_selector  ${#existing_modules[@]}) At the end"$'\n'
  read -rep "$module_placement_selector" module_placement_index

  if [ "$module_placement_index"="${#existing_modules[@]}" ];
  then
    modules=(${existing_modules[@]} "russian-roulette")
  else
    modules=([module_placement_index]=russian-roulette "${existing_modules[@]:module_placement_index}")
  fi
  modules="$side = ${modules[@]// / }"

  # sed -i -e "s/./$side = ${modules[@]// / }/" "$config_file"
  echo "$(grep $side $config_file)"
  sed -i '' "s/.*$(grep $side $config_file).*/$modules/" $config_file
  echo "Hello World!"
}

function install() {
  $(copy_script)
  $(copy_ini)
  echo "$(set_roulette_module)"
}

case $CMD in
  *)
    install
  ;;
esac