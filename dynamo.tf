resource "aws_dynamodb_table" "dynamodb"{
	name="mywebsite"
	hash_key="email"
	
	attribute=[
	{
		name="email"
		type="s"
	}	
	]

}