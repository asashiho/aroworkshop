---
sectionid: concepts
sectionclass: h2
title: 基本概念
parent-id: intro
---

### Source-To-Image (S2I)

Source-to-Image(S2I)は、ソースコードから再現可能なコンテナイメージを構築するためのワークフローです。S2Iをつかうと、ソースコードから実行可能なイメージを生成します。これによりコンテナーイメージを使用してランタイム環境をバージョン管理するのとまったく同じように、ビルド環境をバージョン管理し、制御することができます。

#### How it works

{% collapsible %}

Rubyのような言語の場合、ビルド時環境とランタイム環境は通常同じです。この環境を記述するbuilder image（Ruby、Bundler、Rake、Apache、GCC、およびRubyアプリケーションをインストールして実行するために必要なその他のパッケージ）から始めて、source-to-imageは以下のステップを実行します。

1. まずアプリケーションソースをディレクトリに入れて、builder imageからコンテナを起動します。

1. コンテナプロセスはそのソースコードを実行可能な設定に変換します。この場合、ソースコードのApacheがRuby config.ruファイルを探すように事前設定されているディレクトリに移動し、Bundlerとの依存関係をインストールします。

1. 新しいコンテナをコミットし、imageのエントリーポイントを（builder imageによって提供）設定して、ApacheがRubyアプリケーションをホストするようにします。


C、C ++、Go、またはJavaなどのコンパイル済み言語の場合、コンパイルに必要な依存関係が実際のランタイム成果物のサイズが大きくなる場合があります。そのためランタイムイメージをスリムに保つために、S2Iはマルチステップビルドプロセスを有効にします。このプロセスでは、実行可能ファイルやJava WARファイルなどのバイナリが最初のビルダーイメージで作成されます。

たとえば、Tomcat（一般的なJava Webサーバー）とMaven用のビルドパイプラインを作成するには、次のようにします。

1. WARファイルとOpenJDKとTomcatを含むビルダーイメージを作成します。

1. 最初のイメージMavenおよびその他の依存関係の上にイメージを作成し、Mavenプロジェクトが作成されます。

1. JavaアプリケーションのソースとMavenイメージを使用してsource-to-imageを呼び出し、アプリケーションWARを作成します。

1. 前のステップのWARファイルと最初のTomcatイメージを使用して、source-to-imageをもう一度呼び出しランタイム・イメージを作成します。

このようにビルドロジックをイメージ内に配置し、イメージを複数のステップに組み合わせることで、ビルドツールを運用環境にデプロイすることなく、ランタイム環境をビルド環境（同じJDK、同じTomcat JAR）に近づけることができます。

{% endcollapsible %}

#### Goals and benefits

{% collapsible %}

##### Reproducibility

ビルド環境をコンテナイメージ内にカプセル化し、呼び出し元のための単純なインタフェース（ソースコード）を定義することによって、ビルド環境を厳密にバージョン管理することができます。再現性のあるビルドは、セキュリティの更新とコンテナ化されたインフラストラクチャへのCIを実現するための重要な要件です。

##### Flexibility

Linux上で実行できる既存のビルド環境はすべてコンテナ内で実行でき、個々のビルダーもより大きなパイプラインの一部になることができます。さらに、アプリケーションのソースコードを処理するスクリプトをビルダーイメージに挿入できるため、作成者は既存のイメージを修正してsource handlingを可能にします。

##### Speed

1つのDockerfileに複数のレイヤーを構築するのではなく、S2Iは作成者が1つのアプリケーションを1つのイメージレイヤーに表現することを推奨します。これにより、作成および展開中の時間が短くなり、最終イメージの出力をより適切に制御できます。

##### Security

Dockerfilesは、通常はrootとして実行され、コンテナネットワークにアクセスできる、通常のコンテナの多くの操作上の制御なしで実行されます。ビルドは単一のコンテナー内で起動されるため、S2Iを使用してビルダーイメージに使用できるアクセス許可と特権を制御できます。OpenShiftのようなプラットフォームと連携して、source-to-imageによって、管理者は開発者がビルド時に持つ特権を厳密に制御できます。

{% endcollapsible %}

### Routes

OpenShift Routeは、www.example.comのようにホスト名でサービスを公開しているため、外部クライアントは名前でアクセスできます。RouteオブジェクトがOpenShift上に作成され、それが要求されたサービスを公開し、与えられた構成で、それが外部から利用できるようにするために内部のHAProxyロードバランサによって処理されます。あなたがKubernetesのIngressオブジェクトに精通している場合、すでに「違いは何ですか」という疑問を持つかもしれません。Red HatはRouteという概念を作成し、その背後にある設計原則をコミュニティに提供しました。これはIngressデザインに大きな影響を与えました。以下の表に見られるように、Routeにはいくつかの追加機能があります。

![routes vs ingress](/media/managedlab/routes-vs-ingress.png)

> **NOTE:** ホスト名のDNS解決はルーティングとは別に処理されます。管理者が常にルーターに正しく解決されるクラウドドメインを設定しているか、無関係なホスト名を使用している場合は、ルーターに解決するためにDNSレコードを個別に変更する必要があります。

また、routeはannotationで特定の設定を提供することによっていくつかのデフォルトを上書きすることができるということにも注目すべきです。詳細については、こちらを参照してください

[https://docs.openshift.com/dedicated/architecture/networking/routes.html#route-specific-annotations](https://docs.openshift.com/dedicated/architecture/networking/routes.html#route-specific-annotations)

### ImageStreams

ImageStreamは、イメージへのタグのマッピング、イメージがStream内でタグ付けされたときに適用されるメタデータオーバーライド、およびレジストリのDockerイメージリポジトリへのオプションの参照を格納します。

#### 利点は何ですか? 

{% collapsible %}

ImageStreamを使用すると、コンテナイメージのタグを簡単に変更できます。それ以外の場合は、タグを変更するには、コンテナイメージ全体をダウンロードし、ローカルに変更してから、すべて元に戻す必要があります。また、タグを変更してから展開オブジェクトを更新することでアプリケーションを宣伝するには、多くのステップが必要です。ImageStreamsでは、コンテナイメージを一度アップロードしてから、そのタグをOpenShiftの内部で管理します。あるプロジェクトでは、devタグを使用してそのタグへの参照のみを内部的に変更することができますが、prodではprodタグを使用して内部的に管理することもできます。あなたは本当にレジストリを扱う必要はありません！

また、ImageStreamをDeploymentConfigsと組み合わせて使用​​して、新しいコンテナイメージが表示されたりタグの参照を変更したりするとすぐにDeploymentを開始するトリガを設定することもできます。

{% endcollapsible %}


詳細については、こちらを参照してください: 

[https://blog.openshift.com/image-streams-faq/](https://blog.openshift.com/image-streams-faq/) <br>
OpenShift Docs: [https://docs.openshift.com/container-platform/3.11/dev_guide/managing_images.html](https://docs.openshift.com/container-platform/3.11/dev_guide/managing_images.html)<br>
ImageStream and Builds: [https://cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/](https://cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/)


### Builds

Buildは、入力パラメータを結果のオブジェクトに変換するプロセスです。ほとんどの場合、このプロセスは入力パラメータまたはソースコードを実行可能なコンテナイメージに変換するために使用されます。BuildConfigオブジェクトは、ビルドプロセス全体の定義です。

OpenShift Container Platformは、ビルドイメージからDockerコンテナを作成してコンテナイメージレジストリにプッシュすることで、Kubernetesを利用します。

ビルドオブジェクトには、ビルドの入力／ビルドプロセスの完了／ビルドプロセスのログ記録／成功したビルドからのリソースの公開／ビルドの最終ステータスの公開という共通の機能があります。ビルドはリソース制限を利用して、CPU使用率／メモリ使用量／ビルドまたはPodの実行時間などのリソースに対する制限を指定します。

詳細については、こちらを参照してください:

 [https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/builds_and_image_streams.html](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/builds_and_image_streams.html)

