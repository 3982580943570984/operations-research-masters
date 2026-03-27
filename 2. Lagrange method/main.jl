using NLsolve
using Optim

f(x, y) = x + x^2 + 4 * y + 4 * y^2
constraint(x, y) = x + 4 * y - 6

function lagrange_system(F, vars)
    x, y, λ = vars

    F[1] = 1 + 2 * x + λ
    F[2] = 4 + 8 * y + 4 * λ
    F[3] = constraint(x, y)
end

function solve_lagrange(x0, y0, λ0)
    initial_guess = [x0, y0, λ0]
    solution = nlsolve(lagrange_system, initial_guess)

    x_star, y_star, λ_star = solution.zero
    return x_star, y_star, λ_star, solution.iterations
end

function check_with_optimization()
    reduced_function(y) = f(6 - 4 * y, y)

    result = optimize(reduced_function, -100.0, 100.0)

    y_star = Optim.minimizer(result)
    x_star = 6 - 4 * y_star

    return x_star, y_star, Optim.minimum(result), Optim.iterations(result)
end

function main()
    x_star, y_star, λ_star, iterations = solve_lagrange(0.0, 0.0, 0.0)
    println("Метод Лагранжа:")
    println("x* = ", x_star)
    println("y* = ", y_star)
    println("λ* = ", λ_star)
    println("f(x*, y*) = ", f(x_star, y_star))
    println("g(x*, y*) = ", constraint(x_star, y_star))
    println("iterations = ", iterations)
    println()

    x_check, y_check, f_check, check_iterations = check_with_optimization()
    println("Проверка встроенной оптимизацией:")
    println("x* = ", x_check)
    println("y* = ", y_check)
    println("f(x*, y*) = ", f_check)
    println("g(x*, y*) = ", constraint(x_check, y_check))
    println("iterations = ", check_iterations)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end