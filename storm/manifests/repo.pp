# @summary Choose which StoRM repository you want to intall and enable. Also a custom list of repository URL can be specified.
#
# @param installed
#   The list of repositories that have to be installed. Allowed values are `stable`, `beta` and `nightly`. Optional.
#
# @param enabled
#   The list of repositories that have to be enabled. Allowed values are `stable`, `beta` and `nightly`. Optional.
#
# @param customs
#   A list of repository URLs that have to be installed and enabled. Optional.
#
# @example Install all the repositories and enable only nightly repo as follow:
#   class { 'storm::repo':
#     enabled => ['nightly'],
#   }
class storm::repo (
  Array[Enum['stable', 'beta', 'nightly']] $installed = ['stable', 'beta', 'nightly'],
  Array[Enum['stable', 'beta', 'nightly']] $enabled = ['stable'],
  Array[Struct[{ name => String, url => String }]] $customs = [],
) {

  $yum_config_manager = '/bin/yum-config-manager'

  if ($installed.length > 0) {

    $el = $::operatingsystemmajrelease
    $repo_dir = '/etc/yum.repos.d'

    $installed.each | $name | {

      $repo_url = "https://repo.cloud.cnaf.infn.it/repository/storm/${name}/storm-${name}-centos${el}.repo"
      $repo_name = "storm-${name}-centos${el}"

      exec {"download-${name}-repo-el${el}":
        command => "${yum_config_manager} --add-repo=${repo_url}",
        creates => "${repo_dir}/${repo_name}.repo",
      }
      if $name in $enabled {
        exec {"enable-${name}-repo-el${el}":
          command => "${yum_config_manager} --enable ${repo_name}",
        }
      } else {
        exec {"disable-${name}-repo-el${el}":
          command => "${yum_config_manager} --disable ${repo_name}",
        }
      }
    }
  }

  $customs.each | $repo | {
    $name = $repo[name]
    $url = $repo[url]
    exec {"download-custom-${name}-repo":
      command => "${yum_config_manager} --add-repo=${url}",
    }
  }
}
