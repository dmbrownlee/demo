## The Network+ lab environment

# Getting Started
## Configure the virtualization environment for a specific study group (Network+)
If you haven't already done so, run the ```setup``` script in the parent directory with ```networkplus``` as the only argument to setup this virtual lab environment.  See the ```README.md``` in [demo](https://github.com/dmbrownlee/demo/README.md) for more details. For example,
> ```cd ~/demo && ./setup networkplus```

## Import the network model into GNS3
After the GNS3 is installed in the step above, launch GNS3 and wait for the GNS3 VM in VirtualBox to fully boot. Once the VM is booted, download and import [this GNS3 portable project](labnetwork.gns3project) and then follow these steps:
1. Start all the Open vSwitch switches
1. Start the ```control``` docker container (it is in the provisioning network and connected to the Internet2)
1. Open control's console (you may have to wait 30 seconds for the container to fully start) and run</br>
    <code>cd && git clone https://github.com/dmbrownlee/networkplus.test.git</code></br>to fetch the ansible playbooks needed to configure your network devices.
1. Configure the ```control``` container first with</br>
    <code>cd ~/networkplus.test && ansible-playbook -K site.yml</code></br>
    (you will be prompted for your password).

> Note: This network model is still a work in progress

## The Network+ virtual lab environment
![Diagram of Network+ virtual lab environment](labnetwork.png "Network+ Virtual Lab Environment")
