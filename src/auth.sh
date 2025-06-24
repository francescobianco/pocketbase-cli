
pocketbase_auth() {
  local pocketbase_config
  local pocketbase_token
  local pocketbase_url
  local pocketbase_auth_collection
  local pocketbase_auth_username
  local pocketbase_auth_password
  local url

  pocketbase_config="$1"
  pocketbase_token="$2"

  pocketbase_url=$(sed -n 's/^PB_URL\s*=\s*\(.*\)/\1/p' "$pocketbase_config")
  pocketbase_auth_collection=$(sed -n 's/^PB_AUTH_COLLECTION\s*=\s*\(.*\)/\1/p' "$pocketbase_config")
  pocketbase_auth_username=$(sed -n 's/^PB_AUTH_USERNAME\s*=\s*\(.*\)/\1/p' "$pocketbase_config")
  pocketbase_auth_password=$(sed -n 's/^PB_AUTH_PASSWORD\s*=\s*\(.*\)/\1/p' "$pocketbase_config")

  url="$pocketbase_url/api/collections/$pocketbase_auth_collection/auth-with-password"

  echo "Using PocketBase config: $url"

  curl -s -X POST \
    -H "Content-Type: application/json" \
    -d '{"identity":"'"$pocketbase_auth_username"'","password":"'"$pocketbase_auth_password"'"}' \
    "$url" | sed 's/.*"token"://' | cut -d'"' -f2 > "$pocketbase_token"

  echo "Authenticating with PocketBase at $pocketbase_url"


  #echo "TEST" > "$pocketbase_token"
}

