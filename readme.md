## Building the docker image:

- Build the docker image by running the command:

``` sh
#!/bin/sh

# Build the Docker image
docker build -t ambag2-dev-env .
```

- Start the container:

``` sh
docker run -it -p 3000:3000 -p 5000:5000 -p 8080:8080 -p 9099:9099 -p 4000:4000 -p 5173:5173 --name ambag2-dev-container ambag2-dev-env  

```
Ports used:
 - 3000: Emulator UI
 - 5000: Firebase Hosting emulator
 - 8080: Cloud Firestore emulator
 - 9099: Firebase Authentication emulator
 - 4000: Cloud Functions emulator
 - 5173: Sveltekit (vite)
