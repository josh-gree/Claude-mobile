import os
from e2b import Sandbox

api_key = os.environ["E2B_API_KEY"]

print("Creating sandbox with OpenCode...")
sbx = Sandbox.create(
    "simple-example",
    api_key=api_key,
    envs={"OPENCODE_API_KEY": os.environ.get("OPENCODE_API_KEY", "")},
)

# Verify opencode is installed
result = sbx.commands.run("opencode --version")
print("OpenCode version:", result.stdout.strip())

sbx.kill()
print("Done.")
