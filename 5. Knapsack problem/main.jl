struct Item
    name::String
    weight::Int
    value::Int
end

function solve_knapsack(items::Vector{Item}, capacity::Int)
    n = length(items)
    dp = zeros(Int, n + 1, capacity + 1)

    for i in 1:n
        item = items[i]

        for current_capacity in 0:capacity
            without_item = dp[i, current_capacity + 1]

            if item.weight <= current_capacity
                with_item = dp[i, current_capacity - item.weight + 1] + item.value
                dp[i + 1, current_capacity + 1] = max(without_item, with_item)
            else
                dp[i + 1, current_capacity + 1] = without_item
            end
        end
    end

    selected_items = Item[]
    remaining_capacity = capacity

    for i in n:-1:1
        if dp[i + 1, remaining_capacity + 1] != dp[i, remaining_capacity + 1]
            item = items[i]
            push!(selected_items, item)
            remaining_capacity -= item.weight
        end
    end

    reverse!(selected_items)

    return selected_items, dp[n + 1, capacity + 1], dp
end

function print_dp_table(items::Vector{Item}, capacity::Int, dp::Matrix{Int})
    print("Предмет \\ Вес |")

    for current_capacity in 0:capacity
        print(lpad(current_capacity, 4))
    end

    println()
    println("-" ^ (14 + 4 * (capacity + 1)))

    print(lpad("0 предметов", 13), " |")
    for current_capacity in 0:capacity
        print(lpad(dp[1, current_capacity + 1], 4))
    end
    println()

    for i in 1:length(items)
        print(lpad(items[i].name, 13), " |")

        for current_capacity in 0:capacity
            print(lpad(dp[i + 1, current_capacity + 1], 4))
        end

        println()
    end
end

function main()
    items = [
        Item("A", 2, 3),
        Item("B", 3, 4),
        Item("C", 4, 5),
        Item("D", 5, 8),
    ]
    capacity = 8

    selected_items, max_value, dp = solve_knapsack(items, capacity)
    total_weight = sum(item.weight for item in selected_items)

    println("DP-таблица:")
    print_dp_table(items, capacity, dp)
    println()

    println("Вместимость рюкзака: ", capacity)
    println("Максимальная ценность: ", max_value)
    println("Итоговый вес: ", total_weight)
    println("Выбранные предметы:")

    for item in selected_items
        println(item.name, ": вес = ", item.weight, ", ценность = ", item.value)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
