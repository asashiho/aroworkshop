---
sectionid: prereq
sectionclass: h2
title: 事前準備
parent-id: intro
---

### AzureサブスクリプションとAzure Red Hat OpenShift環境

{% collapsible %}

まだ環境をプロビジョニングしていない場合は、先に進んで環境を作成してください。このワークショップでは、登録リンクとアクティベーションコードを使って、Microsoftハンズオンラボ環境へのアクセス権が与えられます。お持ちでない方は、講師にお尋ねください。詳細については、Microsoftハンズオンラボの Webサイト[Microsoft Hands-on Labs](https://www.microsoft.com/handsonlabs/)を参照してください。

ここではあなたに提供されたアクティベーションコードで登録を続けてください。


![Registration](media/managedlab/0-registration.png)

登録が完了したら、[Launch Lab]をクリックします。

![Launch lab](media/managedlab/1-launchlab.png)

Azureサブスクリプションと関連するラボの資格情報が準備されます。これには少し時間がかかります。このプロセスでは、Azure Red Hat OpenShiftクラスターもプロビジョニングされます。

![Preparing lab](media/managedlab/2-preparinglab.png)

環境がプロビジョニングされると、認証情報を含む画面が表示されます。さらに、Azure Red Hat OpenShiftクラスターエンドポイントも表示されます。この資格情報は登録時に入力したEメールアドレスにも送信されます。

![Credentials](media/managedlab/3-credentials.png)

{% endcollapsible %}

### Tools

#### Azure Cloud Shell

You can use the Azure Cloud Shell accessible at <https://shell.azure.com> once you login with an Azure subscription.
Azureサブスクリプションでログインすると、[Azure Cloud Shell]<https://shell.azure.com>を使用できます。

{% collapsible %}

あなたの Azure Subscription でログインします。

ここでは **Bash** を選択してください。

![Select Bash](media/cloudshell/0-bash.png)

**Show advanced settings** を選択します。

![Select show advanced settings](media/cloudshell/1-mountstorage-advanced.png)


ストレージアカウントとファイル共有、リソースグループ名を設定します。

![Azure Cloud Shell](media/cloudshell/2-storageaccount-fileshare.png)

これでAzure Cloud Shellにアクセスできるはずです。

![Set the storage account and fileshare names](media/cloudshell/3-cloudshell.png)

{% endcollapsible %}

#### OpenShift CLI (oc)

最新の[OpenShift CLI(oc)](https://github.com/openshift/origin/releases/tag/v3.11.0)クライアントツールをダウンロードします。GitHubへのリンクをたどり、Azure Cloud Shellで以下の手順に従います。

{% collapsible %}

> **Note** リンクを最新のものに変更してください。 
> ![GitHub release links](media/github-oc-release.png)

```sh
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

mkdir openshift

tar -zxvf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz -C openshift --strip-components=1
```

ocコマンドはopenshiftディレクトリにあります。

> **Note** openshiftディレクトリからOpenShift CLIコマンドを実行してください。 `./oc`.

{% endcollapsible %}