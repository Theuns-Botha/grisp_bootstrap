defmodule GrispBootstrap.Project do

  defstruct base_path: nil,
            app: nil,
            app_mod: nil,
            root_app: nil,
            root_mod: nil,
            project_path: nil,
            opts: :unset,
            template_path: nil

  def new(project_path, opts) do
    project_path = Path.expand(project_path)
    app = opts[:app] || Path.basename(project_path)
    app_mod = Module.concat([opts[:module] || Macro.camelize(app)])

    template_path = Path.join([Mix.Project.build_path(), "lib", "grisp_bootstrap", "priv", "template"])

    %Project{
      base_path: project_path,
      app: app,
      app_mod: app_mod,
      root_app: app,
      root_mod: app_mod,
      opts: opts,
      template_path: template_path
    }
  end

end
