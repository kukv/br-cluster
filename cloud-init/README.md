# cloud-initの設定置き場

build.shを叩く前提の内容になっているので注意

## ディレクトリ構成
```
.
├── build.sh
├── generated // テンプレートから生成されたファイルが格納されている場所
│    ├── br-gateway1
│    ├── br-k3s-master1
│    ・
│    ・
│    ・
│    └── br-k3s-worker3
│
├── templates // 生成したいテンプレートが置かれている場所 
│
├── values // jinja2で置き換えたい値を格納している場所
│    ├── network-config_br-gateway1.json
│    ├── user-data_br-gateway1.json
│    ・
│    ・
│    ・
│    ├── user-data_br-k3s-worker2.json
│    └── user-data_br-k3s-worker3.json
│
└── values-secret // jinja2で置き換えたい値(シークレットな)を格納している場所
    ├── README.md
    ├── network-config_br-gateway1.json
    ├── user-data_br-gateway1.json
    ・
    ・
    ・
    └── user-data_br-k3s-worker3.json
```

### generated

ここにjinja2で生成されたファイルが格納される

### templates

ファイル名の命名規則は特に無し

jinja2に準拠したテンプレートファイルを作成して格納する

### values

ファイル名の規則は以下のようになっている
```
<<templateファイル名(拡張子なし)>>_<<gateway-list, clusetr-list記載のserver名>>.json
```
シークレットな値に関するキーも含めてjsonに記載すること(値はわかりやすければなんでも良い)

### values-secret

サブモジュールとなっているため、サブモジュール先で編集すること

ファイル名の規則は以下のようになっている
```
<<templateファイル名(拡張子なし)>>_<<gateway-list, clusetr-list記載のserver名>>.json
```

## 実行方法

br-clusterディレクトリ直下に`gateway-list`, `cluster-list`ファイルが必要

上記のディレクトリ構成通りに構成できるのであればbuild.shを叩けばすぐ動く
```
./build.sh
```
