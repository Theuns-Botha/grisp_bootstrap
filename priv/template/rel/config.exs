# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    default_release: :default,
    default_environment: :grisp

environment :grisp do
  set include_erts: true
  set include_src: false
  set cookie: :"GRiSP"
end

release :grisp_blink do
  set version: current_version(:grisp_blink)
end
