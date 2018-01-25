


#
#
#
SERVLET_FILES=./www/WEB-INF/classes/se/juneday/infosystem/web/LcdDisplay.java
SERVLET_CLASSES=${SERVLET_FILES:%.java=%.class}

INFO_JAR=www/WEB-INF/lib/juneday-info.jar
SERVLET_JAR=winstone.jar
JSON_JAR=org.json.jar
CLASSPATH=-cp $(SERVLET_JAR):$(JSON_JAR):www/WEB-INF/classes:../info-store/

%.class:%.java
	javac $(CLASSPATH) $<

all: $(SERVLET_CLASSES) $(INFO_JAR)

start: $(SERVLET_CLASSES)
	java  -jar $(SERVLET_JAR) --webroot=www
#-cp www/WEB-INF/classes:www/WEB-INF/lib

$(INFO_JAR):
	mkdir -p www/WEB-INF/lib/
	cp ../info-store/*.jar www/WEB-INF/lib/

clean:
	-rm $(SERVLET_CLASSES) $(INFO_JAR)

hello:
	echo $(SERVLET_FILES)
	echo $(SERVLET_CLASSES)




