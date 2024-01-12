# mlvp-doc
开源芯片验证分包平台门户


**测试：**
```
# clone 项目
git clone git@github.com:XS-MLVP/mlvp-portal.git
cd mlvp-portal

# 未正式发布前，默认访问密码为 123
# 开启调试服务器，浏览器打开：http://127.0.0.1:1313/?password=123
hugo server --theme=hugo-digital-garden-theme --buildDrafts --baseURL="127.0.0.1"
```


**部署：**
```
cd mlvp-portal
hugo --theme=hugo-digital-garden-theme --baseURL="https://xs-mlvp.github.io/"
```

将生成的 public 为拷贝至 web 服务器


**主题：**
默认主题地址：https://github.com/paulmartins/hugo-digital-garden-theme


**文档编写：**
直接在content中对应目录下创建markdown文件或者子目录。content目录下，最多只支持两级目录。 每个子目录表示一个分类，每个目录需要有一个对应的 _index.md 文件。对于学习资源，每个文件夹下还可以有一个 feature.png文件，用于在首页列表中展示。


举例：
```
content/
├── about                      # 关于我们模块
│   ├── featured.jpg
│   └── index.md
├── crowdsourcing              # 正在进行的分包任务模块
│   ├── _index.md
│   └── kunming_lake           # 分包任务1
│       ├── _index.md          # 分包总描述
│       ├── dut_00.md          # dut 1 介绍
│       └── dut_01.md          # dut 2 介绍
|
├── learningresource           # 学习资源模块
│   ├── _index.md
│   ├── comm                   # 资源分类1
│   │   ├── _index.md
│   │   ├── com_001.md         # 具体资源1
│   │   ├── featured.png       # 资源父类首页列表图片
│   │   └── jessica-weiller-GAw5wFLVWVo-unsplash.jpg  # md文件需要的其他文件
│   ├── course                 # 资源分类2
│   │   ├── _index.md
│   │   ├── crs_001.md
│   │   └── featured.png
│   └── tools                  # 资源分类3
│       ├── _index.md
│       └── tls_00.md
└── partners                   # 合作伙伴模块
    ├── _index.md
    ├── educoder               # 合作伙伴1
    │   ├── index.md           # 配置文件，通过 website 字段配置官网链接
    │   └── logo.jpg           # 合作伙伴logo，在首页展示
    ├── gitlink                # 合作伙伴2
    │   ├── index.md
    │   └── logo.jpg
    └── ysyx                   # 合作伙伴3
        ├── index.md
        └── logo.jpg
```
