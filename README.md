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
