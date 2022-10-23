defmodule ExCsv.CLI do
  def main(args \\ []) do
    {path, type} =
      args
      |> parse_args()

    apply(
      ExCsv,
      String.to_atom("puts_#{type}"),
      [ExCsv.import!(path)]
    )
  end

  defp parse_args(args) do
    {[path: path, type: type], _, _} =
      args
      |> OptionParser.parse(strict: [path: :string, type: :string])

    {path, type}
  end
end
