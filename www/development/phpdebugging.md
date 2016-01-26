# PHP debugging

We use [Xdebug](https://xdebug.org/) for debugging purposes. For details, please refer to the [Xdebug documentation](https://xdebug.org/docs/).


## Environments

Xdebug is installed and enabled in all `DEV` [environments](../services/website.md#DEV).


## Debugging

Remote debugging is enabled by default in all `DEV` [environments](../services/website.md#DEV). To allow multiple debug sessions in multiple installations at the same time, a random port is assigned to each website at `xdebug.remote_port`. If your debug destination (e.g. PhpStorm) is on another machine, you have to reverse forward this debug port to your desired destination, e.g. `ssh -R 13377:localhost:13377 <username>@<hostname>`.

## Profiler

Profiling is disabled by default, enable it by setting `xdebug.profiler_enable = On` or you can trigger the generation of profiler files by using the `XDEBUG_PROFILE` GET/POST parameter, or set a cookie with the name `XDEBUG_PROFILE`. By default, profiler output well be written into the `~/tmp/` directory.

Warning: Enable profiling can generate a lot of data. Make sure your diskspace is sufficient to store this files and disable profiling as soon as possible

