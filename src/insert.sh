
pocketbase_insert() {
  local pocketbase_config
  local pocketbase_token
  local pocketbase_url
  local collection
  local body
  local url

  pocketbase_config="$1"
  pocketbase_token="$2"
  collection="$3"

  shift 3 || true

  body="{"
  for arg in "$@"; do
      key="${arg%%=*}"
      value="${arg#*=}"
      body+="\"$key\":\"$value\","
  done
  body="${body%,}}"

  if [ -z "$collection" ]; then
    echo "Error: Collection name is required." >&2
    exit 1
  fi

  pocketbase_url=$(sed -n 's/^PB_URL\s*=\s*\(.*\)/\1/p' "$pocketbase_config")

  url="$pocketbase_url/api/collections/$collection/records"

  echo "Using PocketBase config: $body"

  curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $pocketbase_token" \
    -d "$body" \
    "$url"
}
