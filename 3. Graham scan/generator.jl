generate_random_points() =
    [Point(rand(X_MIN:X_MAX), rand(Y_MIN:Y_MAX)) for _ = 1:POINTS_COUNT]
