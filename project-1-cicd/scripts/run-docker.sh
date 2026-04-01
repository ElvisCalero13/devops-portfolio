
#!/usr/bin/env bash
set -e

docker build -t project-1-cicd -f docker/Dockerfile .

docker run --rm -p 8000:8000 \
  -e APP_ENV=local \
  -e APP_VERSION=local-dev \
  project-1-cicd