---
sectionid: lab2-network
sectionclass: h2
title: ネットワーキングとスケーリング
parent-id: lab-clusterapp
---

このセクションでは、OSToyがクラスター内ネットワークを使用してマイクロサービスを使用して機能を分離し、Podのスケーリングを視覚化する方法を説明します。

このアプリケーションの設定方法を確認しましょう

![OSToy Diagram](/media/managedlab/4-ostoy-arch.png)

上の図からわかるように、少なくとも2つの別々のPodを定義しており、それぞれに独自のServiceがあります。1つはフロントエンドWebアプリケーション（サービスとパブリックからアクセス可能なrouteを持つ）、もう1つはフロントエンドポッドがマイクロサービスと通信できるように作成されたサービスオブジェクトを持つバックエンドマイクロサービスです。このマイクロサービスは、このクラスタの外部からも、他のネームスペース/プロジェクトからもアクセスできません（AROの **ovs-subnet** ネットワークポリシーのため）このマイクロサービスのの目的は、内部のWebリクエストを処理し、現在のホスト名とランダムに生成された文字列を含むJSONオブジェクトを返すことです。この文字列は、その色がタイルに表示されているボックスを表示するために使用されます（"Intra-cluster Communication"というタイトルが付いています）。

### ネットワーキング

左側のメニューで*Networking*をクリックします。ネットワーク構成を確認してください。

{% collapsible %}

The right tile titled "Hostname Lookup" illustrates how the service name created for a pod can be used to translate into an internal ClusterIP address. Enter the name of the microservice following the format of `my-svc.my-namespace.svc.cluster.local` which we created in our `ostoy-microservice.yaml` which can be seen here:
"Hostname Lookup"というタイトルのタイルは、Pod用に作成されたService名を使用して内部のClusterIPアドレスに変換する方法を示しています。`my-svc.my-namespace.svc.cluster.local`  

ここで`ostoy-microservice.yaml`が作成した形式に従ってマイクロサービスの名前を入力してください。

```sh
apiVersion: v1
kind: Service
metadata:
  name: ostoy-microservice-svc
  labels:
    app: ostoy-microservice
spec:
  type: ClusterIP
  ports:
    - port: 8080
      targetPort: 8080
      protocol: TCP
  selector:
    app: ostoy-microservice
```

たとえばこの場合は `ostoy-microservice-svc.ostoy.svc.cluster.local` となります。

ここでIPアドレスが返されます（例：172.30.165.246）

これはクラスタ内IPアドレスでクラスタ内からのみアクセス可能です。


![ostoy DNS](/media/managedlab/20-ostoy-dns.png)

{% endcollapsible %}

### スケーリング

OpenShift allows one to scale up/down the number of pods for each part of an application as needed.  This can be accomplished via changing our *replicaset/deployment* definition (declarative), by the command line (imperative), or via the web UI (imperative). In our deployment definition (part of our `ostoy-fe-deployment.yaml`) we stated that we only want one pod for our microservice to start with. This means that the Kubernetes Replication Controler will always strive to keep one pod alive.  (We can also define [autoscalling](https://docs.openshift.com/container-platform/3.11/dev_guide/pod_autoscaling.html) based on load to expand past what we defined if needed)

OpenShiftを使用すると、必要に応じてアプリケーションのPod数をup/downできます。これは、*replicaset/deployment* 定義の変更（宣言）／コマンドライン（必須）／Web UI（必須）を使用して実現できます。

私たちのDepoymentマニフェストファイル（ostoy-fe-deployment.yaml）で、マイクロサービスのための1つのPodだけで始めたいと宣言しています。つまり、Kubernetes Replication Controlerは常に1つのポッドを存続させようとします。（必要に応じて定義したものを超えて拡張するために、負荷に基づいて[オートスケール](https://docs.openshift.com/container-platform/3.11/dev_guide/pod_autoscaling.html)することも可能です）

{% collapsible %}

左側のタイルを見ると、1つのボックスがランダムに色を変えているのがわかります。このボックスには、マイクロサービスによってフロントエンドに送信されたランダムに生成された色と、それを送信したPod名が表示されます。1つのボックスしかないので、マイクロサービスポッドは1つしかありません。Podを拡大して、ボックスの数が変わるのを確認しましょう。

マイクロサービスに対して実行されているPodが1つだけであることを確認するには、次のコマンドを実行するか、Web UIを使用します。

```sh
[okashi@ok-vm ostoy]# oc get pods
NAME                                   READY     STATUS    RESTARTS   AGE
ostoy-frontend-679cb85695-5cn7x       1/1       Running   0          1h
ostoy-microservice-86b4c6f559-p594d   1/1       Running   0          1h
```

yamlを変更して、表示されているPodの代わりに3つのPodが必要であることを反映します。[ostoy-microservice-deployment.yaml](/yaml/ostoy-microservice-deployment.yaml)をダウンロードしてローカルマシンに保存します。

お気に入りのエディタを使ってファイルを開きます。（例：vi ostoy-microservice-deployment.yaml）

`replicas: 1`を`replicas: 3`に変更し、保存して終了します。

```sh
spec:
    selector:
      matchLabels:
        app: ostoy-microservice
    replicas: 3
```

CLIから次のコマンドを実行します。

`oc apply -f ostoy-microservice-deployment.yaml`

CLI（`oc get pods`）またはWeb UI（[Overview]> [ostoy-microservice]）で、3つのPodが表示されていることを確認します。

OSToyアプリにアクセスして、現在表示されているボックスの数が3つになっていることを視覚的に確認できます。

![UI Scale](/media/managedlab/22-ostoy-colorspods.png)

Now we will scale the pods down using the command line.  Execute the following command from the CLI: 
次にコマンドラインを使用してPodをdownします。CLIから次のコマンドを実行します。

`oc scale deployment ostoy-microservice --replicas=2`

CLI（`oc get pods`）またはWeb UIを介して、Podが2つになっていることを確認してください。

同様にOSToyアプリにアクセスして、現在表示されているボックスの数が2つになっていることを視覚的に確認できます。

最後に、Web UIを使用して1つのPodにdonwしましょう。このアプリ用に作成したプロジェクト（"ostoy"）の左側のメニューで、[Overview ]をクリックし、[ostoy-microservice ]を展開します。

ここにに数字2の青い円があります。その右側にある下向き矢印をクリックして、ポッドの数を1に減らします。

![UI Scale](/media/managedlab/21-ostoy-uiscale.png)

同様にOSToyアプリにアクセスして、現在表示されているボックスの数を確認し1つになっていることを視覚的に確認できます。

{% endcollapsible %}
