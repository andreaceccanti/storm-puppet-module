# @summary StoRM WebDAV params class
#
class storm::webdav::params (
) inherits storm::params {

  $user_name = $storm::params::user_name
  $user_uid = $storm::params::user_uid
  $user_gid = $storm::params::user_gid

  $storage_root_dir = $storm::params::storage_root_dir
  $log_dir = $storm::params::log_dir

  $storage_areas = lookup('storm::webdav::params::storage_areas', Array[Storm::Webdav::StorageArea], undef, [])

  $config_dir = lookup('storm::webdav::params::config_dir', String, undef, '/etc/storm/webdav')
  $hostcert_dir = lookup('storm::webdav::params::hostcert_dir', String, undef, '/etc/grid-security/storm-webdav')
  $oauth_issuers = lookup('storm::webdav::params::oauth_issuers', Array[Storm::Webdav::OAuthIssuer], undef, [])
  $hostnames = lookup('storm::webdav::params::hostnames', Array[String], undef, [])

  $http_port = lookup('storm::webdav::params::http_port', Integer, undef, 8085)
  $https_port = lookup('storm::webdav::params::https_port', Integer, undef, 8443)

  $trust_anchors_dir = lookup('storm::webdav::params::trust_anchors_dir', String, undef, '/etc/grid-security/certificates')
  $trust_anchors_refresh_interval = lookup('storm::webdav::params::trust_anchors_refresh_interval', Integer, undef, 86400)

  $max_concurrent_connections = lookup('storm::webdav::params::max_concurrent_connections', Integer, undef, 300)
  $max_queue_size = lookup('storm::webdav::params::max_queue_size', Integer, undef, 900)
  $connector_max_idle_time = lookup('storm::webdav::params::connector_max_idle_time', Integer, undef, 30000)

  $vo_map_files_enable = lookup('storm::webdav::params::vo_map_files_enable', Boolean, undef, false)
  $vo_map_files_config_dir = lookup('storm::webdav::params::vo_map_files_config_dir', String, undef, '/etc/storm/webdav/vo-mapfiles.d')
  $vo_map_files_refresh_interval = lookup('storm::webdav::params::vo_map_files_refresh_interval', Integer, undef, 21600)

  $tpc_max_connections = lookup('storm::webdav::params::tpc_max_connections', Integer, undef, 50)
  $tpc_verify_checksum = lookup('storm::webdav::params::tpc_verify_checksum', Boolean, undef, false)

  $jvm_opts = lookup('storm::webdav::params::jvm_opts', String, undef, '-Xms256m -Xmx512m -Djava.io.tmpdir=/var/lib/storm-webdav/work')

  $authz_server_enable = lookup('storm::webdav::params::authz_server_enable', Boolean, undef, false)
  $authz_server_issuer = lookup('storm::webdav::params::authz_server_issuer', String, undef, 'https://storm.example:8443')
  $authz_server_max_token_lifetime_sec = lookup('storm::webdav::params::authz_server_max_token_lifetime_sec', Integer, undef, 43200)
  $authz_server_secret = lookup('storm::webdav::params::authz_server_secret', String, undef, 'areasonablesecretlongerthan256bits')
  $require_client_cert = lookup('storm::webdav::params::require_client_cert', Boolean, undef, false)

  $use_conscrypt = lookup('storm::webdav::params::use_conscrypt', Boolean, undef, true)
  $tpc_use_conscrypt = lookup('storm::webdav::params::tpc_use_conscrypt', Boolean, undef, true)
  $enable_http2 = lookup('storm::webdav::params::enable_http2', Boolean, undef, true)

  $debug = lookup('storm::webdav::params::debug', Boolean, undef, false)
  $debug_port = lookup('storm::webdav::params::debug_port', Integer, undef, 1044)
  $debug_suspend = lookup('storm::webdav::params::debug_suspend', Boolean, undef, false)
}
