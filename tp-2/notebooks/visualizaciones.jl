###Funcion para visualizar la catenaria###
### Toma como argumento el valor optimo de 'y' encontrado####

function visualizar_cadena(y_opt)
    println("\n  Forma de la cadena (vista lateral):")
    println()

    # Calcular posiciones (xᵢ, yᵢ_acum) de cada nodo
    xs = [0.0]
    ys_accum = [0.0]
    N = length(y_opt)
    for i in 1:N
        push!(xs, xs[end] + sqrt(max(1.0 - y_opt[i]^2, 0.0)))
        push!(ys_accum, ys_accum[end] + y_opt[i])
    end

    # Normalizar para plot ASCII (40 cols x 15 rows)
    rows, cols = 15, 44
    y_min, y_max = minimum(ys_accum), maximum(ys_accum)
    x_min, x_max = minimum(xs), maximum(xs)

    grid = fill(' ', rows, cols)
    for k in 1:length(xs)
        col = round(Int, (xs[k] - x_min) / (x_max - x_min) * (cols - 1)) + 1
        row = round(Int, (1 - (ys_accum[k] - y_min) / (y_max - y_min + 1e-12)) * (rows - 1)) + 1
        col = clamp(col, 1, cols)
        row = clamp(row, 1, rows)
        grid[row, col] = k == 1 || k == length(xs) ? 'O' : '*'
    end

    for row in 1:rows
        print("  |")
        print(String(grid[row, :]))
        println("|")
    end
    println("  " * "-" ^ (cols + 2))
    println("  Ganchos: O    Eslabones: *")
end


###Funcion para visualizar el recorrido del camino calculado por la heuristica###
### Toma como argumento a la f y al camino (puntos) dado por el método####

function visualizar_camino(f,path)
    xs = -2.0:0.05:2.0 ### cambiar a segun corresponda
    ys = -2.0:0.05:2.0

    # Gráfico de curvas de nivel limpio
    p = contour(xs, ys, (x,y) -> f([x,y]),
        levels=30,
        xlabel="x",
        ylabel="y",
        color=:viridis,
        alpha=0.5,
        colorbar=false)

    path_x = [pt[1] for pt in path]
    path_y = [pt[2] for pt in path]

    plot!(p, path_x, path_y, lw=2.5, lc=:red, label="Camino")
    scatter!(p, [path_x[1]], [path_y[1]], mc=:blue, label="Inicio")
    scatter!(p, [path_x[end]], [path_y[end]], mc=:green, label="Fin")

    display(p)
end