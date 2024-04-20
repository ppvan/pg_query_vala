project('pgquery', ['vala', 'c'], version: '0.1.0')

cc = meson.get_compiler('c')
libpg_query_sys = cc.find_library(
    'pg_query',
    has_headers: 'pg_query.h',
    dirs: ['/usr/local/lib/', '/usr/lib']
    # Assume that libpg_query is installed in /usr/local, which is default in v16 upstream but may depend on your distribution
)

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    libpg_query_sys,
]

# foobar_dep = declare_dependency (sources: lib_target)

sources = files(
    'src/pg_query.vala',
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
add_project_arguments(['--pkg', 'libpg_query'], language: 'vala')


pgquery_vala = library(
    'pgquery-vala',
    sources,
    dependencies: dependencies,
    build_rpath: '/usr/local/lib',
    install: true,
    install_dir: [true, true, true],
)

pkgconfig = import('pkgconfig')

pkgconfig.generate(
    version: '0.1.0',
    name: 'pgquery-vala',
    description: 'A Vala wrapper for libpgquery.',
    libraries: pgquery_vala,
)


split_test = executable(
    'split_test',
    'test/split_test.vala',
    dependencies: [dependencies],
    link_with: pgquery_vala,
    install: false,
)


split_test_strict = executable(
    'split_test_strict',
    'test/split_test_strict.vala',
    dependencies: [dependencies],
    link_with: pgquery_vala,
    # vala_args: ['--ccode' ,'--vapidir', vapi_dir, '--pkg', 'libpg_query'],
    install: false,
)

test('split-test', split_test)
test('split-test', split_test_strict)
