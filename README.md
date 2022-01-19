# nginx-reverse-proxy

nginx-reverse-proxy provides ability of reverse-proxy into your local machine with a minimal nginx configurations.

## Getting Started
```
$ git clone https://github.com/zoopeter/nginx-reverse-proxy

$ docker build -tag nginx-reverse-proxy:1.0 .
$ docker run -d -p 80:8080 nginx-reverse-proxy:1.0
```

## Configuration
There are two parts of configure points in order to make nginx-reverse-proxy meet your taste.

- /etc/hosts: makes fake domains directs to your localhost.
- ./config/conf.d/site.conf: is the actual place to set your upstreams.

### Set Fake Domains
Open to edit `/etc/hosts`
```
$ sudo vim /etc/hosts
```

Add below lines to the file
```
# Fake Domains
127.0.0.1       ping.your-domain.com
127.0.0.1       upstream.4000.your-domain.com
# and so on ...
```

### Set Upstreams
Open to edit `./config/conf.d/site.conf`
```
$ vim ./config/conf.d/site.conf
```

You can add upstreams like this:
```
upstream backend {
  server  host.docker.internal:4000;
  keepalive 100;
}
```
(Note that host.docker.internal directs host machine from the docker)

You can also add listener of fake domain and set proxy-pass to your upstream like this:
```
server {
  listen  8080;
  server_name upstream.4000.your-domain.com;

  location / {
    proxy_pass http://backend;
  }
}
```

### Re-build & run new version of your docker image
You are almost there. Enter below commands to re-build & run
```
$ docker ps
$ docker kill <container_id>

$ docker build -tag nginx-reverse-proxy:1.1 .
$ docker run -d -p 80:8080 nginx-reverse-proxy:1.1
```

Now, everything is done!

Enjoy your hacking!
