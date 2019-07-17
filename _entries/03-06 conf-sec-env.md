---
sectionid: lab2-config
sectionclass: h2
title: 設定
parent-id: lab-clusterapp
---

このセクションでは、[ConfigMaps](https://docs.openshift.com/container-platform/3.11/dev_guide/configmaps.html)／[Secrets](https://docs.openshift.com/container-platform/3.11/dev_guide/secrets.html)／[Environment Variables](https://docs.openshift.com/container-platform/3.11/dev_guide/environment_variables.html)を使用してOSToyを構成する方法を説明します。このセクションでは、それぞれを説明する詳細については説明しませんがアプリケーションにどのように公開されているのかを説明します。


### ConfigMapsを使った設定

ConfigMapsを使用すると、コンテナー化されたアプリケーションの移植性を維持するために、コンテナーイメージコンテンツから構成ファイルを分離できます。

{% collapsible %}

左側のメニューで *Config Maps*  をクリックします。

OSToyアプリケーションで利用可能な設定マップの内容が表示されます。これらは `ostoy-fe-deployment.yaml` で定義しました。


```sh
kind: ConfigMap
apiVersion: v1
metadata:
  name: ostoy-configmap-files
data:
  config.json:  '{ "default": "123" }'
```

{% endcollapsible %}

### Secretsによる秘匿情報の設定

Kubernetes Secretオブジェクトを使用すると、パスワード／OAuthトークン／SSHキーなどの機密情報を保存および管理できます。この情報をSecretsにすることは、Podのマニフェストやコンテナイメージにそのまま入れることよりも安全でフレキシブルです。

{% collapsible %}

左側のメニューで *Secrets* をクリックします。

これにより、OSToyアプリケーションで利用可能なSecretsの内容が表示されます。これらは `ostoy-fe-deployment.yaml` で定義しました。


```sh
apiVersion: v1
kind: Secret
metadata:
  name: ostoy-secret
data:
  secret.txt: VVNFUk5BTUU9bXlfdXNlcgpQQVNTV09SRD1AT3RCbCVYQXAhIzYzMlk1RndDQE1UUWsKU01UUD1sb2NhbGhvc3QKU01UUF9QT1JUPTI1
type: Opaque
```

{% endcollapsible %}

### 環境変数を使用した設定

環境変数を使用すると、コードを変更しなくてもアプリケーションの動作を簡単に変更できます。これにより、同じアプリケーションの異なるデプロイメントが環境変数に基づいて異なる動作をする可能性があります。OpenShiftを使用すると、Pods／Deploymentの環境変数を簡単に設定／表示／更新ができます。

{% collapsible %}

左側のメニューで *ENV Variables* をクリックします。

これにより、OSToyアプリケーションで利用可能な環境変数が表示されます。Depoymentで定義されている3つを追加しました。


```sh
  env:
  - name: ENV_TOY_CONFIGMAP
    valueFrom:
      configMapKeyRef:
        name: ostoy-configmap-env
        key: ENV_TOY_CONFIGMAP
  - name: ENV_TOY_SECRET
    valueFrom:
      secretKeyRef:
        name: ostoy-secret-env
        key: ENV_TOY_SECRET
  - name: MICROSERVICE_NAME
    value: OSTOY_MICROSERVICE_SVC
```

最後の`MICROSERVICE_NAME` はこのアプリケーションのPod間のクラスタ内通信に使用されます。アプリケーションはcolorsを取得するためにマイクロサービスにアクセスする方法を知るためこの環境変数を参照します。

{% endcollapsible %}
