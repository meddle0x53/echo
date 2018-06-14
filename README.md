# OTP example with LFE : Echo

Both examplifies building a very simple OTP application with LFE and compiling it
with Mix.

The mix compiler for LFE is used (https://github.com/meddle0x53/mix_lfe).
Can be used as a template for a similar project.

## Running the example

Has to be set up, using the `mix_lfe` plugin for Mix.
It can be installed like this:

```
mix archive.install https://github.com/meddle0x53/mix_lfe_new/releases/download/v0.1.0/mix_lfe_new-0.2.0.ez
```

Now the project can be downloaded, set up and compilet like this:

```
git clone https://github.com/meddle0x53/echo
cd echo

mix lfe.setup
mix compile
```

This will compile the LFE code and will generate the app file.
It can be tested with `mix`:

```bash
iex -S mix
```

Now the application will be running and can be accessed through Elixir:

```elixir
"test" = :"echo-worker".echo("test") # Returns what was passed to it.
1 = :"echo-worker".count() # Returns how many times the :"echo-worker".echo/1 function was called.
```

It can be used in LFE too:

```bash
./deps/lfe/bin/lfe -pa _build/dev/lib/*/ebin
```

And now:

```lisp
> (application:ensure_all_started 'echo)
#(ok (echo))

> (echo-worker:echo #"bla")
#"bla"
> (echo-worker:count)
1

> (echo-worker:echo #"boo")
#"boo"
> (echo-worker:count)
2
```

It has a simple test doing similar checks to the above ones.
Run it with:

```
mix lfe.test
```
