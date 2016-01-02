
exec { 'apt-update':                    # exec resource named 'apt-update'
  command => '/usr/bin/apt-get update'  # command this resource will run
}

# install apache2 package
package { 'apache2':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure apache2 service is running
service { 'apache2':
  ensure => running,
}

file { "/var/www/html/index.html":
    ensure  => absent,
  }

package { 'php5':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure index.php file exists
file { '/var/www/html/index.php':
  ensure => file,
  content => '<?php  phpinfo(); ?>',    # phpinfo code
  require => Package['apache2'],        # require 'apache2' package before creating
} 
