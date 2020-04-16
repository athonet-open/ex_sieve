defmodule ExSieve.Utils do
  @moduledoc false

  alias ExSieve.Config

  @spec get_error(list(any), Config.t()) :: list(any) | {:error, atom}
  @spec get_error(list(any), Config.t(), Keyword.t()) :: list(any) | {:error, atom}

  def get_error(items, config, acc \\ [])

  def get_error([{:error, reason} | _], %Config{ignore_errors: false}, _acc), do: {:error, reason}
  def get_error([{:error, _} | t], config, acc), do: get_error(t, config, acc)
  def get_error([item | t], config, acc), do: get_error(t, config, [item | acc])
  def get_error([], _config, acc), do: acc

  def filter(list, only, except) do
    cond do
      is_list(only) -> list -- list -- only
      is_list(except) -> list -- except
      true -> list
    end
  end
end
