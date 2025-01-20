{
  buildCatppuccinPort,
  fetchFromGitHub,
  lib,
}:
let
  # Each Firefox addon has an ID used to refer to it in the config
  # Unfortunately, the Catppuccin addons just use randomly generated ones
  addonIds = {
    latte = {
      rosewater = "{42698af3-f4a0-4864-8a72-236e99d30345}";
      flamingo = "{80a64fa5-f058-482c-a2fc-ec0c329a5910}";
      pink = "{7f327fa3-57ad-4f5a-a638-0c8620df3cad}";
      mauve = "{c827c446-3d00-4160-a992-3ebcbe6d81a6}";
      red = "{7d4f99bc-5b1c-4e97-b1c1-cae24282eb71}";
      maroon = "{1f6e25ab-cdbe-4a7a-90fb-911ced38df69}";
      peach = "{6ea607a1-ee07-4f56-8349-5a257725b6c9}";
      yellow = "{fbf67366-a9d5-40fb-aa10-5e2eb7d74d08}";
      green = "{98439b1c-46b2-4e72-8b58-7b996112f199}";
      teal = "{556ffa71-63b9-4ab8-822d-feb18097f961}";
      sky = "{0711a452-8a57-4697-9ee2-5161fc77fe89}";
      sapphire = "{fe7fd83c-01c2-4de1-b055-fdcc122e94fb}";
      blue = "{68f3538d-3881-45f4-aa73-288b010b39a1}";
      lavender = "{bc6fdbef-4c18-4967-9899-7803fdcaf3b4}";
    };
    frappe = {
      rosewater = "{d39d5a2f-2f99-4744-b904-793881cbc306}";
      flamingo = "{cb69ead4-b74b-4efa-a49b-8d921eca8947}";
      pink = "{b6129aa9-e45d-4280-aac8-3654e9d89d21}";
      mauve = "{5630de1f-49cb-41ef-934d-2343026b25a5}";
      red = "{32577cb5-8803-4b2b-8d9c-f962ef0ce277}";
      maroon = "{d2b153b6-07ae-46ea-8f79-cae317fd8be0}";
      peach = "{89d0f64f-9088-4b50-861e-35c50c0ef909}";
      yellow = "{0146c14f-d2b3-4b1e-8e93-7cb301c231fc}";
      green = "{106ca6d4-1fbf-4665-b968-88a3ff31de3a}";
      teal = "{615b2812-7ab8-4ea5-bb8a-c62bf4b1a4b1}";
      sky = "{c7cf6786-24b7-4bd2-ae71-b985fcc98f20}";
      sapphire = "{c52d6318-7734-4ac5-a909-2f12b0f0f3b1}";
      blue = "{0f28d17a-46f0-4fe1-8696-1676de0a87f2}";
      lavender = "{5ee380f7-abda-467c-ae9a-d30bf8f0d1d6}";
    };
    macchiato = {
      rosewater = "{a5726845-3a00-4076-8601-b9b943dfcddc}";
      flamingo = "{03f8dbf5-5054-44b3-9443-4bb24d981e90}";
      pink = "{e554e180-24a4-40a2-911d-bf48d5b1629c}";
      mauve = "{998d0435-a079-4dcc-ad24-7333b3463bca}";
      red = "{a5c9c2ff-855c-4c6e-a0f0-52e7c1b48a01}";
      maroon = "{4c302124-e622-4a6a-9a9e-55ffde4e80a9}";
      peach = "{4dfd877b-8072-4d5b-b271-768bbdc78e53}";
      yellow = "{b7582732-61a1-4708-b726-73691837fedd}";
      green = "{5dff4698-8117-41cd-8377-de57f671d736}";
      teal = "{658bd4ed-c245-454a-8fd6-fd9de5e1b046}";
      sky = "{5d96985c-7004-413b-bd17-3a0e334d898b}";
      sapphire = "{32ff0ff3-110d-4c2e-9134-005bba3f1b64}";
      blue = "{d49033ac-8969-488c-afb0-5cdb73957f41}";
      lavender = "{15cb5e64-94bd-41aa-91cf-751bb1a84972}";
    };
    mocha = {
      rosewater = "{5b78178f-135d-4df2-821f-1f289be7f348}";
      flamingo = "{49783482-0579-4c89-9b46-674b2c8d3c53}";
      pink = "{0a2d1098-69a9-4e98-a62c-a861766ac24d}";
      mauve = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
      red = "{6f70b243-f2a4-4e65-ab41-4e75a6efb65a}";
      maroon = "{48a265ac-f603-4262-b0e7-2a55c159aaef}";
      peach = "{3a271e29-2654-4dcc-9186-745deca0b17f}";
      yellow = "{b99d94a7-f494-49b1-8dc1-face82d0a941}";
      green = "{f4363cd3-9ba9-453d-b2b2-66e6e1bafe73}";
      teal = "{409be3b6-54bf-47c8-83d2-9bd43e0730e3}";
      sky = "{1ac25999-353e-49bf-a064-1d0690bb3ec9}";
      sapphire = "{b2e54022-c8a0-444f-8d7c-bc7282cadbd2}";
      blue = "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}";
      lavender = "{8446b178-c865-4f5c-8ccc-1d7887811ae3}";
    };
  };
in
buildCatppuccinPort {
  pname = "firefox";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "firefox";
    rev = "refs/tags/old";
    hash = "sha256-ZIK0LX8OJOBr20diRDQRrNc1X+q3DtHNcc/dRZU2QfM=";
  };

  # Split package into outputs of each flavor/accent combination
  # in order to avoid polluting the user's extensions and flooding them with extension installed notifications
  # "out" is just there to avoid a build error
  outputs =
    [
      "out"
    ]
    ++ (lib.flatten (
      lib.mapAttrsToList (
        flavor: accents: (lib.mapAttrsToList (accent: _: "${flavor}_${accent}") accents)
      ) addonIds
    ));

  # There is a build script in $src that we do not want to run
  dontBuild = true;
  dontCatppuccinInstall = true;

  installPhase = ''
    runHook preInstallHook

    # Create $out just to avoid a build error
    mkdir $out

    ${lib.concatStrings (
      lib.flatten (
        lib.mapAttrsToList (
          flavor: accents:
          (lib.mapAttrsToList (
            accent: id:
            # Code adapted from `buildFirefoxXpiAddon` from
            # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/default.nix
            ''
              dst="''$${flavor}_${accent}/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
              mkdir -p "$dst"
              install -v -m644 "$src/releases/old/catppuccin_${flavor}_${accent}.xpi" "$dst/${id}.xpi"
            '') accents)
        ) addonIds
      )
    )}

    runHook postInstallHook
  '';

  passthru = { inherit addonIds; };
}
