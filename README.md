# Cloud Devops Capstone

This project is simple Laravel app for greeting people, with a CI/CD pipeline for linting the code, building a Docker container image, pushing it to a registry, and deploying it to an Amazon EKS Kubernetes cluster using a rolling deployment.

## The App

The app shows a simple page on `/welcome` which welcomes you as a guest and shows the current version of the app. The app also recognises paths with the form `/welcome/[name]` (e.g. `/welcome/phil`) to welcome a person with that name and show the current app version.

## Version

3
