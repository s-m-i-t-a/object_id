defmodule ObjectId do
  @moduledoc """
  Object ID helpers.
  """

  @doc ~S"""
  Converts BSON.ObjectId struct to a string representation.

  ## Examples

      iex> {:ok, oid} = ObjectId.from_string("57188e9dfdec465bfa003e91")
      iex> ObjectId.to_string(oid)
      {:ok, "57188e9dfdec465bfa003e91"}

      iex> ObjectId.to_string(1234)
      {:error, "'1234' isn't ObjectID!"}
  """
  @spec to_string(BSON.ObjectId.t()) :: Result.t(String.t(), String.t())
  def to_string(pk) do
    try do
      Result.ok(BSON.ObjectId.encode!(pk))
    rescue
      FunctionClauseError -> Result.error("'#{pk}' isn't ObjectID!")
    end
  end

  @doc ~S"""
  Converts string representation of ObjectId to a BSON.ObjectId struct

  ## Examples

      iex> ObjectId.from_string("57188e9dfdec465bfa003e91")
      {:ok, BSON.ObjectId.decode!("57188e9dfdec465bfa003e91")}

      iex> ObjectId.from_string("foobarbaz")
      {:error, "'foobarbaz' isn't string representation of ObjectID!"}
  """
  @spec from_string(String.t()) :: Result.t(String.t(), BSON.ObjectId.t())
  def from_string(pk) when is_binary(pk) do
    try do
      Result.ok(BSON.ObjectId.decode!(pk))
    rescue
      FunctionClauseError -> Result.error("'#{pk}' isn't string representation of ObjectID!")
    end
  end
end
