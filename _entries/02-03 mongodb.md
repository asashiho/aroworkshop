---
sectionid: mongodb
sectionclass: h2
title: mongoDBのデプロイ
parent-id: lab-ratingapp
---

### テンプレートからmongoDBを作成する

{% collapsible %}
Azure Red Hat OpenShiftは、MongoDBを簡単に作成するためのコンテナーイメージとテンプレートを提供します。テンプレートには、パスワードの自動生成を含む事前定義されたデフォルトを使った、すべての環境変数（ユーザー名/パスワード/データベース名など）を定義するためのパラメーターフィールドがあります。また、デプロイメント構成とサービスの両方を定義します。

利用可能な2つのテンプレートがあります。

* `mongodb-ephemeral` データベースに一時ストレージを使用する開発/テスト目的のテンプレートです。Podが別のNodeに移動されたり、Deploymentが更新されて再デプロイがトリガーされたりするなど、何らかの理由でデータベースPodが再起動されると、すべてのデータが失われます。

* `mongodb-persistent` データベースのデータ保存領域に永続的なボリュームストアを使用します。つまり、データはPodの再起動後も消えません。永続ボリュームを使用するには、Azure Red Hat OpenShiftのDeploymentで永続ボリュームプールを定義する必要があります。

> **Hint** 以下のコマンドを使用してテンプレートのリストを取得できます。テンプレートは`openshift` 名前空間にインストールされています。
> ```sh
> ./oc get templates -n openshift
> ```

mongodb-persistentテンプレートを使ってmongoDBデプロイメントを作成します。YAML/JSONファイルを生成するとき、ユーザー名、パスワード、データベースを渡しoc createコマンドにパイプします。

```sh
./oc process openshift//mongodb-persistent \
    -p MONGODB_USER=ratingsuser \
    -p MONGODB_PASSWORD=ratingspassword \
    -p MONGODB_DATABASE=ratingsdb \
    -p MONGODB_ADMIN_PASSWORD=ratingspassword | ./oc create -f -
```

Webコンソールに戻ったら、mongoDBの新しいDeploymentが表示されているはずです。

![MongoDB deployment](media/mongodb-overview.png)

{% endcollapsible %}

### mongoDB Podが正常に作成されたかどうかを確認

{% collapsible %}

`oc status` コマンドを実行して新しいアプリケーションのステータスを確認し、mongoDBテンプレートのデプロイが成功したかどうかを確認してください。

```sh
./oc status
```

![oc status](media/oc-status-mongo.png)

{% endcollapsible %}

### データのリストア

{% collapsible %}

データベースがクラスタ上で動作しているので、ここにデータを復元します。

Azure Cloud Shellでデータのzipをダウンロードして解凍します。

```sh
wget https://github.com/microsoft/rating-api/raw/master/data.tar.gz
tar -zxvf data.tar.gz
```

![Download and unzip the data](media/download-data.png)

実行中のMongoDB Podの名前を特定します。次のコマンドは現在のプロジェクトのPodのリストを表示します。

```sh
./oc get pods
```

![oc get pods](media/oc-getpods-mongo.png)

データフォルダをmongoDB Podにコピーします。

```sh
./oc rsync ./data mongodb-1-2g98n:/opt/app-root/src
```

![oc rsync](media/oc-rsync.png)

次に、目的のPodへのrshを開きます。

```sh
./oc rsh mongodb-1-2g98n
```

![oc rsh](media/oc-rsh.png)

`mongoimport` コマンドを実行してJSONデータファイルをデータベースにインポートします。ユーザー名/パスワード/データベース名が、テンプレートをデプロイしたときに指定したものと一致していることを確認してください。

```sh
mongoimport --host 127.0.0.1 --username ratingsuser --password ratingspassword --db ratingsdb --collection items --type json --file data/items.json --jsonArray
mongoimport --host 127.0.0.1 --username ratingsuser --password ratingspassword --db ratingsdb --collection sites --type json --file data/sites.json --jsonArray
mongoimport --host 127.0.0.1 --username ratingsuser --password ratingspassword --db ratingsdb --collection ratings --type json --file data/ratings.json --jsonArray
```

![mongoimport](media/mongoimport.png)

{% endcollapsible %}

### mongoDB のservice hostnameの確認

{% collapsible %}

mongoDB のサービスを確認します。

```sh
./oc get svc mongodb
```

![oc get svc](media/oc-get-svc-mongo.png)

サービスは、次のDNS名でアクセスできるようになります
[service name].[project name].svc.cluster.local
これはクラスタ内でのみ解決されます。

Webコンソールからこれを取得することもできます。設定するにはこのホスト名が必要です。

![MongoDB service in the Web Console](media/mongo-svc-webconsole.png)

{% endcollapsible %}

> **Resources**
> * <https://docs.openshift.com/aro/using_images/db_images/mongodb.html>
> * <https://docs.openshift.com/aro/using_images/db_images/mongodb.html#running-mongodb-commands-in-containers>
> * <https://docs.openshift.com/aro/dev_guide/templates.html>