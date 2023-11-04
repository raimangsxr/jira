[![docker pulls](https://img.shields.io/docker/pulls/rromani/jira.svg)](https://hub.docker.com/r/rromani/jira/)  [![docker stars](https://img.shields.io/docker/stars/rromani/jira.svg)](https://hub.docker.com/r/rromani/jira/)

Here is my personal Helm charts repo: [K8s Helm repo](https://github.com/rromani/charts)


# Jira

## How to get Jira key

```
docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
    -p jira \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to get Jira plugin key

- For example, I want to use BigGantt plugin
1. Install BigGantt from Jira marketplace.
2. Find `App Key` of BigGantt is : `eu.softwareplant.biggantt`
3. Execute :

```
docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. Paste your license 

## How to get Jira Service Management(jsm) plugin key

```
docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
    -p jsm \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org/ \
    -s you-server-id
```

