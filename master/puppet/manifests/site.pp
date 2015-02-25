node 'node01.example.com' {
include helloworld
}

node default {
include hellopuppet
exec {'remotedesktop':
	command => 'C:\Windows\System32\netsh.exe advfirewall
	firewall set rule froup="remote desktop" new enable=Yes',
	refreshonly => true,
} 

exec {'zabbixagent':
	command => 'C:\Windows\System32\netsh.exe advfirewall
firewall and rule name="Zabbix Agent" dir=in action=allow protocol=
TCP localport=10050',
	refreshonly => true,
}

#include windows-iis::firewall
#include windows-iis::files

  Dism { ensure => present, }
  dism { 'IIS-WebServerRole': } ->
  dism { 'IIS-WebServer': }

#dotnet { 'dotnet45': version => '4.5' }
vcsrepo { "C:/nopcommerce":
  ensure   => latest,
  provider => git,
  source   => 'git@github.com:kishore-mohan/nopcommerce-puppet.git',
  revision => 'master',
}


iis_apppool {'nopcommerce':
	ensure => present,
	managedpipelinemode => 'Integrated',
	managedruntimeversion => 'v4.0',
}

iis_site {'nopcommerce':
	ensure => present,
	bindings => ["http/*:3000:"],
}

iis_app {'nopcommerce/':
	ensure => present,
	applicationpool => 'nopcommerce',
}

iis_vdir {'nopcommerce/':
	ensure => present,
	iis_app => 'nopcommerce/',
	physicalpath => 'C:\nopcommerce',
}




}
