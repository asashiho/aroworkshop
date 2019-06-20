---
sectionid: networkpolicy
sectionclass: h2
title: ネットワークポリシーの作成
parent-id: labs
---

Now that you have the application working, it is time to apply some security hardening. You'll use [network policies](https://docs.openshift.com/aro/admin_guide/managing_networking.html#admin-guide-networking-networkpolicy) to restrict communication to the `rating-api`.
アプリケーションが動作したので、セキュリティを強化しましょう。ここでは[network policies](https://docs.openshift.com/aro/admin_guide/managing_networking.html#admin-guide-networking-networkpolicy)を使って通信を制限します。

### クラスタコンソールに切り替える

{% collapsible %}

クラスタコンソールページに切り替えます。**Create Network Policy** をクリックします。 
![Cluster console page](media/cluster-console.png)

{% endcollapsible %}

### ネットワークポリシーを作成する

{% collapsible %}

ここで `app=rating-api` ラベルに一致するPodに適用されるポリシーを作成します。ポリシーは、`app=rating-api` ラベルに一致するPodからのingressを許可します。

下のエディタでYAMLを使用して、`workshop` プロジェクトをターゲットにしていることを確認してください。


```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow-from-web
  namespace: workshop
spec:
  podSelector:
    matchLabels:
      app: rating-api
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: rating-web
```

![Create network policy](media/create-networkpolicy.png)

作成をクリックします。

{% endcollapsible %}

> **Resources**
> * <https://docs.openshift.com/aro/admin_guide/managing_networking.html#admin-guide-networking-networkpolicy>