
# ElasticLab

This project is meant to provide a simple but vulnerable domain environment for practicing threat hunting. The goal is to be able to attack and break the systems while also being able to easily redeploy the environment and get back to a working state quickly.

It is based on the GOAD project by Orange-cyberdefense, specifically the light version to help save on resources. This project also includes a basic Elastic 8 stack configured without security. Logs from the 2 domain controllers and 1 file server should automatically populate into elastic and be visible in Kibana. 

It should go without saying that this project should NOT be used in a production environment. It is very open and can be easily attacked. 

Refer to the GOAD project for details on the included vulnerabilities as well as network maps. 






## Installation

This project assumes you are running Debian/Ubuntu based host with at least 16GB of memory, 100GB of available storage, and at least a 6 core cpu. 

All commands and virtual machines were tested on a Debian 12 host with the latest updates installed.

After cloning this repo run the following command from the scripts folder to get everything the host ready for the lab. 

``` ./host-prep.sh``` 

This will install the following prerequisites required for the lab to properly work. 

- Vagrant
- vagrant-reload & vagrant-vbguest plugins
- winrm, winrm-fs, & winrm-elevated ruby gems
- vim 
- VirtualBox 
- python3-pip
- ansible

In addition to the above script a Kali VM needs to be installed in VirtualBox. Kali is needed to run attacks against the evnironment and generate logs for review in Elastic.

The virtual machine can be downloaded from
- [Kali Pre-built VirtualBox Image](https://cdimage.kali.org/kali-2023.4/kali-linux-2023.4-virtualbox-amd64.7z)

Instructions for importing the VM can be found at
- [Kali VirtualBox Documentation](https://www.kali.org/docs/virtualization/import-premade-virtualbox/)

## Deployment

Once the prerequisites have been installed you can deploy the lab using the vagrant-create-lab.sh script in the scripts folder. 

```./vagrant-create-lab.sh```

This will create 4 virtual machines in VirtualBox
- DC01 (Kingslanding - 192.168.56.10)
- DC02 (Winterfell - 192.168.56.11)
- SRV02 (CastleBlack - 192.168.56.22)
- Elastic (elastic - 192.168.56.30)

Once deployed, the servers can be accessed through the VirtualBox GUI. 

To access Kibana open a browser on your host machine and head to 192.168.56.30:5601. 

The initial deployment will take a while to finish since there are a number of large downdloads and processing that is required. After this initial deployment future deployments will be much faster. If you find you have broken your lab and need to start over simply run the vagrant-destroy-all and vagrant-create-lab scripts again. The files will not need to be downloaded again unless you manually delete them from Vagrant or through VirtualBox.

## Login Info
All machines can be access with the user name ```vagrant``` and password ```vagrant```

## Additional Scripts

These scripts assume that the only vagrant machines running in VirtualBox are those created by this project. If you are running additional machines then you will have to suspend, resume, and destroy machines using individual vagrant commands. 

```./vagrant-suspend-all.sh``` suspend all vagrant machines. 

```./vagrant-resume-all.sh``` resumes all vagrant machines.

```./vagrant-destroy-all.sh``` destroys all vagrant machines.


## FAQ

#### Question 1: Why am I not seeing logs in Kibana's Dicover tab?

There are a few reasons you may not be seeing logs in Kibana. 

- It can take a few minutes for the servers to fully load and begin shipping logs. Wait at least 10 minutes after all machines have started and check again. 

- Double check the time picker in Kibana. I recommend starting with Last 30 seconds for a quicker refresh time.

- Double check that winlogbeat-* is the selected data view.

#### Question 2: When deploying or reloading DC01,DC02, or SRV02, it appears to be stuck with a Warning: Remote connection disconnect. Retrying... message. How do I fix this?

This can happen sometimes for reasons I have not yet been able to figure out. You can move past this message by pressing Ctrl+C. The scrpit will continue without issue and everything will still work. 

#### Question 3: When deploying or reloading the elastic vm I get the error: warning authentication failure. retrying.... How do I fix this?

This is caused by a corrupt or otherwiase invalid SSH key provided by Vagrant. 

To fix this press Ctrl+C to move past that portion of the script. Once the script has finished, open the elastic vm command line through the VirtualBox GUI and run the following command.

```wget -O .ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/master.keys/vagrant.pub```

After that command has finished you can return to the host command line and run 

```vagrant reload```

This should fix the issue.


## Documentation

Here are some links to helpful documentation for vagrant and elastic

- [Vagrant Documentation](https://developer.hashicorp.com/vagrant/docs)

- [Vagrant Cheat Sheet](https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4)

- [Elasticsearch Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)

- [Kibana Guide](https://www.elastic.co/guide/en/kibana/current/index.html)




## Acknowledgements

 - [GOAD by Orange-Cyberdefense](https://github.com/Orange-Cyberdefense/GOAD)