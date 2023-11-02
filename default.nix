(import
  (
    fetchTarball {
      url = "https://github.com/edolstra/flake-compat/archive/0f9255e01c2351cc7d116c072cb317785dd33b33.tar.gz";
      sha256 = "sha256-kvjfFW7WAETZlt09AgDn1MrtKzP7t90Vf7vypd3OL1U=";
    }
  )
  { src = ./.; }
).defaultNix
