
cc = meson.get_compiler('c')
pgquery_lib = cc.find_library(
    'pg_query',
    required: false,
    dirs: [meson.current_source_dir()],
    static: true,
)

pgquery_inc = include_directories('.')
pg_query_dep = declare_dependency(
    include_directories : [pgquery_inc],
    dependencies : [pgquery_lib],
)

