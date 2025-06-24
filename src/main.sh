
module auth
module insert

main() {
  local list
  local pocketbase_config
  local pocketbase_token
  local collection

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

  if [ -n "$PB_CONFIG" ]; then
    pocketbase_config=$PB_CONFIG
  elif [ -f "$PWD/.pocketbaserc" ]; then
    pocketbase_config="$PWD/.pocketbaserc"
  else
    pocketbase_config="$HOME/.pocketbaserc"
  fi

  pocketbase_token="$(dirname "$pocketbase_config")/.pocketbaserc.token"
  echo "Using PocketBase config: $pocketbase_config"
  if [ -f "$pocketbase_token" ]; then
    pocketbase_token=$(cat "$pocketbase_token")
  else
    pocketbase_auth $pocketbase_config $pocketbase_token
    pocketbase_token=$(cat "$pocketbase_token")
  fi

  echo "Using PocketBase token: $pocketbase_token"

  if [ "$#" -eq 0 ]; then
    error "No arguments supplied" 1
  fi

  case "$1" in
    insert)
      echo "Running insert command"
      collection="$2"
      shift || true
      pocketbase_insert "$pocketbase_config" "$pocketbase_token" "$collection" "$@"
      ;;
    *)
      error "Unknown command: $1" 1
      ;;
  esac
}
