# put this somewhere global, like site.pp
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

package { "git":
    ensure => "installed"
}
exec { "create_usr_scripts":
    command => "/bin/mkdir -p //usr/scripts",
    creates => "/usr/scripts"
}
exec { "git":
    command => "git clone https://github.com/nickvth/docker.git /usr/scripts/",
}
file { "/usr/scripts/docker-container":
    ensure => "present",
    mode   => 750,
}
