#!/usr/bin/env python3
"""Test both generators against an exact analyzer constraint in clean packages."""

import json
import pathlib
import shutil
import subprocess
import sys
import tempfile


def main():
    version = sys.argv[1] if len(sys.argv) > 1 else "11.0.0"
    repository = pathlib.Path(__file__).resolve().parent.parent
    for name in ("autoequal_gen", "equatable_gen"):
        with tempfile.TemporaryDirectory(prefix=f"{name}_compatibility_") as folder:
            root = pathlib.Path(folder)
            shutil.copytree(repository / name / "test", root / "test")
            spec = {
                "name": f"{name}_compatibility_test",
                "publish_to": "none",
                "environment": {"sdk": ">=3.9.0 <4.0.0"},
                "dependencies": {
                    name: {"path": str(repository / name)},
                    "analyzer": version,
                    "build_runner": "^2.11.1",
                    "build_test": "^3.5.4",
                    "generator_test": "^0.6.0",
                    "equatable": "^2.0.5",
                    "test": "^1.24.9",
                },
            }
            (root / "pubspec.yaml").write_text(json.dumps(spec), encoding="utf-8")
            subprocess.run(["dart", "pub", "get"], cwd=root, check=True)
            dependencies = json.loads(
                subprocess.check_output(
                    ["dart", "pub", "deps", "--json"], cwd=root, text=True
                )
            )
            actual = next(
                package["version"]
                for package in dependencies["packages"]
                if package["name"] == "analyzer"
            )
            if actual != version:
                raise RuntimeError(f"Expected analyzer {version}, resolved {actual}")
            print(f"Testing {name} with analyzer {actual}", flush=True)
            subprocess.run(["dart", "test"], cwd=root, check=True)


if __name__ == "__main__":
    main()
