package utils

import (
	"encoding/yaml"
	"strings"
	"uuid"
)

// #Checksum computes a checksum for the given object.
//
// usage:
// hash: (#Checksum & {$in: {foo: "bar"}}).$out
#Checksum: this={
	$in:  _
	$out: strings.Split(uuid.SHA1(uuid.ns.DNS, yaml.Marshal(this.$in)), "-")[0]
}
