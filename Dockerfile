FROM elastichq/elasticsearch-hq

MAINTAINER Jeffery Bagirimvano

ENV ELASTICHQ_VERSION=release-v3.4.1

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="jefferyb/openshift-elastichq" \
      maintainer="Jeffery Bagirimvano" \
      version="${ELASTICHQ_VERSION}" \
      summary="Official Docker image for ElasticHQ using openshift specific guidelines" \
      description="Simplified Monitoring and Management for ElasticSearch clusters." \
### Required labels above - recommended below
      url="https://github.com/jefferyb/openshift-elastichq" \
      run='docker run -tdi --name elastichq -p 5000:5000 -u 1234567 jefferyb/openshift-elastichq' \
      io.k8s.description="Simplified Monitoring and Management for ElasticSearch clusters." \
      io.k8s.display-name="ElasticHQ" \
      io.openshift.expose-services="5000/tcp" \
      io.openshift.tags="ElasticHQ,arbitrary-uid,jefferyb,openshift,kubernetes"

### Setup user for build execution and application runtime
ENV APP_ROOT=/src
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} /var/log/supervisor && \
    chmod -R g=u ${APP_ROOT} /etc/passwd /var/log/supervisor

### Containers should NOT run as root as a good practice
USER 10001
WORKDIR ${APP_ROOT}

EXPOSE 5000

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]
CMD run

