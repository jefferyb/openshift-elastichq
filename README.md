# jefferyb/openshift-elastichq

ElasticHQ image built to run on Openshift/Kubernetes/Docker environment.

## Using Openshift CLI

```bash
# Deploy ElasticHQ
$ oc new-app --name=elastichq -e HQ_DEFAULT_URL=http://elasticsearch:9200 jefferyb/openshift-elastichq

# Expose the service
$ oc expose svc/elastichq
```

## Using Docker

```bash
# Deploy ElasticHQ
$ docker run -itd --name elastichq -p 5000:5000 -e HQ_DEFAULT_URL=http://elasticsearch:9200 jefferyb/openshift-elastichq

### After a few sec. you should be able to access it at port 5000
```
