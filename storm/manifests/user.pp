# storm::user
# ===========================
#
define storm::user (
  String $user_name,
  Integer $user_uid = 1000,
  Integer $user_gid = 1000,
) {

  group { $user_name:
    gid => $user_gid,
  }

  user { $user_name:
    ensure => present,
    uid    => $user_uid,
    gid    => $user_name,
  }
}