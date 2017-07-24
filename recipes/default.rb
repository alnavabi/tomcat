# install open JDK 7 package

package 'java-1.7.0-openjdk-devel'

# add user and group for chef

group 'chef' do

  action :create

end

user 'chef' do

  group 'chef'

end


# get and extract binaries


remote_file '/tmp/apache-tomcat-8.0.45.tar.gz' do

  source 'http://mirror.reverse.net/pub/apache/tomcat/tomcat-8/v8.0.45/bin/apache-tomcat-8.0.45.tar.gz'

end



directory '/opt/tomcat' do

  action :create

  recursive true

end



execute 'extract_tomcat' do

  command 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

  cwd '/tmp'

end


execute 'chgrp -R chef /opt/tomcat/conf'



#directory '/opt/tomcat/conf' do

#  group 'chef'

#  mode '0474'

#end

execute 'chmod g+rwx conf' do
  cwd '/opt/tomcat'
end


execute 'chmod g+r conf/*' do

  cwd '/opt/tomcat'

end



execute 'chown -R chef webapps/ work/ temp/ logs/ conf/' do

  cwd '/opt/tomcat'

end




template '/etc/systemd/system/tomcat.service' do

  source 'tomcat.service.erb'

end



execute 'systemctl daemon-reload'



service 'tomcat' do

  action [:start, :enable]

end

