---
sectionid: lab2-app-deployment
sectionclass: h2
title: アプリケーションの配置
parent-id: lab-clusterapp
---

### ログインコマンドを取得する

CLIからログインしていない場合は、右上にある自分の名前の横にあるドロップダウン矢印をクリックして *Copy Login Command* を選択します。

{% collapsible %}

![CLI Login](/media/managedlab/7-ostoy-login.png)

terminal にコピーしたコマンドを貼り付けて、Enterを押してください。正常にログインできた場合は、確認メッセージが表示されます。

```sh
[okashi@ok-vm ostoy]# oc login https://openshift.abcd1234.eastus.azmosa.io --token=hUXXXXXX
Logged into "https://openshift.abcd1234.eastus.azmosa.io:443" as "okashi" using the token provided.

You have access to the following projects and can switch between them with 'oc project <projectname>':

    aro-demo
  * aro-shifty
  ...
```

{% endcollapsible %}

### 新しいプロジェクトを作成する

クラスタに "OSToy" という新しいプロジェクトを作成します。

{% collapsible %}

次のコマンドを実行すると

`oc new-project ostoy`

以下のようなレスポンスが返されます。

```sh
[okashi@ok-vm ostoy]# oc new-project ostoy
Now using project "ostoy" on server "https://openshift.abcd1234.eastus.azmosa.io:443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git

to build a new example application in Ruby.
```

同様に、上部の[Application Console]を選択してから右側の[+ Create Project]ボタンをクリックして、Web UIを使用してこの新しいプロジェクトを作成することもできます。

![UI Create Project](/media/managedlab/6-ostoy-newproj.png)

{% endcollapsible %}

### YAMLのマニフェストファイルをダウンロードする

選択したディレクトリのローカルドライブにKubernetesのYAMLをダウンロードします（次の手順のためにそれらをどこに置いたかを覚えておいてください）。

{% collapsible %}

それらを開いて、私たちがデプロイするものを見てください。このラボを簡単にするために、デプロイするすべてのKubernetesオブジェクトを1つの"all-in-one" のyamlファイルに配置しました。しかし実際のプロジェクトではこれらを個々のyamlファイルに分離することには利点があります。

[ostoy-fe-deployment.yaml](/yaml/ostoy-fe-deployment.yaml)

[ostoy-microservice-deployment.yaml](/yaml/ostoy-microservice-deployment.yaml)

{% endcollapsible %}

### バックエンドのmicroserviceをデプロイする

バックエンドのマイクロサービスアプリケーションは、内部Web要求を処理し、現在のホスト名とランダムに生成されたカラー文字列を含むJSONオブジェクトを返します。

{% collapsible %}

次のコマンドを使用してマイクロサービスをデプロイします。

`oc apply -f ostoy-microservice-deployment.yaml`

次のようなレスポンスが表示されるはずです。

```
[okashi@ok-vm ostoy]# oc apply -f ostoy-microservice-deployment.yaml
deployment.apps/ostoy-microservice created
service/ostoy-microservice-svc created
```

{% endcollapsible %}

### front-end serviceのデプロイ

フロントエンドデプロイメントには、他のいくつかのKubernetesオブジェクトと共に、Node.jsフロントエンドが含まれています。

{% collapsible %}

`ostoy-fe-deployment.yaml` を開くと、次のように定義されていることがわかります。

- Persistent Volume Claim
- Deployment Object
- Service
- Route
- Configmaps
- Secrets

コマンドラインで、次のように入力して上記のすべてのオブジェクトを作成します。

`oc apply -f ostoy-fe-deployment.yaml`

すべてのオブジェクトが正しく作成されたはずです。

```sh
[okashi@ok-vm ostoy]# oc apply -f ostoy-fe-deployment.yaml
persistentvolumeclaim/ostoy-pvc created
deployment.apps/ostoy-frontend created
service/ostoy-frontend-svc created
route.route.openshift.io/ostoy-route created
configmap/ostoy-configmap-env created
secret/ostoy-secret-env created
configmap/ostoy-configmap-files created
secret/ostoy-secret created
```

{% endcollapsible %}

### routeの取得

`oc get route` でアプリケーションにアクセスできるようにルートを取得します

{% collapsible %}

次のような応答が表示されるはずです。

```sh
NAME           HOST/PORT                                                      PATH      SERVICES              PORT      TERMINATION   WILDCARD
ostoy-route   ostoy-route-ostoy.apps.abcd1234.eastus.azmosa.io             ostoy-frontend-svc   <all>                   None
```

Copy `ostoy-route-ostoy.apps.abcd1234.eastus.azmosa.io` above and paste it into your browser and press enter.  You should see the homepage of our application.

![Home Page](/media/managedlab/10-ostoy-homepage.png)

{% endcollapsible %}
