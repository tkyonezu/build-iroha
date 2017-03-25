# 「いろは」を優しくビルドするためのスクリプト

手順

1. いろはをクローンします。

```
git clone https://github.com/hyperledger/iroha.git
```

IROHA_HOMEを設定しておきます。
```
cd iroha
export IROHA_HOME=$(pwd)
```

2. このスクリプトをクローンします。

```
cd docker
git clone https://github.com/tkyonezu/build-iroha.git
```

3. 追加スクリプトをコピーします。

```
cd build-iroha
cp mkrel.sh ../dev
```

4. スクリプトを実行しちゃいましょう。

```
bash build-iroha.sh
```

5. 出来上がったコンテナを実行しましょう。

```
docker run -d hyperledger/iroha-docker
```

6. 実行時の注意

現在の iroha-docker は CMD で run.sh を実行しているのですが、run.sh で最初に make_sumeragi を実行して config/sumeragi.json を上書きしています。そのため、複数のノードを使用するために config をマウントしても、そこにある sumeragi.json が上書きされてしまいます。つまり、1ノードでしか実行できないじょうたいとなります。

幸い Dockerfile で、ENTRYPOINT ではなく CMD を使用していますので、複数ノードで実行するばあいには、以下のように実行します。

```
docker run -d --name iroha-docker -v ${IROHA_HOME}/config:/iroha/config hyperledger/iroha-docker /iroha/bin/iroha-main
```

さぁ、うまくできるかな...

ワクワク！

Copyright (c) 2017, Takeshi Yonezu
All Rights Reserved.
