FROM centos:8

VOLUME /collectd
RUN mkdir /RPMS

RUN yum -y update && yum install -y git epel-release && yum install -y mock rpm-build spectool fedpkg && yum clean all
RUN rpmdev-setuptree
RUN git clone https://github.com/centos-opstools/collectd ~/rpmbuild/SOURCES/

COPY entrypoint-build-rpm.sh /build-rpm.sh
RUN chmod +x /build-rpm.sh

ENTRYPOINT ["/build-rpm.sh"]
