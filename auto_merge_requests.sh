#!/bin/bash

case $1 in
    "--open")
        # Open merge request
        curl -vX POST "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/merge_requests" \
            -H "PRIVATE-TOKEN: ${PRIVATE_TOKEN}" \
            -H "Content-Type: application/json" \
            -d "{
                \"id\": ${CI_PROJECT_ID},
                \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
                \"target_branch\": \"${CI_DEFAULT_BRANCH}\",
                \"title\": \"${CI_COMMIT_REF_NAME}\",
                \"assignee_id\":\"${GITLAB_USER_ID}\"
                }";
        ;;
    "--enable")
        # Enable merge_when_pipeline_succeeds
        curl -vX PUT "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}/merge?merge_when_pipeline_succeeds=true" \
            -H "PRIVATE-TOKEN: ${PRIVATE_TOKEN}" \
            -H "Content-Type: application/json";
        ;;
    *)
        # Help menu
        echo "$0 arguments :"
        echo "  --open: open a merge request"
        echo "  --enable: enable merge_when_pipeline_succeeds"
        echo "  --help: show this help"
        ;;
esac