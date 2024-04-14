project(
    'pgquery',[ 'vala', 'c'],
    version: '0.1.0',
    default_options: ['buildtype=release', 'prefix=/usr'],
)

cc = meson.get_compiler('c')
libpg_query_sys = cc.find_library('pg_query', has_headers: 'pg_query.h', required: false)

if not libpg_query_sys.found()
    libpg_query = custom_target(
        'libpg_query',
        input: 'libpg_query/Makefile',
        output: 'libpg_query.a',
        command: ['script.sh', meson.current_build_dir(), meson.current_source_dir()],
        build_always: true,
        install: false,
    )
endif

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    libpg_query_sys
]

# foobar_dep = declare_dependency (sources: lib_target)

sources = files(
    'src/pg_query.vala',
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
add_project_arguments(['--pkg', 'libpg_query'], language: 'vala')

if libpg_query_sys.found()
    pgquery_vala = library('pgquery-vala', sources,
        dependencies: dependencies,
        include_directories: include_directories('libpg_query'),
        install: true,
        install_dir: [true, true, true]
    )
else
    pgquery_vala = library('pgquery-vala', sources,
        dependencies: dependencies,
        include_directories: include_directories('libpg_query'),
        install: true,
		link_with: libpg_query,
        install_dir: [true, true, true]
    )

    install_headers(
        'libpg_query/pg_query.h',
    )
endif

# pgquery_vala_dep = declare_dependency(
#     include_directories: include_directories('libpg_query/include'),
#     link_with: pgquery_vala,
#     dependencies: dependencies,
# )

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