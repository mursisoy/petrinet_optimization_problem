OBJECTS = $(wildcard chapters/*.md)

all: 
	pandoc $(OBJECTS) --toc --number-sections --resource-path=./chapters/ \
	--metadata-file "metadata.yml" --include-in-header main.tex \
	--listings \
	-V linkcolor:blue -o report.pdf

clean:
	rm -rf build