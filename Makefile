# This make file is used to create a tarball that can be sideloaded onto
# training machines that don't have git installed.

# By far, the largest files in this archive are the .box files which are
# already compressed so we don't bother compressing the resulting tarball.

tarball:
	tar cpvf vm.tar -X ./exclude ./vm 
