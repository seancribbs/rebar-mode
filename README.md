# Emacs Rebar mode

Rebar mode provides convenience functions for dealing with Rebar and eUnit.

## Installation
I recommend installing via ELPA, but manual installation is simple as well:

    (add-to-list 'load-path "/path/to/rebar-mode")
    (require 'rebar-mode)

## Usage
If `rebar-mode` is installed properly, it will be started
automatically when `erlang-mode` is started.

See `rebar-mode.el` for further usage.

## Gotchas

Currently in development, it may not be suitable for anything in particular,
though I'd like to be able to run eunit tests straight from a buffer and get
code coverage annotations beside my erlang code.

Other ideas or code is most welcome.

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Update the version and changelog in the header of rebar-mode.el to reflect the change.
 * Send me a pull request.
