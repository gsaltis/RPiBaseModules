CC					= gcc
ARCHIVE					= ar
INSTALL					= cp
CC_FLAGS				= -g -Wall -c
ARCHIVE_FLAGS				= r

MONGOOSE_LIB				= libmongoose.a
MONGOOSE_OBJS				= mongoose.o

LINENOISE_LIB				= liblinenoise.a
LINENOISE_OBJS				= linenoise.o

SQLITE3_LIB				= libsqlite3.a
SQLITE3_OBJS				= sqlite3.o

JSON_LIB				= libjson.a
JSON_OBJS				= json.o

INSTALL_DIR_LIBS			= /usr/local/lib
INSTALL_DIR_HEADERS			= /usr/local/include

LIBS					= $(MONGOOSE_LIB) $(SQLITE3_LIB) $(LINENOISE_LIB) $(JSON_LIB)
HEADERS					= $(sort mongoose.h sqlite3.h linenoise.h json.h)

%.o					: %.c
					  @echo [CC] $@
					  @$(CC) $(CC_FLAGS) $<

LIBS					= $(sort			    \
					    $(MONGOOSE_LIB)		    \
					    $(LINENOISE_LIB)		    \
					    $(SQLITE3_LIB)		    \
					    $(JSON_LIB)			    \
					   )

all					: $(LIBS)

$(MONGOOSE_LIB)				: $(MONGOOSE_OBJS)
					  @echo [AR] $(MONGOOSE_LIB)
					  @$(ARCHIVE) $(ARCHIVE_FLAGS) \
					   $(MONGOOSE_LIB) $(MONGOOSE_OBJS)

$(LINENOISE_LIB)		        : $(LINENOISE_OBJS)
					  @echo [AR] $(LINENOISE_LIB)
					  @$(ARCHIVE) $(ARCHIVE_FLAGS) \
					   $(LINENOISE_LIB) $(LINENOISE_OBJS)

$(JSON_LIB)				: $(JSON_OBJS)
					  @echo [AR] $(JSON_LIB)
					  @$(ARCHIVE) $(ARCHIVE_FLAGS) \
					   $(JSON_LIB) $(JSON_OBJS)

$(SQLITE3_LIB)				: $(SQLITE3_OBJS)
					  @echo [AR] $(SQLITE3_LIB)
					  @$(ARCHIVE) $(ARCHIVE_FLAGS) \
					   $(SQLITE3_LIB) $(SQLITE3_OBJS)

install					: $(LIBS)
					  $(INSTALL) $(LIBS) $(INSTALL_DIR_LIBS)
					  $(INSTALL) $(HEADERS) $(INSTALL_DIR_HEADERS)

.PHONY					: junkclean
junkclean				:
					  rm -rf $(wildcard *~)

.PHONY					: clean
clean					: junkclean
					  rm -rf $(wildcard *.o *.a)
