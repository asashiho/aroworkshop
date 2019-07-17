---
sectionid: lab2-appoverview
sectionclass: h2
title: アプリケーションの概要
parent-id: lab-clusterapp
---

### Resources

- このアプリケーションのソースコード: <https://github.com/openshift-cs/ostoy>
- OSToy の front-end コンテナイメージ: <https://quay.io/aroworkshop/ostoy-frontend>
- OSToy の microservice コンテナイメージ: <https://quay.io/aroworkshop/ostoy-microservice>
- YAMLによるマニフェストファイル:
  - [ostoy-fe-deployment.yaml](/yaml/ostoy-fe-deployment.yaml)
  - [ostoy-microservice-deployment.yaml](/yaml/ostoy-microservice-deployment.yaml)

> **Note** アプリのデプロイを簡単にするために、上記のYAMLに必要なすべてのオブジェクトを1つの "all-in-one" としてYAMLを作成しています。しかし実際には、企業はKubernetesオブジェクトごとに異なるyamlファイルを作成したいと考えるでしょう。

### OSToyについて

OSToyは、Azure Red Hat OpenShiftにデプロイする簡単なNode.jsアプリケーションです。それは私たちがKubernetesの機能を確認するのを助けるのに使われます。このアプリケーションは、次の機能を持っています。

- ログにメッセージを書き込む（stdout / stderr）
- 意図的にアプリケーションをクラッシュさせて自己修復を表示する
- LivenessProbeを切り替えてOpenShiftの動作を監視する
- ConfigMap、Secrets、および環境変数を読み取る
- 共有ストレージに接続されている場合のファイルの読み書き
- ネットワーク接続/クラスタ内DNS/マイクロサービスとの内部通信を確認

### OSToy アプリケーション構成図

![OSToy Diagram](/media/managedlab/4-ostoy-arch.png)

### アプリケーションUIの説明

1. ブラウザにページを提供したポッド名を表示します。
2. **Home:** アプリケーションのメインページで、ここで説明する機能のいくつかを実行できます。
3. **Persistent Storage:**  このアプリケーションにバインドされている永続ボリュームにデータを書き込むことができます。
4. **Config Maps:**  アプリケーションで使用可能なConfigMapの内容とキーと値のペアを表示します。
5. **Secrets:** アプリケーションで使用可能なSecretsの内容とキーと値のペアを表示します。
6. **ENV Variables:** アプリケーションで使用可能な環境変数を表示します。
7. **Networking:** アプリケーション内のネットワーキングを説明するためのツールです
8. アプリケーションに関する詳細情報を表示します。

![Home Page](/media/managedlab/10-ostoy-homepage-1.png)

### アプリケーションの詳細

詳細については、アプリをデプロイしたら、左側の[About]メニュー項目をクリックしてください。

![ostoy About](/media/managedlab/5-ostoy-about.png)
