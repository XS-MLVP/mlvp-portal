.DEFAULT_GOAL = test

BASE_URL = "https://open-verify.cc"
#BASE_URL = "https://xs-mlvp.github.io"

init:
	git clone https://github.com/XS-MLVP/course.git --depth 1 ../course
	git clone https://github.com/XS-MLVP/doc-xs-ov-00-bpu.git --depth 1 ../doc-xs-ov-00-bpu

build: clean
	hugo --minify --theme=hugo-digital-garden-theme --baseURL="$(BASE_URL)"
# mlvp build
	cd ../course && rm -rf public && git pull && hugo --baseURL="$(BASE_URL)/mlvp/"
	cp -r ../course/public ./public/mlvp
# xs-bpu build
	cd ../doc-xs-ov-00-bpu && rm -rf public && git pull && hugo --baseURL="$(BASE_URL)/xs-bpu/"
	cp -r ../doc-xs-ov-00-bpu/public ./public/xs-bpu
# UnityChipForXiangShan
	cd ../UnityChipForXiangShan/documents && rm -rf public && git pull && mkdir -p static/data/reports && touch static/data/reports/_.txt && hugo --baseURL="$(BASE_URL)/UnityChipForXiangShan/"
	cp -r ../UnityChipForXiangShan/documents/public ./public/UnityChipForXiangShan

test: clean
	hugo --theme=hugo-digital-garden-theme --baseURL="http://127.0.0.1:1313/"
	cd ../course && git pull && hugo --baseURL="http://127.0.0.1:1313/mlvp/"
	cd ../doc-xs-ov-00-bpu && git pull && hugo --baseURL="http://127.0.0.1:1313/xs-bpu/"
	cd public && cp -r ../../course/public ./mlvp
	cd public && cp -r ../../doc-xs-ov-00-bpu/public ./xs-bpu
	cd public && python3 -m http.server 1313

clean:
	rm -rf public

rbuild: clean build
