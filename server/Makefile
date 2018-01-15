


#
#
#
SERVLET_FILES=./www/WEB-INF/classes/se/juneday/infosystem/web/LcdDisplay.java
SERVLET_CLASSES=${SERVLET_FILES:%.java=%.class}

SERVLET_JAR=winstone.jar
CLASSPATH=-cp $(SERVLET_JAR)

%.class:%.java
	javac $(CLASSPATH) $<

all: $(SERVLET_CLASSES)

start: $(SERVLET_CLASSES)
	java -jar $(SERVLET_JAR) --webroot=www

hello:
	echo $(SERVLET_FILES)
	echo $(SERVLET_CLASSES)




