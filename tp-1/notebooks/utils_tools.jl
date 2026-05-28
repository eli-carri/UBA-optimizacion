function split(X, y; dims=1, ratio_train=0.8)
    # Tamaño de la muestra
    n = length(y)
    
    n_train = round(Int, ratio_train*n)  # Redondeamos el corte
    i_rand  = randperm(n)				 # Permutamos los indices
    i_train = i_rand[1:n_train] 		 # Usamos el 80% para train
    i_test  = i_rand[n_train+1:end] 	 # El resto lo usamos para test

    # Definimos los conjuntos de train y test
	X_train = X[i_train,:]
	Y_train = y[i_train]
	X_test  = X[i_test,:]
	Y_test  = y[i_test]
    
    return X_train, Y_train, X_test, Y_test
    
end

function normalize_data(X_train, X_test; dims=1)
    
    col_mean = mean(X_train; dims)  # Media
    col_std  = std(X_train; dims)   # Desviación estándar

    # Normalizaciones
    X_train_norm = (X_train .- col_mean) ./ col_std
    X_test_norm  = (X_test .- col_mean) ./ col_std
    
    return X_train_norm, X_test_norm
    
end

function onehot(y, classes)
    # Definimos matriz one-hot
	y_onehot = zeros(length(classes), length(y))

    # Itera sobre las columnas
	for i in 1:length(y)
		y_onehot[:,i] = y[i].==classes
        
	end
	return y_onehot
    
end

function prepare_data(X, y; do_normal=true, do_onehot=true, kwargs...)
    # Spliteamos la muestra
    X_train, Y_train, X_test, Y_test = split(X, y)

    # ? Normalización de conjuntos
    if do_normal
        X_train, X_test = normalize_data(X_train, X_test; kwargs...)
        
    end
    # Definimos las clases
    classes = unique(y)

    # ? One-hot encoding
    if do_onehot
        Y_train = onehot(Y_train, classes)
        Y_test  = onehot(Y_test, classes)
        
    end
    return X_train', Y_train, X_test', Y_test, classes
    
end

mean_tuple(d::AbstractArray{<:Tuple}) = Tuple([mean([d[k][i] for k in 1:length(d)]) for i in 1:length(d[1])])
grad_total(modelo, grad, x, y) = mean_tuple([grad(modelo, x[:,k], y[:,k]) for k in 1:size(x,2)])