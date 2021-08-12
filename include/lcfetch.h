#include <lua.h>
#include <lualib.h>

#ifndef LCFETCH_H
#define LCFETCH_H

/* lcfetch version */
#define VERSION "0.1.0"

/* copyright notice */
#define COPYRIGHT                                                                                                      \
    "Copyright (c) 2021 NTBBloodbath\nlcfetch is licensed under GPLv2 "                                                \
    "license."

/* lcfetch.c */
#define BUF_SIZE 150
#define COUNT(x) (int)(sizeof x / sizeof *x)
/*
 * NOTE: not implemented yet, it's meant to be used for the spacing between
 *       the distro logo and the fields information
 */
#define REPEAT(str, times)                                                                                             \
    {                                                                                                                  \
        for (int i = 0; i < times; i++) {                                                                              \
            printf("%s", str);                                                                                         \
        }                                                                                                              \
        puts("");                                                                                                      \
    }

void version(void);

/* memory.c */
void *xmalloc(size_t size);
void xfree(void *ptr);

/* lua_api.c */
void start_lua(const char *config_file_path);
void stop_lua(void);
char *get_configuration_file_path(void);
int get_table_size(const char *table);
int table_contains_string(const char *table, const char *key);

// Get options
int get_option_boolean(const char *opt);
const char *get_option_string(const char *opt);
lua_Number get_option_number(const char *opt);
const char *get_subtable_string(const char *table, int index);

// Set options
int set_table_boolean(const char *key, int value);
int set_table_string(const char *key, const char *value);
int set_table_number(const char *key, lua_Number value);
int set_table_subtable(const char *key);
int set_subtable_string(const char *table, const char *key);
void init_options(void);

#endif
