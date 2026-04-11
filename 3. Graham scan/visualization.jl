function save_visualization(points::Vector{Point}, hull::Vector{Point}, filename::String)
    x_points = [point.x for point in points]
    y_points = [point.y for point in points]

    plt = scatter(
        x_points,
        y_points;
        label = "Точки",
        color = :dodgerblue,
        markersize = 6,
        legend = :topright,
        xlabel = "x",
        ylabel = "y",
        title = "Выпуклая оболочка",
        aspect_ratio = :equal,
        grid = true,
        size = (900, 700),
    )

    if !isempty(hull)
        hull_cycle = length(hull) >= 2 ? [hull; hull[1]] : hull
        x_hull = [point.x for point in hull_cycle]
        y_hull = [point.y for point in hull_cycle]

        plot!(plt, x_hull, y_hull; label = "Оболочка", color = :red, linewidth = 2.5)
    end

    savefig(plt, filename)
end
