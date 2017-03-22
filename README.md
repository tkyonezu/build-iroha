# 「いろは」を優しくビルドするためのスクリプト

手順

1. いろはをクローンします。

```
git clone https://github.com/hyperledger/iroha.git
```

2. このスクリプトをクローンします。

```
cd iroha/docker
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

さぁ、うまくできるかな...

ワクワク！

Copyright (c) 2017, Takeshi Yonezu
All Rights Reserved.
