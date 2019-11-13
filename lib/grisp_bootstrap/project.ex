defmodule GrispBootstrap.Project do

  alias GrispBootstrap.Project

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

    __DIR__ |> IO.inspect()
    |> ls_r()
    |> IO.inspect()

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
  def ls_r(path \\ ".") do
    cond do
      File.regular?(path) -> [path]
      File.dir?(path) ->
        File.ls!(path)
        |> Enum.map(&Path.join(path, &1))
        |> Enum.map(&ls_r/1)
        |> Enum.concat
      true -> []
    end
  end

end
