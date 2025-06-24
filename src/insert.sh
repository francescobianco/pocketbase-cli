
pocketbase_insert() {
  local pocketbase_config
  local pocketbase_token
  local pocketbase_url
  local collection
  local url

  pocketbase_config="$1"
  pocketbase_token="$2"
  collection="$3"

  if [ -z "$collection" ]; then
    echo "Error: Collection name is required." >&2
    exit 1
  fi

  pocketbase_url=$(sed -n 's/^PB_URL\s*=\s*\(.*\)/\1/p' "$pocketbase_config")

  url="$pocketbase_url/api/collections/$collection/records"

  echo "Using PocketBase config: $url"

  curl -s -v -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $pocketbase_token" \
    -d "{
      \"field1\": \"value1\",
      \"field2\": \"value2\"
    }" \
    "$url"
}
