---
sectionid: lab2-heathcheck
sectionclass: h2
title: ヘルスチェック
parent-id: lab-clusterapp
---
このセクションでは、Podを意図的にクラッシュさせるだけでなく、PodをKubernetesのLiveness Probeに反応しないようにして、Kubernetesの動作を確認します。まず意図的にPodをクラッシュさせ、Kubernetesが自己回復してすぐにスピンアップすることを確認します。そしてアプリのエンドポイント`/health` で応答を停止してヘルスチェックをトリガーします。3回連続して失敗した後、KubernetesはPodをkillから作り直すべきです。

{% collapsible %}

OpenShift Web UIとOSToyアプリケーションの間で画面を分割して準備することをお勧めします。そうすれば、すぐに結果を見ることができます。

![Splitscreen](/media/managedlab/23-ostoy-splitscreen.png)


ただし、画面が小さすぎる場合やそれがうまくいかない場合は、別のタブでOSToyアプリケーションを開くと、ボタンをクリックするとすぐにOpenShift Webコンソールに切り替えることができます。OpenShift Webコンソールでこの配置に移動するには、次のURLにアクセスしてください。

「Applications」>「Deployments」>「ostoy-frontend」行の「Last Version」列の番号をクリックします。


![Deploy Num](/media/managedlab/11-ostoy-deploynum.png)

OSToyアプリに行き、左側のメニューで *Home* をクリックし、そして「Crash Pod」タイルにメッセージを入力して（すなわち、「This is goodbye！」）、そして「Crash Pod」ボタンを押します。これによりPodがクラッシュし、KubernetesはPodを再起動します。ボタンを押すと次のように表示されます。

![Crash Message](/media/managedlab/12-ostoy-crashmsg.png)


すぐに配置画面に切り替えます。ポッドが赤、つまりダウンしていることがわかりますが、すぐに青に表示されます。

![Pod Crash](/media/managedlab/13-ostoy-podcrash.png)

Podのイベントをチェックして、コンテナがクラッシュして再起動したことを確認することもできます。

![Pod Events](/media/managedlab/14-ostoy-podevents.png)

Podのイベントのページは、手順4から開いたままにします。次に、OSToyアプリの "Toggle Health Status" タイルの "Toggle Health" ボタンをクリックします。あなたは"Current Health" で "I'm not feeling all that well" に切り替えられるのを確認できます。

![Pod Events](/media/managedlab/15-ostoy-togglehealth.png)

これにより、アプリは "200 HTTP code" で応答しなくなります。3回連続して失敗した後（"A"）、Kubernetesはポッドを殺し（"B"）、再開します（"C"）。すばやくPodのイベントタブに戻ると、liveliness probeが失敗し、Podが再起動中であることがわかります。

![Pod Events2](/media/managedlab/16-ostoy-podevents2.png)

{% endcollapsible %}
