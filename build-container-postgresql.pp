$cont = "postdb4"
$ip = "192.168.2.218"

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

exec { "create_usr_scripts":
    command => "/bin/mkdir -p /usr/scripts",
    creates => "/usr/scripts"
}
file { "/usr/scripts/docker-container":
    ensure => "present",
    mode   => 750,
}
exec { "create_script":
    command => "echo '/bin/sh /usr/scripts/docker-container $cont \$1' > /usr/scripts/$cont",
}
file { "/usr/scripts/$cont":
    ensure => "present",
    mode   => 750,
}
exec { "data_$cont":
    command => "/bin/mkdir -p /postgresdata/$cont",
    creates => "/postgresdata/$cont"
}
exec { "add_ip":
    command => "ifconfig eth0 add $ip netmask 255.255.255.0",
}
exec { "create_pginstance":
    command => "docker run -t -d --name='$cont' -p $ip:32:22 -p $ip:5432:5432 -v /postgresdata/$cont/:/var/lib/pgsql/9.3/ nickvth/postgresql93 /usr/bin/supervisord -c /etc/supervisord.conf",
}
