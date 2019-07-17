---
sectionid: lab2-logging
sectionclass: h2
title: ロギング
parent-id: lab-clusterapp
---

提供されたルート経由でアプリケーションにアクセスでき、それでもCLIにログインしていると仮定して（これらのいずれかを実行する必要がある場合はパート2に戻ってください）、このアプリケーションの開始します。前述のように、このアプリケーションではOpenShiftの「ボタンを押す」ことができ、それがどのように機能するのかを確認できます。

{% collapsible %}

*Home* メニュー項目をクリックしてから、 "Log Message (stdout)" のメッセージボックスをクリックして、出力するメッセージを *stdout* に書き込みます。あなたは"**All is Well**" を試すことができます。次に "Send Message" をクリックします。

![Logging stdout](/media/managedlab/8-ostoy-stdout.png)

"Log Message (stderr)" のメッセージボックスをクリックして、出力したいメッセージをstderrストリームに書き込みます。あなたは"**Oh no! Error!**" を試すことができます。次に "Send Message" をクリックします。

![Logging stderr](/media/managedlab/9-ostoy-stderr.png)

CLIに移動して次のコマンドを入力し、Podのログを表示するために使用するfrontendのPod名を取得します。

```sh
[okashi@ok-vm ~]# oc get pods -o name
pod/ostoy-frontend-679cb85695-5cn7x
pod/ostoy-microservice-86b4c6f559-p594d
```


この場合のポッド名は **ostoy-frontend-679cb85695-5cn7x** です。ここで `oc logs ostoy-frontend-679cb85695-5cn7x` コマンドを実行します。

```sh
[okashi@ok-vm ostoy]# oc logs ostoy-frontend-679cb85695-5cn7x
[...]
ostoy-frontend-679cb85695-5cn7x: server starting on port 8080
Redirecting to /home
stdout: All is well!
stderr: Oh no! Error!
```

標準出力と標準エラーの両方のメッセージが表示されるはずです。

{% endcollapsible %}
