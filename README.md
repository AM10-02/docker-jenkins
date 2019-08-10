# docker-jenkins

## 環境
macOS上で動作検証しています。  

|アプリなど|バージョン|
|---|---|
|macOS|10.14.5|
|Docker Desktop for Mac|2.1.0.1|
|Jenkins|2.176.2|

## 使い方
以下のコマンドは、本リポジトリのトップディレクトリで実行してください。

### イメージのビルド
```bash
$ docker-compose build docker-jenkins
```

### Jenkinsの起動
```bash
$ docker-compose up -d
```

起動後は`http://localhost:8080`でアクセスできます。

### Jenkinsへのアクセス
```bash
$ docker exec -it docker-jenkins bash
```
抜け出すときは、`exit`で抜け出せます。  
rootユーザでログインする場合は、
```bash
$ docker exec -u 0 -it docker-jenkins bash
```
を使用してください。

### Jenkinsログの表示
```bash
$ docker logs -f docker-jenkins
```
終了するときは、`ctrl+c`で終了します。

### Jenkinsの停止
```bash
$ docker-compose stop
```

### イメージの削除
#### このイメージのみ削除
```bash
$ docker ps -aq --filter "name=docker-jenkins" | xargs docker rm
$ docker images docker-jenkins_docker-jenkins -q | xargs docker rmi
```

このイメージの元となったJenkinsのイメージも削除する場合は、こちらも実行してください。

```bash
$ docker images jenkins/jenkins -q | xargs docker rmi
```

#### 一括削除
docker-jenkinsのみ動かしている場合や、他のイメージまで全て削除する場合は、こちらを使用したほうが簡単に削除できます。  
全て削除するので、注意して使用してください。

```bash
$ docker stop $(docker ps -q)
$ docker system prune
$ docker rmi $(docker images -q)
```
