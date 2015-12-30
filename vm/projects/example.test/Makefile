all: net1 net2 net3

net1:
	echo '=== Building hosts for 192.168.10.0/24 netblock ==='
	for vm in 192.168.10.*; do \
	  echo ">>> Building host $$vm"; \
	  cd $$vm; \
	  vagrant up; \
	  cd ..; \
	done

net2:
	echo '=== Building hosts for 172.16.10.0/24 netblock ==='
	for vm in 172.16.10.*; do \
	  echo ">>> Building host $$vm"; \
	  cd $$vm; \
	  vagrant up; \
	  cd ..; \
	done

net3:
	echo '=== Building hosts for 10.0.10.0/24 netblock ==='
	for vm in 10.0.10.*; do \
	  echo ">>> Building host $$vm"; \
	  cd $$vm; \
	  vagrant up; \
	  cd ..; \
	done

destroy: destroy1 destroy2 destroy3

destroy1:
	echo '=== Destroying VMs for 192.168.10.0/24 netblock ==='
	for vm in 192.168.10.*; do \
	  echo ">>> Destroying $$vm"; \
	  cd $$vm; \
	  vagrant destroy -f; \
	  cd ..; \
	done

destroy2:
	echo '=== Destroying VMs for 172.16.10.0/24 netblock ==='
	for vm in 172.16.10.*; do \
	  echo ">>> Destroying $$vm"; \
	  cd $$vm; \
	  vagrant destroy -f; \
	  cd ..; \
	done

destroy3:
	echo '=== Destroying VMs for 10.0.10.0/24 netblock ==='
	for vm in 10.0.10.*; do \
	  echo ">>> Destroying $$vm"; \
	  cd $$vm; \
	  vagrant destroy -f; \
	  cd ..; \
	done
