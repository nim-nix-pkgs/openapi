{
  description = ''OpenAPI Code Generator'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-openapi-2_0_1.flake = false;
  inputs.src-openapi-2_0_1.ref   = "refs/tags/2.0.1";
  inputs.src-openapi-2_0_1.owner = "disruptek";
  inputs.src-openapi-2_0_1.repo  = "openapi";
  inputs.src-openapi-2_0_1.type  = "github";
  
  inputs."npeg".owner = "nim-nix-pkgs";
  inputs."npeg".ref   = "master";
  inputs."npeg".repo  = "npeg";
  inputs."npeg".dir   = "1_0_0";
  inputs."npeg".type  = "github";
  inputs."npeg".inputs.nixpkgs.follows = "nixpkgs";
  inputs."npeg".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."foreach".owner = "nim-nix-pkgs";
  inputs."foreach".ref   = "master";
  inputs."foreach".repo  = "foreach";
  inputs."foreach".dir   = "1_0_2";
  inputs."foreach".type  = "github";
  inputs."foreach".inputs.nixpkgs.follows = "nixpkgs";
  inputs."foreach".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-openapi-2_0_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-openapi-2_0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}