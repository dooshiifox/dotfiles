{ lib, ... }: rec {
  nix-to-python =
    i:
    if builtins.isAttrs i then
      let
        table = builtins.concatStringsSep ", " (
          builtins.attrValues (
            builtins.mapAttrs (
              name: value:
              let
                snake_case = lib.replaceString "-" "_" (nix-to-python name);
              in
              "${snake_case}: ${nix-to-python value}"
            ) i
          )
        );
      in
      "{ ${table} }"
    else if builtins.isList i then
      let
        list = builtins.concatStringsSep ", " (map nix-to-python i);
      in
      "[ ${list} ]"
    else if builtins.isString i then
      "\"${i}\""
    else
      toString i;
}
