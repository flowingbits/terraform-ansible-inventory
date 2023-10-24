# terraform-ansible-inventory

Simple module to render Ansible inventory file

## Usage

Include the module:

```terraform
module "ansible-inventory" {
  source = "github.com/humanbits/terraform-ansible-inventory"
}
```

The module allows you to declare the following blocks: hosts, groups, group_vars, group_children:

```terraform
module "ansible-inventory" {
  source = "github.com/humanbits/terraform-ansible-inventory"

  hosts = {
    "host1" = {
      ansible_host : "10.0.0.1"
      other_host1_var : "other_host1_var_value"
    }
    "host2" = {
      ansible_host : "10.0.0.2"
      other_host2_var : "other_host2_var_value"
    }
    "host3" = {
      ansible_host : "10.0.0.3"
      other_host1_var : "other_host1_var_value"
    }
    "host4" = {
      ansible_host : "10.0.0.4"
      other_host2_var : "other_host2_var_value"
    }
  }

  groups = {
    group1 = ["host1", "host2"]
    group2 = ["host3", "host4"]
  }

  group_vars = {
    group1 = {
      group1_var1 : "group1_var1_value"
      group1_var2 : "group1_var2_value"
    }
  }

  group_children = {
    other_group = ["group1", "group2"]
  }
}
```

And outputs the inventory string:

```terraform
output "ansible-inventory" {
  value = module.ansible-inventory.result
}
```

The above example will produce the following inventory output:

```ini
host1 ansible_host=10.0.0.1 other_host1_var=other_host1_var_value
host2 ansible_host=10.0.0.2 other_host2_var=other_host2_var_value
host3 ansible_host=10.0.0.3 other_host1_var=other_host1_var_value
host4 ansible_host=10.0.0.4 other_host2_var=other_host2_var_value


[group1]
host1
host2

[group2]
host3
host4



[group1:vars]
group1_var1=group1_var1_value
group1_var2=group1_var2_value



[other_group:children]
group1
group2
```