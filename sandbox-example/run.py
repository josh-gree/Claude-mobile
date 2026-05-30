import os
from e2b import Sandbox

api_key = os.environ["E2B_API_KEY"]

print("Creating sandbox...")
sbx = Sandbox.create("simple-example", api_key=api_key)

result = sbx.commands.run("python3 -c \"import cowsay; cowsay.cow('Hello from E2B!')\"")
print(result.stdout)
if result.stderr:
    print("stderr:", result.stderr)

sbx.kill()
print("Sandbox closed.")
