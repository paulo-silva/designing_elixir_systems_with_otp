defmodule Mastery.Core.Question do
  @moduledoc """
  Represent a question
  """

  alias Mastery.Core.Template

  # asked (string): The question text, for example, "1 + 2"
  # template (Template.t): The template that created the question
  # substitutions (%{substitution: any}): Values that will be placed on template.
  defstruct ~w[asked template substitutions]a

  def new(%Template{} = template) do
    template.generators
    |> Enum.map(&build_substitution/1)
    |> evaluate(template)
  end

  defp build_substitution({name, choices_or_generator}) do
    {name, choose(choices_or_generator)}
  end

  defp choose(choices) when is_list(choices) do
    Enum.random(choices)
  end

  defp choose(generator) when is_function(generator) do
    generator.()
  end

  defp evaluate(substitutions, template) do
    %__MODULE__{
      asked: compile(template, substitutions),
      substitutions: substitutions,
      template: template
    }
  end

  defp compile(template, substitutions) do
    template.compiled
    |> Code.eval_quoted(assigns: substitutions)
    |> elem(0)
  end
end
