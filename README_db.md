# Create a postgresQL image {#create_psql}

We decided to go with a manually created image to show how the standard deplyoment workflow looks like. And we can show which basic steps are needed to get your own image into the local registry of your OpenShift cluster.

As we pull the image from the Red Hat registry, we need to login first.

```podman login registry.redhat.io```

Just for the records, this is how we would start the container image locally with local storage attached

```podman volume create pgdata```

Note: This step is redundant here and could be skipped. But in case you want to check out other available and maintained images. Here you are:

Have look at the [registry of Red Hat](https://registry.redhat.io). You find hints in the documentation for any image and how to use it.

```podman pull registry.redhat.io/rhel9/postgresql-15```

This example will pull the images and start it with your settings of choice.

```
podman run -d --name postgres-ubi \
  -e POSTGRESQL_USER=admin \
  -e POSTGRESQL_PASSWORD=<YOUR_DB_PASSWORD> \
  -e POSTGRESQL_DATABASE=appdb \
  -p 5432:5432 \
  -v pgdata:/var/lib/pgsql/data \
  registry.redhat.io/rhel9/postgresql-15
``` 
And we can test the locally running DB just to get a bit familiar with container handling. Remember the mantra ***"A container is a running instance of an image"***.

```podman exec -it postgresql_database /bin/bash```

This way you can connect to the DB and test out if postgresQL was started:

> bash-5.1$ psql -h localhost -U user -p -d db -p 5432
> db=> select * from pg_tables;

And here you should see some relevant output. Leave the psql shell by using
>\q 


[<- Back to MAIN](./README.md)