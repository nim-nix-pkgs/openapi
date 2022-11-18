{
  description = ''OpenAPI Code Generator'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-openapi-master.flake = false;
  inputs.src-openapi-master.ref   = "refs/heads/master";
  inputs.src-openapi-master.owner = "disruptek";
  inputs.src-openapi-master.repo  = "openapi";
  inputs.src-openapi-master.type  = "github";
  
  inputs."npeg".owner = "nim-nix-pkgs";
  inputs."npeg".ref   = "master";
  inputs."npeg".repo  = "npeg";
  inputs."npeg".dir   = "0_27_0";
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
  
  inputs."github-disruptek-rest".owner = "nim-nix-pkgs";
  inputs."github-disruptek-rest".ref   = "master";
  inputs."github-disruptek-rest".repo  = "github-disruptek-rest";
  inputs."github-disruptek-rest".dir   = "1_0_5";
  inputs."github-disruptek-rest".type  = "github";
  inputs."github-disruptek-rest".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-disruptek-rest".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-openapi-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-openapi-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}