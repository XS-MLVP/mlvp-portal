.DEFAULT_GOAL = test

build: clean
	hugo --theme=hugo-digital-garden-theme --baseURL="https://xs-mlvp.github.io/"
	cd ../course && rm -rf public
	cd ../course && hugo --baseURL="https://xs-mlvp.github.io/mlvp/"
	cd ../doc-xs-ov-00-bpu && rm -rf public
	cd ../doc-xs-ov-00-bpu && hugo --baseURL="https://xs-mlvp.github.io/xs-bpu/"
	cd public && cp -r ../../course/public ./mlvp
	cd public && cp -r ../../doc-xs-ov-00-bpu/public ./xs-bpu

test: clean
	hugo --theme=hugo-digital-garden-theme --baseURL="http://127.0.0.1:1313/"
	cd ../course && hugo --baseURL="http://127.0.0.1:1313/mlvp/"
	cd ../doc-xs-ov-00-bpu && hugo --baseURL="http://127.0.0.1:1313/xs-bpu/"
	cd public && cp -r ../../course/public ./mlvp
	cd public && cp -r ../../doc-xs-ov-00-bpu/public ./xs-bpu
	cd public && python -m http.server 1313

clean:
	rm -rf public

rbuild: clean build
