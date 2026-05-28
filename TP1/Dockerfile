FROM julia:1.10

# Instalar IJulia (kernel de Julia para Jupyter)
RUN julia -e 'using Pkg; Pkg.add("IJulia")'

# Instalar Jupyter
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install jupyter --break-system-packages

WORKDIR /notebooks
EXPOSE 8888

# Lanzar Jupyter sin token ni password para facilitar el acceso local
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", \
     "--no-browser", "--allow-root", "--NotebookApp.token=''"]
