project(
    'pgquery',[ 'vala', 'c'],
    version: '0.1.0',
    default_options: ['buildtype=release', 'prefix=/usr'],
)

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
]

sources = files(
    'src/pg_query.vala',
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
add_project_arguments(['--pkg', 'libpg_query'], language: 'vala')

cc = meson.get_compiler('c')
lib_path = meson.current_source_dir() / 'libpg_query'
libpg_query = cc.find_library('pg_query', required: true, dirs: lib_path)

pgquery_vala = library('pgquery-vala', sources,
    dependencies: dependencies + [libpg_query],
    include_directories: include_directories('libpg_query/include'),
    install: true,
    install_dir: [true, true, true]
)

install_headers(
    'libpg_query/include/pg_query.h',
)

pgquery_vala_dep = declare_dependency(
    include_directories: include_directories('libpg_query/include'),
    link_with: pgquery_vala,
    dependencies: dependencies,
)

pkgconfig = import('pkgconfig')

pkgconfig.generate(
    version: '0.1.0',
    name: 'pgquery-vala',
    description: 'A Vala wrapper for libpgquery.',
    libraries: pgquery_vala
)


split_test = executable('split_test', 'test/split_test.vala',
    dependencies: [dependencies],
    link_with: pgquery_vala,
    # vala_args: ['--ccode' ,'--vapidir', vapi_dir, '--pkg', 'libpg_query'],
    install: false,
)


split_test_strict = executable('split_test_strict', 'test/split_test_strict.vala',
    dependencies: [dependencies],
    link_with: pgquery_vala,
    # vala_args: ['--ccode' ,'--vapidir', vapi_dir, '--pkg', 'libpg_query'],
    install: false,
)

test('split-test', split_test)
test('split-test', split_test_strict)