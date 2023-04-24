# current-system

Like `builtins.currentSystem` but for accessing the native (current) "system" from the command line.

## Usage

```sh
# Get current system
$ nix run github:nix-systems/current-system
aarch64-darwin

# Get as JSON
$ nix run github:nix-systems/current-system -- --json
"aarch64-darwin"
```

