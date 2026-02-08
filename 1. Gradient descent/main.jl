f(x, y) = x^2 + 4 * y^2 + 2 * x * y

gradient(x, y) = (2x + 2y), (8y + 2x)

function by_argument_change(x_old, y_old, x_new, y_new, tolerance)
    delta_norm = sqrt((x_new - x_old)^2 + (y_new - y_old)^2)
    return delta_norm <= tolerance
end

function by_function_change(x_old, y_old, x_new, y_new, tolerance)
    delta_value = abs(f(x_new, y_new) - f(x_old, y_old))
    return delta_value <= tolerance
end

function by_gradient_norm(_, _, x_new, y_new, tolerance)
    gx, gy = gradient(x_new, y_new)
    gradient_norm = sqrt(gx^2 + gy^2)
    return gradient_norm <= tolerance
end

function fixed_step(x, y, _, learning_rate)
    gx, gy = gradient(x, y)
    x_new = x - learning_rate * gx
    y_new = y - learning_rate * gy
    return x_new, y_new
end

function variable_step(x, y, iteration, learning_rate)
    current_learning_rate = learning_rate / sqrt(iteration)
    return fixed_step(x, y, iteration, current_learning_rate)
end

function descend(x0, y0, recurrent_formula, stop_criterion; learning_rate=0.1, max_iterations=10_000, tolerance=1e-10)
    x, y = x0, y0

    for iteration in 1:max_iterations
        x_new, y_new = recurrent_formula(x, y, iteration, learning_rate)

        if stop_criterion(x, y, x_new, y_new, tolerance)
            return x_new, y_new, iteration
        end

        x, y = x_new, y_new
    end

    return x, y, max_iterations
end

function main()
    x_star, y_star, iterations = descend(5.0, -3.0, fixed_step, by_argument_change)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)

    x_star, y_star, iterations = descend(5.0, -3.0, fixed_step, by_function_change)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)

    x_star, y_star, iterations = descend(5.0, -3.0, fixed_step, by_gradient_norm)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)

    x_star, y_star, iterations = descend(5.0, -3.0, variable_step, by_argument_change)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)

    x_star, y_star, iterations = descend(5.0, -3.0, variable_step, by_function_change)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)

    x_star, y_star, iterations = descend(5.0, -3.0, variable_step, by_gradient_norm)
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("iterations = ", iterations)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
