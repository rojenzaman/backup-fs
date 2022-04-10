LIST = LIST
DIR = fs

backup: $(LIST)
	mkdir -p $(DIR)
	lib/get.sh -l $(LIST) -d $(DIR)

clean: $(DIR)
	rm -rf $(DIR)
