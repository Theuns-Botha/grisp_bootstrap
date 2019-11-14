defmodule Mix.Tasks.Grisp.New do
  @moduledoc """
  Generates a GRiSP application.
  """
  use Mix.Task

  alias GrispBootstrap.Project

  @template_path "priv/template"

  @raw_copy [
    "rel/vm.args"
  ]

  @ls_r_func fn(path) ->
    cond do
      File.regular?(path) -> [path]
      File.dir?(path) ->
        File.ls!(path)
        |> Enum.map(&Path.join(path, &1))
        |> Enum.map(fn(var) -> @ls_r_func.(var) end)
        |> Enum.concat
      true -> []
    end
  end

  @dot_files (Enum.map(@ls_r_func.(@template_path), fn(file_path) ->
      Path.relative_to(file_path, @template_path)
    end)
    |> Enum.filter(fn(path) ->
      case Path.basename(path) <> Path.extname(path) do
        "dot" <> _other -> true
        _other -> false
      end
    end)
  )

  @templates (Enum.map(@ls_r_func.(@template_path), fn(file_path) ->
      Path.relative_to(file_path, @template_path)
    end) -- (@raw_copy ++ @dot_files)
  )

  @switches [media_path: :string, supervisor: :boolean]

  def run(args) do
    {opts, root_path} = parse_opts(args)

    root_path
    |> Project.new(opts)
    # |> validate_project()
    |> generate()
  end

  def generate(%Project{template_path: template_path} = project) do
    @raw_copy
    |> Enum.map(fn(template_file) -> target_tuple(:dot, template_file, project) end)
    |> Stream.map(fn(config) -> render_raw(config, project) end)
    |> Stream.map(&copy_to_target/1)
    |> Stream.run

    @dot_files
    |> Enum.map(fn(template_file) -> target_tuple(:dot, template_file, project) end)
    |> Stream.map(fn(config) -> render_eex(config, project) end)
    |> Stream.map(&copy_to_target/1)
    |> Stream.run

    @templates
    |> Enum.map(fn(template_file) -> target_tuple(:normal, template_file, project) end)
    |> Stream.map(fn(config) -> render_eex(config, project) end)
    |> Stream.map(&copy_to_target/1)
    |> Stream.run
  end

  def target_tuple(:raw, template_file, %{base_path: base_path, template_path: template_path, app: app}) do
    {
      Path.join(template_path, template_file),
      String.replace(Path.join(base_path, template_file), "<%= app %>", app)
    }
  end

  def target_tuple(:dot, template_file, %{base_path: base_path, template_path: template_path, app: app}) do
    {
      Path.join(template_path, template_file),
      String.replace(Path.join(base_path, String.replace(template_file, "dot_", ".")), "<%= app %>", app)
    }
  end

  def target_tuple(:normal, template_file, %{base_path: base_path, template_path: template_path, app: app}) do
    {
      Path.join(template_path, template_file),
      String.replace(Path.join(base_path, template_file), "<%= app %>", app)
    }
  end

  defp parse_opts(argv) do
    case OptionParser.parse(argv, strict: @switches) |> IO.inspect() do
      {opts, [app_name], []} ->
        {opts, app_name}
      {_opts, [_arg | _more_args], []} ->
        Mix.raise "Invalid args, the mix task only accepts one"
      {_opts, [], []} ->
        Mix.raise "Please provide a base path for the app as argument"
      {_opts, _argv, [switch | _]} ->
        Mix.raise "Invalid option: " <> switch_to_string(switch)
    end
  end
  defp switch_to_string({name, nil}), do: name
  defp switch_to_string({name, val}), do: name <> "=" <> val

  def render_raw({source, target}, %Project{} = project) do
    Enum.to_list(Map.from_struct(project))
    rendered = File.read!(source)
    {rendered, target}
  end

  def render_eex({source, target}, %Project{} = project) do
    bindings = Map.from_struct(project)
    |> Enum.to_list()
    rendered = EEx.eval_file(source, bindings)
    {rendered, target}
  end

  def copy_to_target({contents, target}) do
    if File.exists?(target) do
      status_msg("exists", target)
    else
      status_msg("creating", target)
      target_path = Path.dirname(target)
      File.mkdir_p(target_path)
      File.touch!(target)
      File.write!(target, contents)
    end
  end

  @doc false
  def status_msg(status, message),
    do: IO.puts "#{IO.ANSI.green}* #{String.rjust(status, 10)}#{IO.ANSI.reset} #{message}"

  @doc false
  def debug(message), do: IO.puts "==> #{message}"
  @doc false
  def info(message),  do: IO.puts "==> #{IO.ANSI.green}#{message}#{IO.ANSI.reset}"
  @doc false
  def warn(message),  do: IO.puts "==> #{IO.ANSI.yellow}#{message}#{IO.ANSI.reset}"
  @doc false
  def notice(message), do: IO.puts "#{IO.ANSI.yellow}#{message}#{IO.ANSI.reset}"
  @doc false
  def error(message), do: IO.puts "==> #{IO.ANSI.red}#{message}#{IO.ANSI.reset}"

end
