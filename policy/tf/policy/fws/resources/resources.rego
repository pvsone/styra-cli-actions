package policy.fws.resources


enforce[decision] {  
  resource := vpc_resources[_]
  cidr := resource.values.cidr_block
  not net.cidr_contains("172.16.0.0/12", cidr)
  
  message := sprintf("VPC '%v' cidr_block invalid. Must be in range '172.16.0.0/12'", [resource.name])

  decision := {
    "allowed": false,
    "message": message
  }
}

vpc_resources[resource] {
	resource := planned_resources[_]
	resource.type = "fakewebservices_vpc"
}

planned_resources[resource] {
	some module
	resource := input.planned_values[module].resources[_]
}
