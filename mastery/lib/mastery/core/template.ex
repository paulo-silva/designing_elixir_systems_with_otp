defmodule Mastery.Core.Template do
  @moduledoc """
  Generate Questions
  """

  # - name (atom): The Template name
  # - category (atom): A grouping for questions of the same name.
  # - instructions (string): String telling how to answer questions of this type.
  # - raw (string): The template code before compilation
  # - compiled (macro): Compiled version of the template for execution.
  # - generators (%{substitution: list or function}): The generator for each substitution in a template.
  # - checker (function(substitutions, string) -> boolean): Validate if the answer is correct
  defstruct ~w[name category instructions raw compiled generators checker]a

  def new(fields) do
    raw = Keyword.fetch!(fields, :raw)

    struct!(
      __MODULE__,
      Keyword.put(fields, :compiled, EEx.compile_string(raw))
    )
  end
end
