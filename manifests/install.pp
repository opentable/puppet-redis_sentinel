# == Class redis_sentinel::intall
#
class redis_sentinel::install {

  case $facts['service_provider'] {
    'upstart': {
      file { '/etc/init/redis-sentinel.conf':
        ensure   => $redis_sentinel::ensure,
        mode     => '0444',
        owner    => 'root',
        group    => 'root',
        content => template('redis_sentinel/upstart.erb'),
      }
      file { '/etc/init.d/redis-sentinel':
       ensure => 'link',
       target => '/lib/init/upstart-job',
       force  => true,
      }
    }
    'systemd': {
      file { "redis_sentinel_service":
        ensure  => present,
        path    => "/etc/systemd/system/redis-sentinel.service",
        content => template('redis_sentinel/systemd.erb'),
        mode    => '0755',
        replace => true,
      }
    }
    default: {
      file { '/etc/init.d/redis-sentinel':
        ensure   => $redis_sentinel::ensure,
        mode     => '0555',
        owner    => 'root',
        group    => 'root',
        content => template('redis_sentinel/init.erb'),
      }
    }
  }
}
