defmodule GrispBootstrap.Project do

  alias GrispBootstrap.Project

  @version GrispBootstrap.MixProject.version()

  defstruct base_path: nil,
            app: nil,
            app_mod: nil,
            project_path: nil,
            opts: :unset,
            template_path: nil,
            media_path: nil

  def new(project_path, opts) do
    project_path = Path.expand(project_path)
    app = opts[:app] || Path.basename(project_path)
    app_mod = Macro.camelize(app)
    media_path = opts[:media_path] || "put media path here"

    version = @version

    template_path = Path.join(
      [
        Mix.Local.path_for(:archive),
        "grisp_bootstrap-#{version}",
        "grisp_bootstrap-#{version}",
        "priv",
        "template"
      ]
    )

    %Project{
      base_path: project_path,
      app: app,
      app_mod: app_mod,
      opts: opts,
      template_path: template_path,
      media_path: media_path
    }
  end

end
