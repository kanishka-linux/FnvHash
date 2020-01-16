defmodule FnvHash do
  use Bitwise
  @fnv_offset 14_695_981_039_346_656_037
  @fnv_prime 1_099_511_628_211
  @fnv_size :math.pow(2, 64) |> round

  def fnv64a(data) do
    data
    |> to_charlist()
    |> Enum.reduce(@fnv_offset, fn z, acc -> rem(bxor(acc, z) * @fnv_prime, @fnv_size) end)
  end
end
