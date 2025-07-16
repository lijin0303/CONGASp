FROM python:3.8-slim

# Install system dependencies for building and for graphviz
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        graphviz \
        git \
        python3-distutils \
        python3-dev \
        python3-setuptools \
        libffi-dev \
        libfreetype6-dev \
        pkg-config \
        libpng-dev \
        && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install numpy==1.21.0
RUN pip install pip==23.3.1
RUN pip install -r requirements.txt

# Copy the rest of the code
COPY . .

# Expose Jupyter Notebook port
EXPOSE 8888

# Set default command to launch Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"] 