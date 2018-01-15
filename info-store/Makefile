
JAVA_FILES= ./se/juneday/infostore/domain/Message.java \
  ./se/juneday/infostore/storage/JsonInfoStore.java    \
  ./se/juneday/infostore/storage/InfoStore.java         \
  ./se/juneday/infostore/storage/InfoStoreFactory.java

JAVA_CLASSES=${JAVA_FILES:%.java=%.class}
JAR_FILE=juneday-info.jar
JSON_JAR=org.json.jar

.SUFFIXES: .java .class

%.class:%.java
	javac -cp .:$(JSON_JAR) $<

$(JAR_FILE): $(JAVA_CLASSES)
	jar cvf $(JAR_FILE) $(JAVA_CLASSES)

#what:
#	@echo ": $(JAVA_CLASSES)"

all: $(JAVA_CLASSES) $(JAR_FILE)

clean:
	rm $(JAVA_CLASSES)
