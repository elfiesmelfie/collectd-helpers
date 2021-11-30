#! /bin/bash
# This is intended to be run in a container, and build an RPM of collectd, using the version of collectd that is checked out in the mounted volume at /collectd

cd /collectd
COLLECTD_VERSION=$(./version-gen.sh)
cd -

# The contents of the mounted directory are copied into a dir with a version suffix, since this is what is expected inthe spec file
cp -r /collectd /collectd-$COLLECTD_VERSION

# The dir is archived and put into SOURCES, so that it will be used to build the package, instead of a version on github.
tar -cvjSf /root/rpmbuild/SOURCES/collectd-$COLLECTD_VERSION.tar.bz2 /collectd-$COLLECTD_VERSION

# Override version in collectd.spec so that (i) the package will be named properly, (ii) the correct sources will be sought
sed -i "s/^Version: .*$/Version: ${COLLECTD_VERSION}/g" /root/rpmbuild/SOURCES/collectd.spec
sed -i "s/--without-included-ltdl/--disable-ras/g" /root/rpmbuild/SOURCES/collectd.spec

mock -r epel-8-x86_64 --init
mock -r epel-8-x86_64 --resultdir /root/rpmbuild/SRPMS/ --buildsrpm --spec /root/rpmbuild/SOURCES/collectd.spec  --sources /root/rpmbuild/SOURCES/
mock -r epel-8-x86_64 --resultdir /root/rpmbuild/RPMS/ rebuild /root/rpmbuild/SRPMS/collectd-$COLLECTD_VERSION*.src.rpm

cp -r /root/rpmbuild/RPMS/*.rpm /RPMS
rm /RPMS/*.src.rpm
