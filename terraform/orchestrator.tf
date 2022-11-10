# MODULES ORCHESTRATOR

module "network" {
    source                = "./modules/network"
    vpc_cidr              = "${var.vpc_cidr}"
    vpc_sn_az1            = "${var.vpc_sn_az1}"
    vpc_sn_az2            = "${var.vpc_sn_az2}"
    vpc_sn_az1_pub_cidr   = "${var.vpc_sn_az1_pub_cidr}"
    vpc_sn_az2_pub_cidr   = "${var.vpc_sn_az2_pub_cidr}"
    vpc_sn_az1_priv1_cidr = "${var.vpc_sn_az1_priv1_cidr}"
    vpc_sn_az2_priv1_cidr = "${var.vpc_sn_az2_priv1_cidr}"
    vpc_sn_az1_priv2_cidr = "${var.vpc_sn_az1_priv2_cidr}"
    vpc_sn_az2_priv2_cidr = "${var.vpc_sn_az2_priv2_cidr}"
}

module "front" {
    source                         = "./modules/front"
    front_ec2_lt_name              = "${var.front_ec2_lt_name}"
    front_ec2_lt_ami               = "${var.front_ec2_lt_ami}"
    front_ec2_lt_instance_type     = "${var.front_ec2_lt_instance_type}"
    front_ec2_lt_ssh_key_name      = "${var.front_ec2_lt_ssh_key_name}"
    front_ec2_lb_name              = "${var.front_ec2_lb_name}"
    front_ec2_lb_tg_name           = "${var.front_ec2_lb_tg_name}"
    front_ec2_asg_name             = "${var.front_ec2_asg_name}"
    front_ec2_asg_desired_capacity = "${var.front_ec2_asg_desired_capacity}"
    front_ec2_asg_min_size         = "${var.front_ec2_asg_min_size}"
    front_ec2_asg_max_size         = "${var.front_ec2_asg_max_size}"
    network_vpc_cidr               = "${var.vpc_cidr}"
    network_vpc_id                 = "${module.network.vpc_id}"
    network_vpc_sn_az1_pub_id      = "${module.network.vpc_sn_az1_pub_id}"
    network_vpc_sn_az2_pub_id      = "${module.network.vpc_sn_az2_pub_id}"
}

module "back" {
    source                        = "./modules/back"
    back_ec2_lt_name              = "${var.back_ec2_lt_name}"
    back_ec2_lt_ami               = "${var.back_ec2_lt_ami}"
    back_ec2_lt_instance_type     = "${var.back_ec2_lt_instance_type}"
    back_ec2_lt_ssh_key_name      = "${var.back_ec2_lt_ssh_key_name}"
    back_ec2_lb_name              = "${var.back_ec2_lb_name}"
    back_ec2_lb_tg_name           = "${var.back_ec2_lb_tg_name}"
    back_ec2_asg_name             = "${var.back_ec2_asg_name}"
    back_ec2_asg_desired_capacity = "${var.back_ec2_asg_desired_capacity}"
    back_ec2_asg_min_size         = "${var.back_ec2_asg_min_size}"
    back_ec2_asg_max_size         = "${var.back_ec2_asg_max_size}"
    network_vpc_sn_az1_pub_cidr   = "${var.vpc_sn_az1_pub_cidr}"
    network_vpc_sn_az2_pub_cidr   = "${var.vpc_sn_az2_pub_cidr}"
    network_vpc_id                = "${module.network.vpc_id}"
    network_vpc_sn_az1_priv1_id   = "${module.network.vpc_sn_az1_priv1_id}"
    network_vpc_sn_az2_priv1_id   = "${module.network.vpc_sn_az2_priv1_id}"
}

module "data" {
    source                        = "./modules/data"
    rds_identifier                = "${var.rds_identifier}"
    rds_sn_group_name             = "${var.rds_sn_group_name}"
    rds_param_group_name          = "${var.rds_param_group_name}"
    rds_multi_az                  = "${var.rds_multi_az}"
    rds_dbname                    = "${var.rds_dbname}"
    rds_dbuser                    = "${var.rds_dbuser}"
    rds_dbpassword                = "${var.rds_dbpassword}"
    network_vpc_sn_az1_priv1_cidr = "${var.vpc_sn_az1_priv1_cidr}"
    network_vpc_sn_az2_priv1_cidr = "${var.vpc_sn_az2_priv1_cidr}"
    network_vpc_id                = "${module.network.vpc_id}"
    network_vpc_sn_az1_priv2_id   = "${module.network.vpc_sn_az1_priv2_id}"
    network_vpc_sn_az2_priv2_id   = "${module.network.vpc_sn_az2_priv2_id}"
}