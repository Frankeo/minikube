# Hello-rust

## Prerequisites
- Install [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)  
- Intall [Helm](https://helm.sh/docs/intro/install/)
- Clone the Repo into your local machine

## Demo

### Common steps
1. Open the repo in a terminal
2. Start minikube: `minikube start`
3. Configure kubectl: `minikube kubectl -- get po -A`
4. Install the app: `helm install hello-rust ./hello-rust/`

#### See the app running in your browser
1. Launch in your browser: `minikube service hello-rust-service`
![Alt text](<Captura desde 2024-07-29 11-51-03.png>)
![Alt text](<Captura desde 2024-07-29 11-50-01.png>)

#### Testing Autoscalling
1. Install dashboard addon: `minikube addons enable metrics-server`
2. Launch dashboard: `minikube dashboard`
3. Execute testing script: `./script-test.sh`

You can check in 2 or 3 minutes how the replicaset start to scale up, adding more pods.
![Alt text](<Captura desde 2024-07-29 11-55-25.png>)

To scale down, just stop terminal with script execution and in 2 or 3 minutes, the replicaset is going to delete some pods.
![Alt text](<Captura desde 2024-07-29 12-02-32.png>)

This could be checked in the **Replica Sets** section in the dashboard.

## Local Development

### Rust application

For testing the rust application in your local machine, please install [Rust](https://www.rust-lang.org/es/tools/install).

1. Debug the app: `cargo run`
2. Check the result in your browser, entering the url: [0.0.0.0:8000](http:0.0.0.0:8000)

### Docker Image

For testing the docker image generation, please install [Docker](https://docs.docker.com/engine/install/).

1. Generate local image: `docker build -t test-1 .`

### Minikube Testing

In case you get stucked with the kubernetes app resources in the cluster, you can allways remove them and start fresh: `helm uninstall hello-rust`

## Github Action Explained

The CI process consists of 3 jobs:

1. **Build and Test**: In a more complex scenario a common build process would require to run a *linter*, the *builder* and the *unit testing* in adition to other tasks (integration tests, for example).
This step mimics this barebone just to ilustrate how it could be if the app wasn't a 'Hello World'.

2. **SonarCloud**: It is a complete scan of the app according to the specifications of the **Sonar** company. the app dashboard review could be checked [here](https://sonarcloud.io/project/overview?id=Frankeo_minikube)

3. **Build and Publish Docker Image**: Step required to generate a docker image and publish it into [Dokcer Hub](https://hub.docker.com/repository/docker/franciscomoreno1/hello-rust-docker/general) after previous quality steps were succesful.