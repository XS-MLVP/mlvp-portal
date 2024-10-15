.DEFAULT_GOAL = test

init:
	git clone git@github.com:XS-MLVP/course.git --depth 1 ../course
	git clone git@github.com:XS-MLVP/doc-xs-ov-00-bpu.git --depth 1 ../doc-xs-ov-00-bpu

build: clean
	hugo --minify --theme=hugo-digital-garden-theme --baseURL="https://xs-mlvp.github.io/"
# mlvp build
	cd ../course && rm -rf public && git pull && hugo --baseURL="https://xs-mlvp.github.io/mlvp/"
	cp -r ../course/public ./public/mlvp
# xs-bpu build
	cd ../doc-xs-ov-00-bpu && rm -rf public && git pull && hugo --baseURL="https://xs-mlvp.github.io/xs-bpu/"
	cp -r ../doc-xs-ov-00-bpu/public ./public/xs-bpu
# UnityChipForXiangShan
	cd ../UnityChipForXiangShan/documents && rm -rf public && git pull && hugo --baseURL="https://xs-mlvp.github.io/unitychipforxiangshan/"
	cp -r ../UnityChipForXiangShan/documents/public ./public/unitychipforxiangshan

test: clean
	hugo --theme=hugo-digital-garden-theme --baseURL="http://127.0.0.1:1313/"
	cd ../course && git pull && hugo --baseURL="http://127.0.0.1:1313/mlvp/"
	cd ../doc-xs-ov-00-bpu && git pull && hugo --baseURL="http://127.0.0.1:1313/xs-bpu/"
	cd public && cp -r ../../course/public ./mlvp
	cd public && cp -r ../../doc-xs-ov-00-bpu/public ./xs-bpu
	cd public && python -m http.server 1313

clean:
	rm -rf public

rbuild: clean build
