defmodule Mastery.Core.Question do
  @moduledoc """
  Represent a question
  """

  # asked (string): The question text, for example, "1 + 2"
  # template (Template.t): The template that created the question
  # substitutions (%{substitution: any}): Values that will be placed on template.
  defstruct ~w[asked template substitutions]a
end
