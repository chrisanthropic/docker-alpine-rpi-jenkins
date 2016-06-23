## WHAT
An Alpine Linux Docker container for Rasberry Pi 2 with Glibc and Java JDK 8 and Jenkins installed.

Uses glibc .apk generated via: https://github.com/chrisanthropic/docker-alpine-rpi-glibc-builder

## HOW
Run ours:

```
docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock ctarwater/armhf-alpine-rpi-jenkins
```

Then access it via a browser pointed at localhost:8080 (or from another machine on your network at http://RaspberryPi-IP:8080)

Persistant data volume:
I created a local directory on my Raspberry pi, made it horribly insecure (chmod 777) and then tell Docker to mount the jenkins_home directory to the local Raspberry Pi directory /home/jenkins. This allows all Jenkins data to stay on the local disc even if/when the Jenkins container is stopped/killed. Then we can lanuch another Jenkins container at any point and it'll use the data there.

```
docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/var/jenkins_home ctarwater/armhf-alpine-rpi-jenkins
```


Build it yourself:
`docker build -t armhf-alpine-rpi-jenkins .`
