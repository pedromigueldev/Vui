project(
  'vui',
  ['c', 'vala'],
  version: '0.1.0',
  meson_version: '>= 0.62.0',
  default_options: [
    'warning_level=2',
    'werror=false',
  ],
)

vui_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
  dependency('gee-0.8'),
]

pkgconfig = import('pkgconfig')
i18n = import('i18n')
gnome = import('gnome')

subdir('src')
subdir('po')

if get_option('demo')
  subdir('data')
  subdir('demo')
endif

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)
