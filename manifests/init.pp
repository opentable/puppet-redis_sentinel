# == Class: redis_sentinel
#
# Full description of class redis_sentinel here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class redis_sentinel (
  $ensure         = 'present',
  $redis_bin_dir  = '/usr',
  $config_file    = '/etc/redis/redis-sentinel.conf',
  $service_name   = 'redis-sentinel',
  $service_ensure = 'running',
  $service_enable = true,
  $user           = 'redis',
  $group          = 'redis',
) {

  validate_bool($service_enable)

  class { 'redis_sentinel::install': } ->
  class { 'redis_sentinel::config': } ~>
  class { 'redis_sentinel::service': } ->
  Class['redis_sentinel']

}
