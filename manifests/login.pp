#
# temporalment sense opcions, planxo config tal cual
#
# puppet2sitepp @tomcatlogin
define tomcat::login(
                      $servicename   = $name,
                      $catalina_base = "/opt/${name}",
                      $ensure        = 'present',
                    ) {

  if ! defined(Class['tomcat'])
  {
    fail('You must include the tomcat base class before using any tomcat defined resources')
  }

  if($servicename!=undef)
  {
    $serviceinstance=Tomcat::Instance::Service[$servicename]
  }
  else
  {
    $serviceinstance=undef
  }

  file { "${catalina_base}/conf/login.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File["${catalina_base}/conf"],
    notify  => $serviceinstance,
    content => template("${module_name}/conf/login.erb"),
  }

}
