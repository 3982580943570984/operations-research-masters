using Random

function approximate_vertex_cover(edges::Vector{Tuple{Int,Int}})
    remaining_edges = copy(edges)

    cover = Set{Int}()

    while !isempty(remaining_edges)
        u, v = first(remaining_edges)
        push!(cover, u, v)
        filter!(edge -> !(u in edge) && !(v in edge), remaining_edges)
    end

    for v in collect(cover)
        delete!(cover, v)
        if !all((a in cover) || (b in cover) for (a, b) in edges)
            push!(cover, v)
        end
    end

    return sort!(collect(cover))
end

function main()
    edges = [(1, 2), (1, 3), (2, 3), (3, 4), (3, 5), (4, 6), (5, 6)]

    shuffle!(edges)

    cover = approximate_vertex_cover(edges)

    println("Покрытие: ", cover)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
