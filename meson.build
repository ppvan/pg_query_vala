project('pgquery', 'vala', 'c')

subdir('lib')

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    pg_query_dep,
]

sources = files(
    'src/pg_query.vala',
    # 'src/main.vala',
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
add_project_arguments(['--pkg', 'libpg_query'], language: 'vala')

pgquery_vala = library('pgquery-vala', sources,
    dependencies: dependencies,
    install: true,
    install_dir: [true, true, true]
)

pgquery_vala_dep = declare_dependency(
    include_directories: include_directories('.'),
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

exe_files = files(
    'src/main.vala'
)


executable('driver', [exe_files, sources],
    dependencies: [dependencies],
    vala_args: ['--ccode' ,'--vapidir', vapi_dir, '--pkg', 'libpg_query'],
    install: false,
)
