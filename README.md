# Rust Micro Service

A Rust service deployed on Kubernetes with AWS S3 integration.

## Prerequisites

- Docker
- Kubernetes (Minikube, EKS, or any Kubernetes cluster)
- AWS CLI configured with proper access
- Terraform
- Rust (if running locally)

## Setup

### Running Locally

1. **Clone the repository**:

    ```sh
    git clone https://github.com/your-username/rust-service.git
    cd rust-service
    ```

2. **Set up environment variables**:

    Create a `.env` file in the root directory and add the following variables:

    ```sh
    AWS_REGION=us-east-1
    AWS_S3_BUCKET=example
    ```

3. **Run the application**:

    ```sh
    cargo run
    ```

    The application will start and be accessible at `http://127.0.0.1:8080`.

#### Docker

1. **Build the Docker image**:

    ```sh
    docker build -t rust_service:latest .
    ```

2. **Run the Docker container**:

    ```sh
    docker run -p 8080:8080 --env AWS_REGION=us-east-1 --env AWS_S3_BUCKET=example rust_service:latest
    ```

    The application will start and be accessible at `http://127.0.0.1:8080`.

### Deploying to Kubernetes


Ensure an EKS cluster created.


#### Initialize and Apply Terraform

1. **Navigate to the `terraform` directory**:

    ```sh
    cd terraform
    ```

2. **Initialize and apply Terraform**:

    ```sh
    terraform init
    terraform apply
    ```

    Provide the existing S3 bucket name and EKS cluster name when prompted.

#### Apply Kubernetes Manifests

1. **Create the namespace**:

    ```sh
    kubectl apply -f k8s/namespace.yaml
    ```

2. **Create the AWS secrets**:

    ```sh
    kubectl apply -f k8s/aws-secrets.yaml
    ```

3. **Create the service account**:

    ```sh
    kubectl apply -f k8s/service-account.yaml
    ```

4. **Deploy the application**:

    ```sh
    kubectl apply -f k8s/deployment.yaml
    kubectl apply -f k8s/service.yaml
    ```
