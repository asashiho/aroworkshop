---
sectionid: intro
sectionclass: h1
title: Azure Red Hat OpenShift Workshop
type: nocount
is-parent: yes
---

[Azure Red Hat OpenShift](https://azure.microsoft.com/en-us/services/openshift/)はMicrosoftとRed Hatが共同で設計/サポートしている、Red Hat OpenShiftマネージドサービスです。このラボでは、Azure Red Hat OpenShiftの上にコンテナーベースのアプリケーションを展開するために概念を理解するのに役立つ内容を説明します。

目次：

- Azure Red Hat OpenShift Web Consoleで[project](https://docs.openshift.com/aro/dev_guide/projects.html) を作成する
- Deploying a MongoDB container that uses Azure Disks for 
Azure Disksを[永続ストレージ](https://docs.openshift.com/aro/dev_guide/persistent_volumes.html)として使用するMongoDBコンテナーのデプロイ
- Restoring data into the MongoDB container by  on the Pod
Podで[コマンド](https://docs.openshift.com/aro/dev_guide/executing_remote_commands.html)を実行してMongoDBコンテナーにデータを復元する
- [Source-To-Image (S2I)](https://docs.openshift.com/aro/creating_images/s2i.html)を使用してGit HubからNode JS APIとフロントエンドアプリケーションをデプロイする
- [Routes](https://docs.openshift.com/aro/dev_guide/routes.html)を使ってWebアプリケーションのフロントエンドを公開する
- Creating a  to control communication between the different tiers in the application
アプリケーション内の通信を制御するための[ネットワークポリシー](https://docs.openshift.com/aro/admin_guide/managing_networking.html#admin-guide-networking-networkpolicy)の作成
- スケーリングポリシーを設定し、[水平ポッドオートスケーラー](https://docs.openshift.com/aro/dev_guide/pod_autoscaling.html)を使用する
- 継続的インテグレーション/継続的デプロイメント（CI / CD）の実施
- アプリケーションの監視、ロギング、メトリック

ラボはOpenShift CLIを使用して実行しますが、Azure Red Hat OpenShift Webコンソールを使用して実行することもできます。