find_starting_point(points::Vector{Point}) = argmin(point -> (point.y, point.x), points)

function sort_by_polar_angle(points::Vector{Point}, starting_point::Point)
    others = [point for point in points if point != starting_point]
    sort!(
        others,
        by = point -> (
            atan(point.y - starting_point.y, point.x - starting_point.x),
            distance(starting_point, point),
        ),
    )

    filtered = Point[]
    for point in others
        while !isempty(filtered) && cross(starting_point, filtered[end], point) == 0
            if distance(starting_point, point) <= distance(starting_point, filtered[end])
                point = filtered[end]
                break
            end

            pop!(filtered)
        end

        isempty(filtered) || filtered[end] != point || continue

        push!(filtered, point)
    end

    return filtered
end

function scan_remaining_points!(stack::Vector{Point}, sorted_points::Vector{Point})
    for point in sorted_points[3:end]
        while length(stack) >= 2 && cross(stack[end-1], stack[end], point) <= 0
            pop!(stack)
        end

        push!(stack, point)
    end
end

function graham_scan(points::Vector{Point})::Vector{Point}
    unique_points = unique(points)

    if length(unique_points) <= 2
        return unique_points
    end

    starting_point = find_starting_point(unique_points)

    sorted_points = sort_by_polar_angle(unique_points, starting_point)

    if length(sorted_points) < 2
        return [starting_point; sorted_points]
    end

    stack = Point[starting_point, sorted_points[1], sorted_points[2]]

    scan_remaining_points!(stack, sorted_points)

    return stack
end
