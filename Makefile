# commands
PLAYBOOK=ansible-playbook

# playbooks
CREATE_PLAYBOOK=configure-mft-domain.yml
STCLUSTER_PLAYBOOK=setup-stserver-cluster.yml
REMOVE_PLAYBOOK=remove-mft-domain.yml
START_SERVICES_PLAYBOOK=start_mft_services.yml
STOP_SERVICES_PLAYBOOK=stop_mft_services.yml

# set ansible debug mode on if DEBUG is passed through
PLAYBOOK_DEBUG ?= 
ifdef DEBUG
PLAYBOOK_DEBUG = -vvvv
endif
# restart mftservices
restart-service: stop-service start-service

# configure
execute: inventory-check  build

download-mft-roles:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) download_mft_roles.yaml -i inventories/$(ENV_NAME) --extra-vars "env_name=$(ENV_NAME)"
	
inventory-check:
	ansible-inventory -i inventories/$(ENV_NAME)/aws_ec2.yml --graph
# Task "inventory-check":  inventory-check will output the current list of inventory 
# hosts that are generated from the dynamic ec2 inventory plugin

check:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) $(CREATE_PLAYBOOK) -i inventories/$(ENV_NAME) --check  --extra-vars "env_name=$(ENV_NAME)"
# Task "build": runs the main playbook code with given env config to configure
# a MFT full domain setup (running domain with all parts connected).

build:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) $(CREATE_PLAYBOOK) -i inventories/$(ENV_NAME) --extra-vars "env_name=$(ENV_NAME)"
# Task "build": runs the main playbook code with given env config to configure
# a MFT full domain setup (running domain with all parts connected).

start-service:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) $(START_SERVICES_PLAYBOOK) -i inventories/$(ENV_NAME) --extra-vars "env_name=$(ENV_NAME)"
# Task "build": runs the main playbook code with given env config to configure
# a MFT full domain setup (running domain with all parts connected).

stop-service:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) $(STOP_SERVICES_PLAYBOOK) -i inventories/$(ENV_NAME) --extra-vars "env_name=$(ENV_NAME)"
# Task "build": runs the main playbook code with given env config to configure
# a MFT full domain setup (running domain with all parts connected).

remove:
	$(PLAYBOOK) $(PLAYBOOK_DEBUG) $(REMOVE_PLAYBOOK) -i inventories/$(ENV_NAME) --extra-vars "env_name=$(ENV_NAME)"
# Task "build": runs the main playbook code with given env config to configure
# a MFT full domain setup (running domain with all parts connected).