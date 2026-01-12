metadata description = 'Example of creating a custom type in Bicep'

param id string
param name string
param email string

@description('The user type schema')
@export()
type User = {
  @description('The unique identifier for the user')
  id: string

  @description('The name of the user')
  @maxLength(50)
  name: string

  @description('The email address of the user')
  email: string
}

output userTypeExample User = {
  id: id
  name: name
  email: email
}
