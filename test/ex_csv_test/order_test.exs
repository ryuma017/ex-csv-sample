defmodule ExCsv.OrderTest do
  use ExUnit.Case
  alias ExCsv.Order
  doctest Order

  describe "new/1" do
    test "カラムが足りない場合" do
      assert {:error, :required_key_dose_not_exist} = Order.new(%{dummy: :dummy})
    end
  end
end
