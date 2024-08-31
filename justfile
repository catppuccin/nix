# Print out all recipes when running `just`
_default:
  @just --list

# Variables
output_dir := "modules/lib"
output_file := "flavors.json"
whiskers_cmd := "whiskers"
template_path := "nix.tera"

# Create the output directory
setup:
  mkdir -p {{output_dir}}

# Remove previously generated file
clean:
  rm {{output_dir}}/{{output_file}}

# Generate "flavors.nix" file
gen:
  {{whiskers_cmd}} {{template_path}} > {{output_dir}}/{{output_file}}
