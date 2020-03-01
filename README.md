# GITLAB AUTO MERGE REQUEST

<img src="https://assets.gitlab-static.net/uploads/-/system/project/avatar/15684701/Octicons-git-pull-request.svg.png" width="200" height="200"/>


## INDEX

  - [INDEX](#index)
  - [BADGES](#badges)
  - [FIRST UPDATE](#first-update)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [USE](#use)
  - [LICENSE](#license)


## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/gitlab_auto_merge_requests/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/gitlab_auto_merge_requests/commits/master)


## INTRODUCTION

With this script, every time we push a commit, GitLab CI checks if the branch that commit belongs to already has an open merge request and, if not, it creates it. It then assigns the merge request to you and select merge when pipeline succeeds.

Docker image of :

- [gitlab_auto_merge_requests](https://github.com/oda-alexandre/gitlab_auto_merge_requests)

Continuous integration on :

- [gitlab](https://gitlab.com/oda-alexandre/gitlab_auto_merge_requests/pipelines)

Automatically updated on :

- [docker hub public](https://hub.docker.com/r/alexandreoda/gitlab_auto_merge_requests/)


## PREREQUISITES

### 1. Use [gitlab-ci](https://docs.gitlab.com/ee/ci/introduction/)

### 2. Allow merge requests to be merged if the pipeline succeeds

1. Log in to GitLab.
2. Navigate to your project’s Settings > General page.
3. Expand the Merge requests section.
4. In the Merge checks subsection, select the Pipelines must succeed checkbox.
5. Press Save for the changes to take effect.
   
<img src="https://docs.gitlab.com/ee/user/project/merge_requests/img/merge_when_pipeline_succeeds_only_if_succeeds_settings.png" />

### 3. Create a personal access token

1. Log in to GitLab.
2. In the upper-right corner, click your avatar and select Settings.
3. On the User Settings menu, select Access Tokens.
4. Choose a name expiry date "optional" and scope "api" for the token.
5. Click the Create personal access token button.
6. Save the personal access token somewhere safe. Once you leave or refresh the page, you won’t be able to access it again.

<img src="https://images.squarespace-cdn.com/content/v1/5303cdc2e4b01fb736d82734/1557321361423-F78U9WS7NI3W6KUCN29W/ke17ZwdGBToddI8pDm48kKRIxJw6JXQsGoBfMy22rgkUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKcXMgrqKFUlKKTB7iVgGQWiibKadpQIqE8BEk2KjXNgNch2G43s4DdYMywhv8CEFGU/gitlab-access-token-details-2.png" />

### 4. Create a variable for your token to your project’s Settings

1. Navigate to your project’s Settings > CI/CD > Variables.
2. Paste PRIVATE_TOKEN on Key and your token on Value
3. Active Masked option
4. Press Save for the changes to take effect.

<img src="https://i.stack.imgur.com/9sRJD.png" />


## USE

### Options

> Usage : auto_merge_requests.sh [commande]

COMMANDE            | DESCRIPTION
--------------------|----------------------------------------------------------
--open              | open a merge request
--enable            | enable merge_when_pipeline_succeeds
--help              | show this help

### Add stages for auto merge requests

Paste this on your ```gitlab-ci.yml``` :

```yml
stages:
  - staging
  - deploy

open_merge:
  stage: staging
  allow_failure: false
  script:
    - docker run --rm
        --env CI_PROJECT_ID=${CI_PROJECT_ID}
        --env CI_COMMIT_REF_NAME=${CI_COMMIT_REF_NAME}
        --env CI_DEFAULT_BRANCH=${CI_DEFAULT_BRANCH}
        --env GITLAB_USER_ID=${GITLAB_USER_ID}
        --env PRIVATE_TOKEN=${PRIVATE_TOKEN}
        alexandreoda/gitlab_auto_merge_requests
        bash auto_merge_requests.sh --open
  only: 
    - dev

enable_merge:
  stage: deploy
  allow_failure: false
  script:
    - docker run --rm
        --env CI_PROJECT_ID=${CI_PROJECT_ID}
        --env CI_COMMIT_REF_NAME=${CI_COMMIT_REF_NAME}
        --env CI_DEFAULT_BRANCH=${CI_DEFAULT_BRANCH}
        --env GITLAB_USER_ID=${GITLAB_USER_ID}
        --env PRIVATE_TOKEN=${PRIVATE_TOKEN}
        alexandreoda/gitlab_auto_merge_requests
        bash auto_merge_requests.sh --enable
  only: 
    - merge_requests
```

### If you add Schedules without change in the project

Paste this on your ```README.md``` :

## FIRST UPDATE

Date: 01-01-01


And paste this on your ```gitlab-ci.yml``` :

```yml
stages:
  - date

date:
  stage: date
  allow_failure: false
  script:
    - echo -e '\033[36;1m ******* DATE ******** \033[0m'
    - "date=$(date +\"%Y-%m-%d\") && sed -i \"s/^Date: .*/Date: $date/\" README.md"
  only:
    - dev
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/gitlab_auto_merge_requests/blob/master/LICENSE)
