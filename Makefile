.PHONY: help

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  create		to create output"
	@echo "  fetch		to fetch input (only run once to fetch input from berlinics.de)"
	@echo "  build		to build docker image (run with -B to force rebuild)"
	@echo "  format		to format code"
	@echo "  test		to test docker image"
	@echo "  run		to run docker image"
	@echo "  all		to create output, build docker image and run docker image"

# Path: Makefile
# fetch input
fetch:
	cd ./input &&\
	wget --wait 1\
	  --recursive\
	  --page-requisites\
	  --convert-links\
	  --span-hosts\
	  --no-clobber\
	  --no-parent\
		--force-html\
	  -e robots=off\
	  --no-check-certificate\
	  --keep-session-cookies\
		--adjust-extension\
		--tries=3\
	  --continue\
	  --accept-regex='/http:\/\/(img|dl|archiv|css)\.berlinics.de/.*$||http:\/\/berlinics.de/.*$/'\
	  -U='\''Mozilla/5.0 (compatible; berlinics.de/SCAN; de-DE,de,en-US,en; v.0.1)\'''\
	  --header 'Accept-encoding: identity'\
		--header 'Accept-language: de-DE'\
	  http://berlinics.de/

# Path: Makefile
# create output
create:
	rm -rf ./output/*
	cp -R ./input/* ./output
# pages
# add .html file ending to every file in output/berlinics.de/page that has no file ending .html
	find ./output/berlinics.de/page -type f -not -name '*.html' -exec bash -c 'mv "$$1" "$${1%.html}.html"' _ {} \;
# remove img elements with src match /zp-core/
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<img[^>]*src="[^"]*zp-core\/c\.php[^"]*"[^>]*>//g' {} \;
# rm zp-core folder
	rm -rf ./output/berlinics.de/zp-core
# remove links that start with /rss.php
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<a[^>]*href="?[^"]*\/index\.php(\?rss|%3Frss)[^"]*"[^>]*>([^<]*)<\/a>/\2/g' {} \;
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<link[^>]*href="?[^"]*\/index\.php(\?rss|%3Frss)[^"]*"[^>]*>//g' {} \;
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<a[^>]*href="?[^"]*\/rss\.php[^"]*"[^>]*>([^<]*)<\/a>/\1/g' {} \;
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<link[^>]*href="?[^"]*\/rss\.php[^"]*"[^>]*>//g' {} \;
# rm index.php?rss files
	rm -rf ./output/berlinics.de/index.php?rss*
	rm -rf ./output/berlinics.de/index.php%3Frss*
	rm -rf ./output/berlinics.de/rss.php*
# remove https://berlinics.de from hrefs
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/href="https:\/\/berlinics.de/href="/g' {} \;
# remove https://berlinics.de from srcs
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/src="https:\/\/berlinics.de/src="/g' {} \;
# remove http://berlinics.de from hrefs
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/href="http:\/\/berlinics.de/href="/g' {} \;
# remove http://berlinics.de from srcs
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/src="http:\/\/berlinics.de/src="/g' {} \;
# rename style.css and remove query params
	find ./output/berlinics.de -type f -name 'style.css?*' -exec bash -c 'mv "$$1" "$${1%\?*}"' _ {} \;
# rename style.css and remove %3F query params
	find ./output/berlinics.de -type f -name 'style.css%3F*' -exec bash -c 'mv "$$1" "$${1%\%3F*}"' _ {} \;
# remove query params from hrefs/srcs with style.css
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/style\.css\?[^"]*"/style\.css"/g' {} \;
# remove %3F query params from hrefs/srcs with style.css
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/style\.css%3F[^"]*"/style\.css"/g' {} \;
# replace href="themes/ with href="/themes/
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/href="themes\//href="\/themes\//g' {} \;
# replace href="/tiny with href="#tiny
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/href="\/tiny/href="#tiny/g' {} \;
# fix
# replace <Liked with &lt;Liked
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<Liked/\&lt;Liked/g' {} \;
# replace <Loved with &lt;Loved
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<Loved/\&lt;Loved/g' {} \;
# add .html to href that ends with .photo
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/href="([^"]*\.photo)"/href="\1.html"/g' {} \;
# additions
# cp addition/js into output/berlinics.de/js
	cp -R ./addition/js/* ./output/berlinics.de/themes/berlinics/js
# add script
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<\/body>/<script src="\/themes\/berlinics\/js\/archiv.js"><\/script><\/body>/g' {} \;
# add font
# copy font from addition/fonts into output/berlinics.de/themes/berlinics/fonts
	cp -R ./addition/fonts ./output/berlinics.de/themes/berlinics/fonts
# add font stylecheet
# copy font from addition/fonts into output/berlinics.de/themes/berlinics/fonts
	cp ./addition/css/font.css ./output/berlinics.de/themes/berlinics/css/font.css
# add font stylecheet to head
	find ./output/berlinics.de -type f -name '*.html' -exec sed -i -E 's/<\/head>/<link rel="stylesheet" href="\/themes\/berlinics\/css\/font.css"><\/head>/g' {} \;
# replace "Trebuchet MS" with "PT Serif" in style.css
	find ./output/berlinics.de -type f -name 'style.css' -exec sed -i -E 's/"Trebuchet MS"/"PT Serif"/g' {} \;
# replace "Georgia" with "PT Serif" in style.css
	find ./output/berlinics.de -type f -name 'style.css' -exec sed -i -E 's/Georgia/"PT Serif"/g' {} \;

# Path: Makefile
# build docker
build:
	rm -rf ./build/*
	cp -R ./output/* ./build
# create docker image
	docker build --no-cache -t archiv.berlinics.de .

# Path: Makefile
# run docker image
run:
	docker run -p 8080:80 archiv.berlinics.de

# Path: Makefile
# test docker image
test:
	output_file="tmp-url-list.txt"; \
	wget --recursive --spider localhost:8080 2>&1 | grep '^--' | awk '{ print $$3 }' | sort | uniq > "$$output_file";\
	expected_file="url-list.txt"; \
	if diff "$$output_file" "$$expected_file"; then \
	    echo "Test passed: Output matches expected content."; \
			rm tmp-url-list.txt; \
			exit 0; \
	else \
	    echo "Test failed: Output does not match expected content."; \
			exit 1; \
	fi; \
	prettier --check . --ignore-path .prettierignore --config .prettierrc

# Path: Makefile
# format code
format:
	prettier --write . --ignore-path .prettierignore --config .prettierrc

# Path: Makefile
# run all
all:
	make create
	make format
	make build -B
	make run
