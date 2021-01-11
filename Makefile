CC					= gcc
ARCHIVE					= ar

CC_FLAGS				= -g -Wall -c
ARCHIVE_FLAGS				= r

MONGOOSE_LIB				= libmongoose.a
MONGOOSE_OBJS				= mongoose.o

LINENOISE_LIB				= liblinenoise.a
LINENOISE_OBJS				= linenoise.o

SQLITE3_LIB				= libsqlite3.a
SQLITE3_OBJS				= sqlite3.o

%.o					: %.c
					  @echo [CC] $@
					  @$(CC) $(CC_FLAGS) $<

LIBS					= $(sort			    \
					    $(MONGOOSE_LIB)		    \
					    $(LINENOISE_LIB)		    \
					    $(SQLITE3_LIB)		    \
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

$(SQLITE3_LIB)				: $(SQLITE3_OBJS)
					  @echo [AR] $(SQLITE3_LIB)
					  @$(ARCHIVE) $(ARCHIVE_FLAGS) \
					   $(SQLITE3_LIB) $(SQLITE3_OBJS)

.PHONY					: junkclean
junkclean				:
					  rm -rf $(wildcard *~)

.PHONY					: clean
clean					: junkclean
					  rm -rf $(wildcard *.o *.a)
