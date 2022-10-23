defmodule ExCsv.Order do
  defstruct [
    :gender,
    :age,
    :oil_level,
    :hard_level,
    :salt_level,
    :topping,
    :rice,
    :review
  ]

  @key_name_map %{
    gender: "性別",
    age: "年齢層",
    oil_level: "脂",
    salt_level: "濃さ",
    hard_level: "硬さ",
    topping: "トッピング",
    rice: "ライス",
    review: "評価"
  }

  def new(order_map)

  def new(%{
        "性別" => gender,
        "年齢層" => age,
        "脂" => oil_level,
        "硬さ" => hard_level,
        "濃さ" => salt_level,
        "トッピング" => topping,
        "ライス" => rice,
        "評価" => review
      }) do
    %__MODULE__{
      gender: gender,
      age: age,
      oil_level: oil_level,
      hard_level: hard_level,
      salt_level: salt_level,
      topping: topping,
      rice: rice,
      review: review |> String.to_integer()
    }
  end

  def new(_), do: {:error, :required_key_dose_not_exist}

  def en_key_to_ja(key), do: @key_name_map[key]

  def calc_review_avg(orders, gender, age) do
    orders
    |> Enum.filter(fn order ->
      order.age == age &&
        order.gender == gender
    end)
    |> Enum.map(& &1.review)
    |> then(fn reviews ->
      Enum.sum(reviews) / Enum.count(reviews)
    end)
  end

  def calc_order_rates(orders, filter_func) do
    orders
    |> Enum.filter(&filter_func.(&1))
    |> then(fn targets ->
      %{
        rice: calc_rate(targets, :rice),
        topping: calc_rate(targets, :topping),
        oil_level: calc_rate(targets, :oil_level),
        hard_level: calc_rate(targets, :hard_level),
        salt_level: calc_rate(targets, :salt_level)
      }
    end)
  end

  defp calc_rate(orders, order_key) do
    total_count = Enum.count(orders)

    orders
    |> Enum.map(&Map.get(&1, order_key))
    |> Enum.group_by(& &1)
    |> Enum.map(fn {key, each_values} ->
      count = Enum.count(each_values)

      {
        key,
        count / total_count * 100
      }
    end)
    |> Map.new()
  end
end
