#!/usr/bin/env nix-shell
#! nix-shell --pure -i python3 -p python3 cacert nix
import asyncio
import argparse
import json
import subprocess
from multiprocessing import cpu_count
from datetime import datetime, timezone
from pathlib import Path

# Directory of the current script
ROOT = Path(__file__).resolve().parent

# Nix command to fetch a port with
FETCH_ARGS = [
	"--extra-experimental-features",
	"nix-command flakes",
	"flake",
	"prefetch",
	"--json",
]

SOURCES_FILE = ROOT / "sources.json"


fetch_port_sem = asyncio.Semaphore(cpu_count())

async def fetch_port(port: str) -> dict:
	"""Fetch a Catppuccin port"""

	async with fetch_port_sem:
		repository = f"github:catppuccin/{port}"
		print(f"🔃 Fetching {repository}")

		command = FETCH_ARGS + [repository]
		proc = await asyncio.create_subprocess_exec("nix", *command, stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.DEVNULL)
		stdout, _ = await proc.communicate()

		if proc.returncode != 0:
			raise Exception(f"Failed to fetch {repository}")

		return json.loads(stdout)


def update_file_with(old_sources: dict, new_sources: dict):
	"""Update file with new sources only when needed"""
	if new_sources != old_sources:
		with open(SOURCES_FILE, "w") as f:
			json.dump(new_sources, f, indent=2, sort_keys=True)
	else:
		print("⚠ No updates made")


async def handle_port(sources: dict, port: str, remove=False):
	"""Handle updating a port in the given sources"""
	if remove:
		sources.pop(port, None)
		print(f"💣 Removed {port}")
	else:
		data = await fetch_port(port)
		locked = data["locked"]
		last_modified = datetime.fromtimestamp(int(locked["lastModified"]), tz = timezone.utc).strftime('%Y-%m-%d')
		sources[port] = {"rev": locked["rev"], "hash": data["hash"], "lastModified": last_modified}


async def main():
	cur_sources = dict()
	if SOURCES_FILE.exists():
		with open(SOURCES_FILE, "r") as f:
			cur_sources = json.load(f)

	parser = argparse.ArgumentParser(prog="paws")
	parser.add_argument("ports", default=cur_sources.keys(), nargs="*")
	parser.add_argument("-r", "--remove", action="store_true")
	args = parser.parse_args()

	assert (
		not args.remove or len(args.ports) > 0
	), "Ports must be provided when passing --remove"

	new_sources = cur_sources.copy()
	await asyncio.gather(
		*[handle_port(new_sources, port, remove=args.remove) for port in args.ports]
	)

	update_file_with(cur_sources, new_sources)

	print("✅ Done!")


asyncio.run(main())
