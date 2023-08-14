
script = meson.current_source_dir() / 'script.sh'

pgquery = custom_target('pgquery',
    command : [script, meson.current_build_dir(), meson.current_source_dir()],
    # input: 'nothing.txt',
    # capture:true,
    build_by_default: true,
    output: 'libpg_query.a',
)

cc = meson.get_compiler('c')
pgquery_lib = cc.find_library(
    'pg_query',
    required: true,
    dirs: [meson.current_source_dir()],
    static: true,
)

pgquery_inc = include_directories('.')
pg_query_dep = declare_dependency(
    include_directories : [pgquery_inc],
    dependencies : [pgquery_lib],
)

