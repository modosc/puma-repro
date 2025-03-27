## puma-repro

reproduction of exit code issue.

```bash
$ bundle install
$ docker build -t puma-repro .
# this returns a container id
$ docker run -itd puma-repro
caa0c3a8d1826fbe19a41c767c96d1929c80f169af7293136f05e9863bcf31ca
# now kill the container
$ docker kill --signal=TERM caa0c3a8d1826fbe19a41c767c96d1929c80f169af7293136f05e9863bcf31ca
# and look at the exit code
$ docker container ls -a |grep puma-repro
caa0c3a8d182   puma-repro                                              "bundle exec puma -b…"   2 minutes ago    Exited (1) About a minute ago                                        eager_hopper
```
