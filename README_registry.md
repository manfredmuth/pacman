# How to import an image in OpenShift

Quick wrap up of what we have in [KT article 6959306](https://access.redhat.com/solutions/6959306)

1 - Login to your cluster
```oc login -u ocpadmin -p <secure_password> --server=https://api.lab.example.com:6443```

And create q new project which will be the new home of your application.

```oc new-project pacman-demo```

2 - export a route to the OpenShift internal registry

```
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
oc get route -n openshift-image-registry
```

3 - Get the registryinformation into a local variable

```export REGISTRY=`oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}'` ```

4 - Login to the OpenShift registry

```podman login -u `oc whoami` -p `oc whoami --show-token` ${REGISTRY}```

Sometime, when using homebrewn TLS certificates, you need to skip the tls-verify

```podman login --tls-verify=false -u `oc whoami` -p `oc whoami --show-token` ${REGISTRY}```


5 - Tag the local image

```podman tag <local image_name>:<local version> <registry_login_server>/<project_name>/<destination image name>:<destination version>```

```podman tag registry.redhat.io/rhel9/postgresql-15:latest $REGISTRY/pacman-demo/postgresql-15:v15.0 ```

6 - Push the image to OpenShift

As OpenShift is very sensitive about signatures, we need need to be rude and use an option to convince OpenShift accepting the image

```podman push --remove-signatures $REGISTRY/<project_name>/postgresql-15:v15.0``` 
```podman push --remove-signatures $REGISTRY/pacman-demo/postgresql-15:v15.0``` 

7 - Check what you have done

```podman search $REGISTRY/<project_name>```
```podman search $REGISTRY/pacman-demo```
This should show you the image you just pushed to the OpenShift local Quay registry.

[<- Back to MAIN](./README.md)