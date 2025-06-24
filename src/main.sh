
module insert

main() {
  local list
  local webui_config
  local webui_token

  while [ $# -gt 0 ]; do
    case "$1" in
      -*)
        case "$1" in
          --list)
            list=true
            shift
            ;;
          -o|--output)
            echo "Handling $1 with value: $2"
            shift
            ;;
          *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
        esac
        ;;
      *)
        break
        ;;
    esac
    shift
  done || true

  if [ -n "$WEBUI_CONFIG" ]; then
    webui_config=$WEBUI_CONFIG
  elif [ -f "$PWD/.webuirc" ]; then
    webui_config="$PWD/.webuirc"
  else
    webui_config="$HOME/.webuirc"
  fi

  if [ -n "$WEBUI_TOKEN" ]; then
    webui_token=$WEBUI_CONFIG
  elif [ -f "$PWD/.webuirc" ]; then
    webui_token="$PWD/.webuirc"
  else
    webui_token="$HOME/.webuirc"
  fi

  if [ -n "$list" ]; then
    my_print_list "$hosts"
    exit
  fi

  if [ "$#" -eq 0 ]; then
    error "No arguments supplied" 1
  fi

  case "$1" in
    insert)
      pocketbase_insert "$webui_config" "$webui_token"
      ;;
    *)
      error "Unknown command: $1" 1
      ;;
  esac
}
