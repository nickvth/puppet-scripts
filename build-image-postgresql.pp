# put this somewhere global, like site.pp
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

package { "git":
    ensure => "installed"
}
exec { "create_usr_scripts_build":
    command => "/bin/mkdir -p //usr/scripts/docker-build",
    creates => "/usr/scripts/docker-build"
}
exec { "git":
    command => "git clone https://github.com/nickvth/dockerfile-postgresql.git /usr/scripts/docker-build/",
}
exec { "build":
    command => "docker build --force-rm=true -t nickvth/postgresql93test /usr/scripts/docker-build/",
}
