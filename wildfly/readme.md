# Wildfly and ELK logging

This wildfly image handles json logging through ELK.

JSON Llogs are written to stdout.

You'll need a solution to route stdout to logstash (i.e. logspout).

## Usage

To start the image:

```
docker run -p 8080:8080 wildfly-config-cli 
```

To start the image without JSON logging:

```
docker run -p 8080:8080 -e LOGGING_LAYOUT=TEXT wildfly-config-cli
```

## Customizing the configuration

Environment variables:

| Name              | Description                                                                   |
| ----------------- |:-----------------------------------------------------------------------------:|
| LOGGING_LAYOUT    | Logging output to stdout<b>Accepted values: TEXT, JSON<br>Default value: JSON |

The image contains some scripts you can call in child images:

* /opt/jboss/wildfly/customization/execute.sh
  allows to execute a list of jboss-cli scripts.
  jboss server is started in admin mode at image build time to update the jboss configuration.
  Usage:
```
  execute.sh <jboss-mode> script1.cli script2.cli...
```

## Build

docker build --rm --tag wildfly-config-cli

## References

http://blog.arungupta.me/getting-started-elk-stack-wildfly/

https://wildfly.org/news/2015/07/25/Wildfly-And-ELK/
