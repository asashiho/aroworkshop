---
sectionid: appoverview
sectionclass: h2
title: アプリケーションの概要
parent-id: labs
---

Azure Red Hat OpenShiftにサンプルアプリケーションをデプロイします。

![Application diagram](media/app-overview.png)

アプリケーションは3つのコンポーネントで構成されています。:

| Component                                          | Link                                                               |
|----------------------------------------------------|--------------------------------------------------------------------|
| A public facing API `rating-api`                   | [GitHub repo](https://github.com/microsoft/rating-api)             |
| A public facing web frontend `rating-web`          | [GitHub repo](https://github.com/microsoft/rating-web)             |
| A MongoDB with pre-loaded data                     | [Data](https://github.com/microsoft/rating-api/raw/master/data.tar.gz)   |

完成すると次のようなアプリケーションになります。

![Application](media/app-overview-1.png)
![Application](media/app-overview-2.png)
![Application](media/app-overview-3.png)