# Note: MacOs only because sed takes different arguments

VERSION=$(rg -oP 'version = "\K[^\"]*' **/arc-browser.nix)
HASH=$(nix-prefetch-url https://releases.arc.net/release/Arc-$VERSION.dmg)
COMPUTED=$(nix hash convert --from nix32 --to base64 --hash-algo sha256 $HASH)
sed -E -i '' "s/(sha256-)[^\"]*([\"])/\1${COMPUTED}\2/g" **/arc-browser.nix
