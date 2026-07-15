#!/usr/bin/env bash
set -euo pipefail
<<<<<<< HEAD

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

=======
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
terraform destroy
