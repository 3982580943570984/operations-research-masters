function greedy_set_cover(universe::Set{Int}, subsets::Vector{Set{Int}})
    uncovered = copy(universe)
    cover = Vector{Set{Int}}()

    while !isempty(uncovered)
        best_subset = nothing
        best_gain = 0

        for subset in subsets
            gain = length(intersect(subset, uncovered))
            if gain > best_gain
                best_gain = gain
                best_subset = subset
            end
        end

        push!(cover, best_subset)

        setdiff!(uncovered, best_subset)
    end

    return cover
end

function main()
    universe = Set([1, 2, 3, 4, 5])
    subsets = [Set([1, 2, 3]), Set([2, 4]), Set([3, 4]), Set([4, 5])]

    union_subsets = Set{Int}()
    foreach(subset -> union!(union_subsets, subset), subsets)
    issubset(universe, union_subsets) || error("Покрытие не существует.")

    cover = greedy_set_cover(universe, subsets)

    println("Покрытие:")
    for (i, subset) in enumerate(cover)
        println("S$i = ", sort!(collect(subset)))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
