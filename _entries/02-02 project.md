---
sectionid: createproject
sectionclass: h2
title: プロジェクトの作成
parent-id: lab-ratingapp
---

### Web Consoleへのログイン

{% collapsible %}

Azure Red Hat OpenShiftクラスタは、OpenShift Web Consoleをホストするパブリックホスト名を持ちます。

次のコマンドを実行してホスト名を取得します。ここで<cluster name>と<resource group>は固有の値になります。

```sh
az openshift show -n <cluster name> -g <resource group> --query "publicHostname" -o tsv
```

例えばopenshift.77f472f620824da084be.eastus.azmosa.ioが得られたら
先頭に「https://」を追加してブラウザでリンクを開きます。ここでAzure Active Directoryにログインするように求められます。ラボではあなたに提供されたユーザー名とパスワードを使用してください。

ログインすると、Azure Red Hat OpenShift Webコンソールが表示されます。

![Azure Red Hat OpenShift Web Console](media/openshift-webconsole.png)

{% endcollapsible %}

### ログインとトークンの取得

{% collapsible %}

> **Note** OpenShift CLIをAzure Cloud Shellにインストールするための[前提条件](#prereq)をすべて満たしていることを確認してください。

Webコンソールにログインしたら、右上のユーザー名を選び **Copy login command** をクリックします。

![Copy login command](media/login-command.png)

[Azure Cloud Shell](https://shell.azure.com)を開き、OpenShift CLIをダウンロードした場所に移動して、loginコマンドを貼り付けます。これでクラスタに接続できるはずです。

![Login through the cloud shell](media/oc-login-cloudshell.png)

{% endcollapsible %}

### プロジェクトの作成

{% collapsible %}

OpenShiftではプロジェクトによって、ユーザーのコミュニティは他のコミュニティとは独立してコンテンツを整理および管理できます。

```sh
./oc new-project workshop
```

{% endcollapsible %}

> **Resources**
> * <https://docs.openshift.com/aro/getting_started/access_your_services.html>
> * <https://docs.openshift.com/aro/cli_reference/get_started_cli.html>
> * <https://docs.openshift.com/aro/dev_guide/projects.html>