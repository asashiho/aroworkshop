---
sectionid: scaling
sectionclass: h2
title: クラスタのスケール
parent-id: lab-ratingapp
---

### Azure Red Hat OpenShiftクラスターをスケールする

Azure CLIを使用して、クラスター内のアプリケーションノードの数を増やすことができます。

Azure Cloud Shellで以下のコマンドを実行して、クラスターを5つのアプリケーションノードに拡張します。ここで、`<cluster name>`  と`<resource group name>` はあなたの適切な値に変更してください。数分後、`az openshift scale`  は正常に完了し、スケーリングされたクラスターの詳細を含むJSONドキュメントを返します。

```sh
az openshift scale  --name <cluster name> --resource-group <resource group name> --compute-count 5
```

> **Resources**
> * [ARO Documentation - Scaling the cluster](https://docs.microsoft.com/en-us/azure/openshift/tutorial-scale-cluster)
