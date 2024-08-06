package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformModule(t *testing.T) {
    terraformOptions := &terraform.Options{
        // Path to where your Terraform code is located
        TerraformDir: "..",

        // Variables to pass to the Terraform code using -var options
        Vars: map[string]interface{}{
            // Example: "region": "us-west-2",
        },
    }

    // Initialize and apply the Terraform code
    defer terraform.Destroy(t, terraformOptions) // Destroy resources at the end of the test
    terraform.InitAndApply(t, terraformOptions)

    // Run `terraform output` to get the value of an output variable
    vpcId := terraform.Output(t, terraformOptions, "vpc_id")

    // Validate your Terraform code
    assert.NotEmpty(t, vpcId)
}
