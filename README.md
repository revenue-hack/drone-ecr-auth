# drone-ecr-auth
This docker image is ecr authentication image in drone CI.
https://hub.docker.com/r/revenuehack/drone-ecr-auth

## usage
In drone CI,

```
  develop-deploy:
    group: deploy
    image: revenuehack/drone-ecr-auth
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
      - AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
      - AWS_REGION=ap-northeaxt-1
    secrets: [ AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY ]
    commands:
      - $(aws ecr get-login --region ap-northeast-1 --no-include-email)
      - docker pull registry_url:${DRONE_COMMIT:0:8}
      - docker run -d -p 8181:80 --net net-network_default --name=web_development registry_url:${DRONE_COMMIT:0:8}
    when:
      branch: develop
      event: push
```

Please register `aws_access_key_id` and `aws_secret_access_key` in secrets, and specify environment.
After that, you can pull the image after doing `$ (aws ecr get-login --region ap-northeast-1 --no-include-email)` to pass authentication in commands.


## 使い方(日本語)
drone CIで、

```
  develop-deploy:
    group: deploy
    image: revenuehack/drone-ecr-auth
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
      - AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
      - AWS_REGION=ap-northeaxt-1
    secrets: [ AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY ]
    commands:
      - $(aws ecr get-login --region ap-northeast-1 --no-include-email)
      - docker pull registry_url:${DRONE_COMMIT:0:8}
      - docker run -d -p 8181:80 --net net-network_default --name=web_development registry_url:${DRONE_COMMIT:0:8}
    when:
      branch: develop
      event: push
```

とする。

imageは`https://hub.docker.com/r/revenuehack/drone-ecr-auth`を指定。
後は、secretsにECR認証用の環境変数を登録して、`commands`で`$(aws ecr get-login --region ap-northeast-1 --no-include-email)`を使って認証を通せば、
ECRのイメージを`docker pull`できるようになる。

