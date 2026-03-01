# pdf-test

GitHub Actions test to automatically generate C.V Updates.

## Local PDF build (Apple Silicon)

Build the Docker image targeting Apple Silicon and run it to generate the PDF:

```sh
docker build --platform=linux/arm64 -t cv-pdf .
mkdir -p output
docker run --rm -v "$PWD/output:/output" cv-pdf
```

## PDF publishing workflow

This repo includes a GitHub Actions workflow that converts `docs/DISCOVERY.md` into a PDF and commits it to another repository.

Configuration (edit in `.github/workflows/publish-pdf.yml`):

- `DEST_REPO`: target repository in `owner/name` form.
- `DEST_BRANCH`: target branch (default `main`).
- `DEST_PATH`: folder in the target repo to receive the PDF.
- `DEST_FILE`: PDF filename in the target repo.

Secrets required in this repo:

- `DEST_REPO_TOKEN`: a PAT with write access to the destination repository.
