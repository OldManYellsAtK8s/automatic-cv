# pdf-test

GitHub Actions test to automatically generate C.V Updates.

## PDF publishing workflow

This repo includes a GitHub Actions workflow that converts `docs/DISCOVERY.md` into a PDF and commits it to another repository.

Configuration (edit in `.github/workflows/publish-pdf.yml`):
- `DEST_REPO`: target repository in `owner/name` form.
- `DEST_BRANCH`: target branch (default `main`).
- `DEST_PATH`: folder in the target repo to receive the PDF.
- `DEST_FILE`: PDF filename in the target repo.

Secrets required in this repo:
- `DEST_REPO_TOKEN`: a PAT with write access to the destination repository.
