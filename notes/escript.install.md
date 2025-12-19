
                              mix escript.install

Installs an escript locally.

If no argument is supplied but there is an escript in the project's root
directory (created with `mix escript.build`), then the escript will be
installed locally. For example:

    $ mix do escript.build + escript.install

If an argument is provided, it should be a local path to a prebuilt escript, a
Git repository, a GitHub repository, or a Hex package.

    $ mix escript.install escript
    $ mix escript.install path/to/escript
    $ mix escript.install git https://path/to/git/repo
    $ mix escript.install git https://path/to/git/repo branch git_branch
    $ mix escript.install git https://path/to/git/repo tag git_tag
    $ mix escript.install git https://path/to/git/repo ref git_ref
    $ mix escript.install github user/project
    $ mix escript.install github user/project branch git_branch
    $ mix escript.install github user/project tag git_tag
    $ mix escript.install github user/project ref git_ref
    $ mix escript.install hex hex_package
    $ mix escript.install hex hex_package 1.2.3

After installation, the escript can be invoked as

    $ ~/.mix/escripts/foo

For convenience, consider adding `~/.mix/escripts` directory to your `$PATH`
environment variable. For more information, check the wikipedia article on
PATH: https://en.wikipedia.org/wiki/PATH_(variable)

## Command line options

  * `--sha512` - checks the escript matches the given SHA-512 checksum.
    Only applies to installations via a local path
  * `--force` - forces installation without a shell prompt; primarily
    intended for automation in build systems like Make
  * `--submodules` - fetches repository submodules before building escript
    from Git or GitHub
  * `--sparse` - checkout a single directory inside the Git repository and
    use it as the escript project directory
  * `--app` - specifies a custom app name to be used for building the
    escript from Git, GitHub, or Hex
  * `--organization` - set this for Hex private packages belonging to an
    organization
  * `--repo` - set this for self-hosted Hex instances, defaults to `hexpm`

Location: /Users/rj/.asdf/installs/elixir/1.19.4-otp-28/lib/mix/ebin
