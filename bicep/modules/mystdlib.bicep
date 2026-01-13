metadata description = 'A custom standard library containing common functions'

@description('Adds two number together.')
@export()
func add(num1 int, num2 int) int => num1 + num2

@description('Constructs the storage account name')
@export()
func constructStorageAccountName(prefix 'com' | 'org', componentName string, environment string) string => '${prefix}${componentName}${environment}'
