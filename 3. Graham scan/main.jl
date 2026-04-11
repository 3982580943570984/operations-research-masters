using Random
using Plots

include("constants.jl")
include("types.jl")
include("geometry.jl")
include("algorithm.jl")
include("generator.jl")
include("visualization.jl")

function main()
    points = generate_random_points()

    hull = graham_scan(points)

    output_file = joinpath(@__DIR__, "hull.png")
    save_visualization(points, hull, output_file)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
