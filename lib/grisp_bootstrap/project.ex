# defmodule GrispBootstrap.Project do
#
#   def new(project_path, opts) do
#     project_path = Path.expand(project_path)
#     app = opts[:app] || Path.basename(project_path)
#     app_mod = Module.concat([opts[:module] || Macro.camelize(app)])
#
#     %Project{base_path: project_path,
#              app: app,
#              app_mod: app_mod,
#              root_app: app,
#              root_mod: app_mod,
#              opts: opts}
#   end
#
# end
