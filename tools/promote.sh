#!/usr/bin/env bash
# Usage: promote.sh <image-tag> <from-branch> <to-branch>
TAG=${1}
FROM=${2:-staging}
TO=${3:-prod}
REPO=git@github.com:your-org/apps-config.git

git clone ${REPO} tmprepo
cd tmprepo || exit 1

git checkout -b promote-${TAG}
# update prod values
yq e -i ".image.tag = \"${TAG}\"" prod/sample-app/values.yaml

git add prod/sample-app/values.yaml
git commit -m "chore: promote sample-app:${TAG} to prod"
git push origin promote-${TAG}
# Optionally open a PR via GitHub CLI

gh pr create --base ${TO} --head promote-${TAG} --title "Promote ${TAG} to ${TO}" --body "Automated promotion by CI"