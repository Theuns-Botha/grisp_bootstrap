defmodule Mix.Tasks.Grisp.New do
  @moduledoc """
  Generates a GRiSP application.
  """
  use Mix.Task

  alias GrispBootstrap.Project

  @switches [supervisor: :boolean]

  def run(args) do
    __ENV__.file |> IO.inspect()
    # {opts, root_path} = parse_opts(args)

    # root_path
    # |> Project.new(opts)
    # |> validate_project()
    # |> generate()

  end

  # def generate(%Project{} = project) do
  #   all_templates =
  #
  #   all_templates
  #   |> Stream.map(&render_eex/1)
  #   |> Stream.map(&copy_to_target/1)
  #   |> Stream.run
  # end
  #
  # defp validate_project(%Project{opts: opts} = project) do
  #   check_app_name!(project.app, !!opts[:app])
  #   project
  # end
  #
  # def prepare_project(%Project{app: app} = project) when not is_nil(app) do
  #   %Project{project | project_path: project.base_path}
  #   |> put_app()
  #   |> put_root_app()
  #   |> put_web_app()
  # end
  #
  # defp put_app(%Project{base_path: base_path} = project) do
  #   %Project{project |
  #            app_path: base_path}
  # end
  #
  # defp put_root_app(%Project{app: app, opts: opts} = project) do
  #   %Project{project |
  #            root_app: app,
  #            root_mod: Module.concat([opts[:module] || Macro.camelize(app)])}
  # end
  #
  # def generate(%Project{} = project) do
  #   copy_from project, __MODULE__, :new
  #   if Project.ecto?(project), do: Phx.New.Single.gen_ecto(project)
  #   project
  # end
  #
  # defp parse_opts(argv) do
  #   case OptionParser.parse(argv, strict: @switches) do
  #     {opts, [app_name], []} ->
  #       {opts, app_name}
  #     {_opts, [_arg | _more_args], []} ->
  #       Mix.raise "Invalid args, the mix task only accepts one"
  #     {_opts, [], []} ->
  #       Mix.raise "Please provide a base path for the app as argument"
  #     {_opts, _argv, [switch | _]} ->
  #       Mix.raise "Invalid option: " <> switch_to_string(switch)
  #   end
  # end
  # defp switch_to_string({name, nil}), do: name
  # defp switch_to_string({name, val}), do: name <> "=" <> val
  #
  # defp check_app_name!(app_name, from_app_flag) do
  #   unless name =~ recompile(~r/^[a-z][\w_]*$/) do
  #     extra =
  #       if !from_app_flag do
  #         ". The application name is inferred from the path, if you'd like to " <>
  #         "explicitly name the application then use the `--app APP` option."
  #       else
  #         ""
  #       end
  #
  #     Mix.raise "Application name must start with a letter and have only lowercase " <>
  #               "letters, numbers and underscore, got: #{inspect name}" <> extra
  #   end
  # end

  #
  # def render_eex({source, target}) do
  #   params = [
  #     root_module_name: &root_module/0,
  #     app_name_atom: &get_app_name_atom/0
  #   ]
  #   rendered = EEx.eval_file(source, params)
  #   {rendered, target}
  # end
  #
  # def copy_to_target({contents, target}) do
  #   if File.exists?(target) do
  #     status_msg("exists", target)
  #   else
  #     status_msg("creating", target)
  #     target_path = Path.dirname(target)
  #     File.mkdir_p(target_path)
  #     File.touch!(target)
  #     File.write!(target, contents)
  #   end
  # end
  #
  # defp check_directory_existence!(path) do
  #   if File.dir?(path) and not Mix.shell().yes?("The directory #{path} already exists. Are you sure you want to continue?") do
  #     Mix.raise "Please select another directory for installation."
  #   end
  # end
  #
  # defp elixir_version_check! do
  #   unless Version.match?(System.version, "~> 1.5") do
  #     Mix.raise "Phoenix v#{@version} requires at least Elixir v1.5.\n " <>
  #               "You have #{System.version()}. Please update accordingly"
  #   end
  # end

end
