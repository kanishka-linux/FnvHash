defmodule FnvHashTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest FnvHash

  test "fnv64a for hello.world" do
    assert FnvHash.fnv64a("hello.world") == 1_773_339_632_313_245_565
  end

  test "test whether hash is an integer and check its byte size for random string" do
    check all(list <- list_of(string(:ascii))) do
      list
      |> Enum.map(fn z ->
        fnv_hash = FnvHash.fnv64a(z)
        assert is_integer(fnv_hash)
        size = fnv_hash |> Integer.to_string() |> byte_size()
        assert size < 21
      end)
    end
  end

  test "test hash values from data file" do
    data_path = File.cwd!() |> Path.join("test_data/data.txt")
    {:ok, data_file} = File.open(data_path, [:read])
    content = IO.read(data_file, :all)
    File.close(data_file)

    String.split(content, "\n")
    |> Enum.filter(fn z -> z != "" end)
    |> Enum.map(fn z ->
      [hash_value, data] = String.split(z, "\t")
      assert FnvHash.fnv64a(data) == String.to_integer(hash_value)
    end)
  end
end
