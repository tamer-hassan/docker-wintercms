# Automat

__Self contained automated update management.__

This cron container automatically clones this repository and runs [update.sh](https://github.com/mik-p/docker-wintercms/blob/master/update.sh). It is intended to run indefinitely in detached mode to poll the [Winter CMS](https://wintercms.com/) API for updates.

When an update is found, the changed __version__ and __Dockerfiles__ are pushed back to the origin repository. The commit triggers an automated build process for the  [Docker Hub image hiltonbanes/wintercms](https://hub.docker.com/r/hiltonbanes/wintercms/).


## Getting Started

Build the automat image

```shell
$ cd automat
$ docker build -t docker-wintercms-automat .
```

Run the container (detached mode)

> Timezone (optional), git user info, repository key and Slack webhook (optional) are passed as environment variables when the container is created. Notice `GIT_REPO_KEY` is read in dynamically.


```shell
$ docker run \
  --name docker-wintercms-automat \
  -d --restart always \
  -e TZ="Australia/Sydney" \
  -e GIT_USER_EMAIL="automat@domain.tld" \
  -e GIT_USER_NAME="Automat" \
  -e GIT_REPO_KEY="$(cat automat.id_rsa)" \
  -e SLACK_WEBHOOK_URL="https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX" \
  docker-wintercms-automat
```

The script will output process information to the container logs which can be review by running:

```shell
$ docker logs -f docker-wintercms-automat
```

If you've passed along a Slack webhook, you'll get pinged when a stable update has been pushed.


## More information

 - [Managing deploy keys on GitHub](https://developer.github.com/guides/managing-deploy-keys/#deploy-keys)
 - [Setting up Slack notifications via webhooks](https://api.slack.com/incoming-webhooks)
