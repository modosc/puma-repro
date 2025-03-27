## puma-repro

reproduction of exit code issue.

## container example

```bash
$ bundle install
$ docker build -t puma-repro .
$ docker run -it puma-repro
$ docker run -it puma-repro
Puma starting in single mode...
* Puma version: 6.6.0 ("Return to Forever")
* Ruby version: ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [aarch64-linux]
*  Min threads: 0
*  Max threads: 5
*  Environment: development
*          PID: 1
* Listening on http://0.0.0.0:3000
Use Ctrl-C to stop
```

in another terminal:

```bash
$ docker ps |grep puma-repro
d5e835a18867   puma-repro        "bin/puma -b tcp://0…"   39 seconds ago   Up 39 seconds                                                 jolly_leavitt
$ docker kill --signal=TERM d5e835a18867
d5e835a18867
```

in the first container we see `puma` exiting gracefully but the exit code is 1:

```bash
- Gracefully stopping, waiting for requests to finish
$ echo $?
1
```

you can also see this in `docker`:

```bash
work ~/git/horizon-api [main|⚑ 82]$ docker container ls -a |grep puma-repro
d5e835a18867   puma-repro                                              "bin/puma -b tcp://0…"   2 minutes ago    Exited (1) About a minute ago                                        jolly_leavitt
```

## terminal example

```bash
$ bin/puma -b tcp://0.0.0.0:3000 config.ru
Puma starting in single mode...
* Puma version: 6.6.0 ("Return to Forever")
* Ruby version: ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin24]
*  Min threads: 0
*  Max threads: 5
*  Environment: development
*          PID: 15308
* Listening on http://0.0.0.0:3000
Use Ctrl-C to stop
```

in another terminal:

```bash
$ kill -TERM 15308
```

back in the first:

```bash
- Gracefully stopping, waiting for requests to finish
Terminated: 15
$ echo $?
143
```
