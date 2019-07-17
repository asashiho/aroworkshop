---
sectionid: lab2-storage
sectionclass: h2
title: 永続ストレージ
parent-id: lab-clusterapp
---

このセクションでは、クラスタ内の永続的ボリュームに格納されるファイルを作成することによって永続的ストレージを使用する簡単な例を実行し、それがポッドの障害や再作成を超えて"persist" することを確認します。

{% collapsible %}

OpenShiftのWeb UI内で、左側のメニューの *Storage* をクリックします。その後、私たちのアプリケーションが行ったすべての永続的ボリュームのリストが表示されます。この場合"ostoy-pvc"という名前のものだけがあります。バインドされているかどうか／サイズ／access mode／ageなどの関連情報も表示されます。

この場合、モードはRWO（Read-Write-Once）で、ボリュームは1つのノードにしかマウントできませんが、ポッドはそのボリュームに対して読み取りと書き込みの両方を実行できます。AROの既定の設定では、Persistent VolumeはAzure Diskでバックアップされますが、RWX（Read-Write-Many）アクセスモードを使用できるようにAzure Filesを選択することもできます。

([アクセスモードの詳細についてはこちらをご覧ください](https://docs.openshift.com/aro/architecture/additional_concepts/storage.html#pv-access-modes))

OSToyアプリの左側のメニューにある *Persistent Storage* をクリックします。"Filename" エリアに、作成するファイルのファイル名を入力します。（例： "test-pv.txt"）

その下の"File Contents" ボックスに、ファイルに保存するテキストを入力します。（例：「Azure Red Hat OpenShift is the greatest thing since sliced bread!」または「test」)。

次に「ファイルを作成」​​をクリックします。

![Create File](/media/managedlab/17-ostoy-createfile.png)

作成したファイルが "Existing files" の下に表示されます。ファイルをクリックすると、ファイル名と入力した内容が表示されます。

![View File](/media/managedlab/18-ostoy-viewfile.png)


Podをkillして、スピンアップした新しいPodが作成したファイルを確認できるようにします。前のセクションで行ったのとまったく同じです。左側のメニューで *Home* をクリックします。

"Crash pod"ボタンをクリックしてください。（必要に応じてメッセージを入力できます）

左側のメニューで *Persistent Storage* をクリックします

あなたはあなたが作成したファイルが永続化されているのを確認できます。

![Crash Message](/media/managedlab/19-ostoy-existingfile.png)

{% endcollapsible %}
