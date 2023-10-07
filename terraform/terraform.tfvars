#cidr_blocks_var = ["10.20.12.0/24", "10.20.13.0/24"]  # list of string

#cidr_blocks_var = [                                    #list of objects
#    {cidr_block = "10.1.2.0/24", name = "dev_vpc1"}, 
#    {cidr_block = "10.2.3.0/24", name = "dev_vpc2"}
#]

vpc_cidr_block = ["10.140.0.0/24"]
instance_ip = "10.140.0.5"
avail_zone = "ru-central1-b"
env_prefix = ["jenkins",
              "nexus",
              "nginx"]
              
ipaddr_blocks = ["10.129.0.10",
                 "10.129.0.11",
                 "10.129.0.12",    
                 "10.129.0.20"]
hostname_blocks = ["jenkins",
                    "nexus",
                    "nginx"]



