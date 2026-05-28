# Julia + Pluto Notebooks con Docker

## Estructura de carpetas

```
tu-proyecto/
├── Dockerfile
├── docker-compose.yml
└── notebooks/          ← Acá van tus archivos .jl (se guardan en tu máquina)
```

## Pasos para usar

### 1. Primera vez (construye la imagen, tarda unos minutos)
```bash
docker compose up --build
```

### 2. Las veces siguientes (ya no necesita reconstruir)
```bash
docker compose up
```

### 3. Abrir Pluto en el navegador
Cuando veas en la terminal un mensaje como:
```
Go to http://localhost:1234/?secret=xxxxxxxx in your browser
```
Copiá esa URL completa (con el `?secret=...`) y pegala en tu navegador.

### 4. Apagar el contenedor
```bash
docker compose down
```

## Guardar tus notebooks

Dentro de Pluto, al guardar un archivo usá la ruta `/notebooks/mi_archivo.jl`.  
Ese archivo va a aparecer automáticamente en la carpeta `notebooks/` de tu máquina.

## Instalar paquetes de Julia adicionales

Si necesitás paquetes extra (ej: Plots, DataFrames), agregá una línea en el `Dockerfile`:

```dockerfile
RUN julia -e 'using Pkg; Pkg.add(["Pluto", "Plots", "DataFrames"])'
```

Y reconstruí con `docker compose up --build`.
