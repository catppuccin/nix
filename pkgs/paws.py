#!/usr/bin/env nix-shell
#! nix-shell --pure -i python3 -p python3 cacert nix
import argparse
import json
import subprocess
from pathlib import Path

# Directory of the current script
ROOT = Path(__file__).resolve().parent

# Nix command to fetch a port with
FETCH_COMMAND = [
	"nix",
	"--extra-experimental-features",
	"'nix-command flakes'",
	"flake",
	"prefetch",
	"--json",
]

SOURCES_FILE = ROOT / "sources.json"


# Fetch a port with the above command
def fetch_port(port: str) -> dict:
	repository = f"github:catppuccin/{port}"
	print(f"🔃 Fetching {repository}")
	command = FETCH_COMMAND + [repository]
	result = subprocess.run(command, capture_output=True, check=True, text=True)
	return json.loads(result.stdout)


# Update file with new sources when needed
def update_file_with(old_sources: dict, new_sources: dict):
	if new_sources != old_sources:
		with open(SOURCES_FILE, "w") as f:
			json.dump(new_sources, f, separators=(",", ":"), sort_keys=True)
	else:
		print("⚠ No updates made")


cur_sources = dict()
if SOURCES_FILE.exists():
	with open(SOURCES_FILE, "r") as f:
		cur_sources = json.load(f)

parser = argparse.ArgumentParser(prog="paws")
parser.add_argument("ports", default=cur_sources.keys(), nargs="*")
parser.add_argument("-r", "--remove", action="store_true")
args = parser.parse_args()

new_sources = cur_sources.copy()
for port in args.ports:
	if args.remove:
		new_sources.pop(port, None)
		print(f"💣 Removed {port}")
	else:
		locked = fetch_port(port)["locked"]
		new_sources[port] = {"rev": locked["rev"], "hash": locked["narHash"]}

update_file_with(cur_sources, new_sources)

print("✅ Done!")
