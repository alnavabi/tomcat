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