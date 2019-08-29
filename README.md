# Fano Web Framework Skeleton Application

Example web application skeleton using Fano Framework, Pascal web application framework which demostrate how to use session.

This project is generated using [Fano CLI](https://github.com/fanoframework/fano-cli)
command line tools to help scaffolding web application using Fano Framework.

## Requirement

- [Free Pascal](https://www.freepascal.org/) >= 3.0
- Web Server (Apache, nginx)
- [Fano Web Framework](https://github.com/fanoframework/fano)

## Free Pascal installation

Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run

    $ fpc -i

If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.

## Clone this repository

    $ git clone git@github.com:fanofamework/fano-session.git --recursive

`--recursive` is needed so git also pull [Fano](https://github.com/fanoframework/fano) repository.

If you are missing `--recursive` when you clone, you may find that `vendor/fano` directory is empty. In this case run

    $ git submodule update --init

## Setup required configuration

Run

    $ ./tools/config.setup.sh

## Setup directory for sessions

Create directory `storages/sessions`

```
$ mkdir storages && mkdir storages/sessions
```

Setup permissions of `storages/sessions` to be writable by user which web server
run. For example in Debian, Apache is run as `www-data` user.

```
$ sudo chown your_user_name:www-data storages/sessions
$ chmod 775 storages/sessions
```

## Build application

Run

    $ ./build.sh

By default, it will output binary executable in `public` directory.

To build for different environment, set `BUILD_TYPE` environment variable.

### Build for production environment

    $ BUILD_TYPE=prod ./build.sh

Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.

### Build for development environment

    $ BUILD_TYPE=dev ./build.sh

Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.dev.cfg`.

If `BUILD_TYPE` environment variable is not set, production environment will be assumed.

## Run

### Run with a webserver

Setup a virtual host. Please consult documentation of web server you use.

This example project is a SCGI web application. You may want to read [Deployment as SCGI application](https://fanoframework.github.io/deployment/scgi/) for more information on how to setup virtual host to deploy SCGI web application.

## Deployment

You need to deploy only executable binary and any supporting files such as HTML templates, images, css stylesheets, application config.
Any `pas` or `inc` files or shell scripts is not needed in deployment machine in order application to run.

So for this repository, you will need to copy `public`, `Templates`, `config`
and `storages` directories to your deployment machine. make sure that
`storages` directory is writable by web server.

## Known Issues

### Issue with GNU Linker

When running `build.sh` script, you may encounter following warning:

```
/usr/bin/ld: warning: public/link.res contains output sections; did you forget -T?
```

This is known issue between FreePascal and GNU Linker. See
[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)

However, this warning is minor and can be ignored. It does not affect output executable.

### Issue with unsynchronized compiled unit with unit source

Sometime FreePascal can not compile your code because, for example, you deleted a
unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there
or when you switch between git branches. Solution is to remove those files.

Run `tools/clean.sh` to remove all compiled binaries generated during compilation.

```
$ ./tools/clean.sh
```

### Windows user

Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace
compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to
become `-WC`.

### Lazarus user

While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.
