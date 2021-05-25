# Use busybox for i686-linux since it works on x86_64-linux as well.
(import ./i686.nix) //

{
  #bootstrapTools = import <nix/fetchurl.nix> {
    #url = "http://tarballs.nixos.org/stdenv-linux/x86_64/c5aabb0d603e2c1ea05f5a93b3be82437f5ebf31/bootstrap-tools.tar.xz";
    #sha256 = "a5ce9c155ed09397614646c9717fc7cd94b1023d7b76b618d409e4fefd6e9d39";
  #};
  #bootstrapTools = ../../../../result-4/on-server/bootstrap-tools.tar.xz;

  # TODO Only for testing!
  # Built with `nix-build pkgs/stdenv/linux/make-bootstrap-tools.nix` and uploaded
  # `result-4/on-server/*`.
  busybox = import <nix/fetchurl.nix> {
    url = "https://intranet.mayflower.de/s/XPNdMtjWTdiGGsG/download/busybox";
    sha256 = "sha256-8fVm9kX0TpvgJo9to/wvqWv9Pz2Hr2u+8x5g7ZSGqr4=";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = "https://intranet.mayflower.de/s/XXTCb6MspFaJzPq/download/bootstrap-tools.tar.xz";
    sha256 = "sha256-oX/1hUlHruziFPok6f0lscgfGu3hGSxQjVf1ECE8rcU=";
  };
}
