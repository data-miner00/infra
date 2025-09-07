Use Azure PowerShell to deploy the resources

```
$ResourceGroup = "myRG"

az group create --name $ResourceGroup
az group deployment create --resource-group $ResourceGroup --template-file ./main.bicep --mode Complete
```

To delete a resource group

```
az group delete --resource-group $ResourceGroup --yes
```

## Resources

- [Azure Bicep Crash Course | Step by Step | All in One](https://www.youtube.com/watch?v=mKG5d9rnaYg)
- [Bicep Docs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Templates](https://github.com/Azure/azure-quickstart-templates)
- [Fundamentals of Bicep](https://learn.microsoft.com/en-us/training/paths/fundamentals-bicep/)
